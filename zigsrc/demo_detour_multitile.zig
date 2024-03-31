const std = @import("std");
const zignav = @import("zignav");
const Recast = zignav.Recast;
const DetourNavMesh = zignav.DetourNavMesh;
const DetourNavMeshBuilder = zignav.DetourNavMeshBuilder;
const DetourNavMeshQuery = zignav.DetourNavMeshQuery;
const DetourStatus = zignav.DetourStatus;
const recast_util = @import("recast_util.zig");
const detour_util = @import("detour_util.zig");

pub fn run_demo() !void {
    var nav_ctx: Recast.rcContext = undefined;
    nav_ctx.init(false);
    defer nav_ctx.deinit();

    const game_config: recast_util.GameConfig = .{
        .indoors = true,
        .tile_size = 64,
    };
    const config = recast_util.generateConfig(game_config);

    nav_ctx.resetTimers();
    nav_ctx.startTimer(Recast.rcTimerLabel.RC_TIMER_TOTAL);

    const vertices = [_]f32{
        0,  1, 0,
        64, 1, 0,
        64, 1, 64,
        0,  1, 64,
    };
    // const vertices = [_]f32{
    //     -10, 1, -10,
    //     164, 1, -10,
    //     164, 1, 164,
    //     -10, 1, 164,
    // };

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
    defer Recast.rcFreePolyMesh(poly_mesh);
    defer Recast.rcFreePolyMeshDetail(poly_mesh_detail);

    try recast_util.buildFullNavMesh(
        config,
        &nav_ctx,
        &vertices,
        &triangles,
        heightfield,
        compact_heightfield,
        contour_set,
        poly_mesh,
        poly_mesh_detail,
    );

    nav_ctx.stopTimer(Recast.rcTimerLabel.RC_TIMER_TOTAL);
    const total_build_time = nav_ctx.getAccumulatedTime(Recast.rcTimerLabel.RC_TIMER_TOTAL);
    _ = total_build_time;

    const FLAG_AREA_GROUND = 0;
    const FLAG_POLY_WALK = 1;

    for (0..@intCast(poly_mesh.*.npolys)) |pi| {
        if (poly_mesh.*.areas[pi] == Recast.WALKABLE_AREA) {
            poly_mesh.*.areas[pi] = FLAG_AREA_GROUND;
            poly_mesh.*.flags[pi] = FLAG_POLY_WALK;
        }
    }

    const nav_mesh = DetourNavMesh.dtAllocNavMesh();
    defer DetourNavMesh.dtFreeNavMesh(nav_mesh);

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

    const tile = try detour_util.createTileFromPolyMesh(poly_mesh, poly_mesh_detail, config, 0, 0);

    var tile_ref: DetourNavMesh.dtPolyRef = 0;
    const status_tile = nav_mesh.*.addTile(tile.data, tile.data_size, DetourNavMesh.dtTileFlags.DT_TILE_FREE_DATA.bits, 0, &tile_ref);
    if (DetourStatus.dtStatusFailed(status_tile)) {
        return error.FailedTileAdd;
    }
    if (tile_ref == 0) {
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

    // try detour_util.findPath(
    //     query,
    //     &[3]f32{ 1, 1, 1 },
    //     &[3]f32{ 9, 1, 9 },
    //     &[3]f32{ 0.1, 0.1, 0.1 },
    //     &filter,
    //     &path,
    // );

    const tile_factor = @as(f32, @floatFromInt(config.tileSize)) * config.cs;
    _ = tile_factor; // autofix
    // const tile_factor = config.tileSize * @as(c_int, @intFromFloat(config.cs));

    const tile2 = try detour_util.createTileFromPolyMesh(
        poly_mesh,
        poly_mesh_detail,
        config,
        1,
        // @intFromFloat(64 / tile_factor),
        0,
    );

    var tile_ref2: DetourNavMesh.dtPolyRef = 0;
    const status_tile2 = nav_mesh.*.addTile(tile2.data, tile2.data_size, DetourNavMesh.dtTileFlags.DT_TILE_FREE_DATA.bits, 0, &tile_ref2);
    if (DetourStatus.dtStatusFailed(status_tile2)) {
        return error.FailedTileAdd;
    }
    if (tile_ref2 == 0) {
        return error.FailedTileAddNoRef;
    }

    try detour_util.findPath(
        query,
        &[3]f32{ 71, 1, 1 },
        &[3]f32{ 9, 1, 9 },
        &[3]f32{ 0.1, 0.1, 0.1 },
        &filter,
        &path,
    );
}
