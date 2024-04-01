const std = @import("std");
const zignav = @import("zignav");
const Recast = zignav.Recast;
const DetourNavMesh = zignav.DetourNavMesh;
const DetourNavMeshBuilder = zignav.DetourNavMeshBuilder;
const DetourNavMeshQuery = zignav.DetourNavMeshQuery;
const DetourStatus = zignav.DetourStatus;
const recast_util = @import("recast_util.zig");
const detour_util = @import("detour_util.zig");

// See this discussion:
// https://github.com/recastnavigation/recastnavigation/discussions/659
// Also the Sample_TileMesh demo and the Sample_TempObstacles demo.

pub fn run_demo() !void {
    var nav_ctx: Recast.rcContext = undefined;
    nav_ctx.init(false);
    defer nav_ctx.deinit();

    const nav_mesh = DetourNavMesh.dtAllocNavMesh();
    defer DetourNavMesh.dtFreeNavMesh(nav_mesh);

    const tile_mesh = try buildTileMesh(&nav_ctx, .{ 0, 0, 0 });
    const config = tile_mesh.config;
    defer Recast.rcFreePolyMesh(tile_mesh.poly_mesh);
    defer Recast.rcFreePolyMeshDetail(tile_mesh.poly_mesh_detail);

    // Calculations taken from sample
    // Max tiles and max polys affect how the tile IDs are calculated.
    // There are 22 bits available for identifying a tile and a polygon.
    const EXPECTED_LAYERS_PER_TILE = 4;
    const max_edge_error = 1.3;
    _ = max_edge_error; // autofix

    const tw = @divFloor(config.width + config.tileSize - 1, config.tileSize);
    const th = @divFloor(config.height + config.tileSize - 1, config.tileSize);
    const tile_bits: u5 = @intCast(@min(
        std.math.log2_int(u32, std.math.ceilPowerOfTwo(u32, @as(u32, @intCast(tw * th)) * EXPECTED_LAYERS_PER_TILE) catch unreachable),
        14,
    ));
    const poly_bits = 22 - tile_bits;
    const max_tiles = @as(u32, 1) << tile_bits;
    const max_polys_per_tile = @as(u32, 1) << poly_bits;

    const navmesh_params = DetourNavMesh.dtNavMeshParams{
        .orig = config.bmin,
        .tileWidth = @floatFromInt(config.tileSize),
        .tileHeight = @floatFromInt(config.tileSize),
        .maxTiles = @intCast(max_tiles),
        .maxPolys = @intCast(max_polys_per_tile),
    };
    const status_nm = nav_mesh.*.init__Overload2(&navmesh_params);
    if (DetourStatus.dtStatusFailed(status_nm)) {
        return error.FailedNavMeshInit;
    }

    const tile = try detour_util.createTileFromPolyMesh(tile_mesh.poly_mesh, tile_mesh.poly_mesh_detail, config, 0, 0);

    var tile_ref: DetourNavMesh.dtPolyRef = 0;
    const status_tile = nav_mesh.*.addTile(tile.data, tile.data_size, DetourNavMesh.dtTileFlags.DT_TILE_FREE_DATA.bits, 0, &tile_ref);
    if (DetourStatus.dtStatusFailed(status_tile)) {
        return error.FailedTileAdd;
    }
    if (tile_ref == 0) {
        return error.FailedTileAddNoRef;
    }

    // const tile_factor = @as(f32, @floatFromInt(config.tileSize)) * config.cs;

    const tile_mesh2 = try buildTileMesh(&nav_ctx, .{ 64, 0, 0 });
    defer Recast.rcFreePolyMesh(tile_mesh2.poly_mesh);
    defer Recast.rcFreePolyMeshDetail(tile_mesh2.poly_mesh_detail);

    const tile2 = try detour_util.createTileFromPolyMesh(
        tile_mesh2.poly_mesh,
        tile_mesh2.poly_mesh_detail,
        tile_mesh2.config,
        1,
        // @intFromFloat(64 / tile_factor),
        0,
    );

    // Don't FREE_DATA so that we can remove it and re-add it.
    var tile_ref2: DetourNavMesh.dtPolyRef = 0;
    const status_tile2 = nav_mesh.*.addTile(
        tile2.data,
        tile2.data_size,
        // DetourNavMesh.dtTileFlags.DT_TILE_FREE_DATA.bits,
        0,
        0,
        &tile_ref2,
    );
    if (DetourStatus.dtStatusFailed(status_tile2)) {
        return error.FailedTileAdd;
    }
    if (tile_ref2 == 0) {
        return error.FailedTileAddNoRef;
    }

    const query = DetourNavMeshQuery.dtAllocNavMeshQuery();
    const max_nodes = 2048; // as per solomesh sample
    const status = query.*.init__Overload2(nav_mesh, max_nodes);
    if (DetourStatus.dtStatusFailed(status)) {
        return error.FailedNavQueryInit;
    }

    var filter: DetourNavMeshQuery.dtQueryFilter = undefined;
    filter.init();

    var path_polys: [100]DetourNavMesh.dtPolyRef = undefined;
    var path: detour_util.Path = .{
        .poly_buffer = &path_polys,
    };

    // Within first tile
    try detour_util.findPath(
        query,
        &[3]f32{ 1, 1, 1 },
        &[3]f32{ 9, 1, 9 },
        &[3]f32{ 0.1, 0.1, 0.1 },
        &filter,
        &path,
    );

    // Between the two tiles
    try detour_util.findPath(
        query,
        &[3]f32{ 71, 1, 1 },
        &[3]f32{ 9, 1, 9 },
        &[3]f32{ 0.1, 0.1, 0.1 },
        &filter,
        &path,
    );

    const status_rm = nav_mesh.*.removeTile(tile_ref2, null, 0);
    if (DetourStatus.dtStatusFailed(status_rm)) {
        return error.FailedTileRemove;
    }

    // Within first tile
    try detour_util.findPath(
        query,
        &[3]f32{ 1, 1, 1 },
        &[3]f32{ 9, 1, 9 },
        &[3]f32{ 0.1, 0.1, 0.1 },
        &filter,
        &path,
    );

    _ = nav_mesh.*.addTile(tile2.data, tile2.data_size, DetourNavMesh.dtTileFlags.DT_TILE_FREE_DATA.bits, 0, &tile_ref2);

    // Between the two tiles
    try detour_util.findPath(
        query,
        &[3]f32{ 71, 1, 1 },
        &[3]f32{ 9, 1, 9 },
        &[3]f32{ 0.1, 0.1, 0.1 },
        &filter,
        &path,
    );
}

pub fn buildTileMesh(
    nav_ctx: *Recast.rcContext,
    offset: [3]f32,
) !struct {
    config: Recast.rcConfig,
    poly_mesh: *Recast.rcPolyMesh,
    poly_mesh_detail: *Recast.rcPolyMeshDetail,
} {
    const game_config: recast_util.GameConfig = .{
        .indoors = true,
        .tile_size = 64,
        .offset = offset,
    };
    const config = recast_util.generateConfig(game_config);

    // const vertices = [_]f32{
    //     0 + offset[0],  1, 0 + offset[2],
    //     64 + offset[0], 1, 0 + offset[2],
    //     64 + offset[0], 1, 64 + offset[2],
    //     0 + offset[0],  1, 64 + offset[2],
    // };
    const vertices = [_]f32{
        -10 + offset[0], 1, -10 + offset[2],
        164 + offset[0], 1, -10 + offset[2],
        164 + offset[0], 1, 164 + offset[2],
        -10 + offset[0], 1, 164 + offset[2],
    };

    const triangles = [_]i32{
        0, 2, 1,
        0, 3, 2,
    };

    const heightfield = Recast.rcAllocHeightfield();
    const compact_heightfield = Recast.rcAllocCompactHeightfield();
    const contour_set = Recast.rcAllocContourSet();
    const poly_mesh = Recast.rcAllocPolyMesh();
    const poly_mesh_detail = Recast.rcAllocPolyMeshDetail();
    if (heightfield == null or
        compact_heightfield == null or
        contour_set == null or
        poly_mesh == null or
        poly_mesh_detail == null)
    {
        return error.OutOfMemory;
    }

    defer Recast.rcFreeHeightField(heightfield);
    defer Recast.rcFreeCompactHeightfield(compact_heightfield);
    defer Recast.rcFreeContourSet(contour_set);

    try recast_util.buildFullNavMesh(
        config,
        nav_ctx,
        &vertices,
        &triangles,
        heightfield,
        compact_heightfield,
        contour_set,
        poly_mesh,
        poly_mesh_detail,
    );

    const FLAG_AREA_GROUND = 0;
    const FLAG_POLY_WALK = 1;

    for (0..@intCast(poly_mesh.*.npolys)) |pi| {
        if (poly_mesh.*.areas[pi] == Recast.WALKABLE_AREA) {
            poly_mesh.*.areas[pi] = FLAG_AREA_GROUND;
            poly_mesh.*.flags[pi] = FLAG_POLY_WALK;
        }
    }

    return .{
        .config = config,
        .poly_mesh = poly_mesh,
        .poly_mesh_detail = poly_mesh_detail,
    };
}
