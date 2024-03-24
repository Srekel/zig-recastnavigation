const std = @import("std");

const zignav = @import("zignav");
const Recast = zignav.Recast;
const DetourNavMesh = zignav.DetourNavMesh;
const DetourNavMeshBuilder = zignav.DetourNavMeshBuilder;
const DetourNavMeshQuery = zignav.DetourNavMeshQuery;
const DetourStatus = zignav.DetourStatus;
const DetourTileCache = zignav.DetourTileCache;
const DetourTileCacheBuilder = zignav.DetourTileCacheBuilder;

const recast_util = @import("recast_util.zig");
const detour_util = @import("detour_util.zig");

pub fn run_demo() !void {
    var nav_ctx: Recast.rcContext = undefined;
    nav_ctx.init(false);
    defer nav_ctx.deinit();

    const game_config: recast_util.GameConfig = .{
        .indoors = true,
    };
    const config = recast_util.generateConfig(game_config);

    const vertices = [_]f32{
        0,  1, 0,
        10, 1, 0,
        10, 1, 10,
        0,  1, 10,
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

    const FLAG_AREA_GROUND = 0;
    const FLAG_POLY_WALK = 1;

    // As per other sample,
    // This value specifies how many layers (or "floors") each navmesh tile is expected to have.
    const EXPECTED_LAYERS_PER_TILE = 4;

    for (0..@intCast(poly_mesh.*.npolys)) |pi| {
        if (poly_mesh.*.areas[pi] == Recast.WALKABLE_AREA) {
            poly_mesh.*.areas[pi] = FLAG_AREA_GROUND;
            poly_mesh.*.flags[pi] = FLAG_POLY_WALK;
        }
    }

    const max_edge_error = 1.3;
    // const ts = (int)m_tileSize;
    const tw = @divFloor(config.width + config.tileSize - 1, config.tileSize);
    const th = @divFloor(config.height + config.tileSize - 1, config.tileSize);

    // Init Tile Cache
    const tile_cache = DetourTileCache.dtAllocTileCache();
    if (tile_cache == null) {
        return error.OutOfMemory;
    }

    var tcparams: DetourTileCache.dtTileCacheParams = .{
        .orig = config.bmin,
        .cs = config.cs,
        .ch = config.ch,
        .width = config.tileSize,
        .height = config.tileSize,
        .walkableHeight = @floatFromInt(config.walkableHeight),
        .walkableRadius = @floatFromInt(config.walkableRadius),
        .walkableClimb = @floatFromInt(config.walkableClimb),
        .maxSimplificationError = max_edge_error,
        .maxTiles = tw * th * EXPECTED_LAYERS_PER_TILE,
        .maxObstacles = 128,
    };

    const tile_alloc = DetourTileCacheBuilder.getCopyCompressor();
    const tile_compressor = DetourTileCacheBuilder.getCopyCompressor();
    const mesh_processor: [*c]DetourTileCache.dtTileCacheMeshProcess = null;
    const status_tc = tile_cache.*.init__Overload2(&tcparams, tile_alloc, tile_compressor, mesh_processor);

    if (DetourStatus.dtStatusFailed(status_tc)) {
        return error.FailedNavQueryInit;
    }
    // Create first navmesh
    const nav_mesh = DetourNavMesh.dtAllocNavMesh();
    defer DetourNavMesh.dtFreeNavMesh(nav_mesh);
    try detour_util.createNavMesh(poly_mesh, poly_mesh_detail, config, nav_mesh);

    // Attempt path find
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

    try detour_util.findPath(
        query,
        &[3]f32{ 1, 1, 1 },
        &[3]f32{ 9, 1, 9 },
        &[3]f32{ 0.1, 0.1, 0.1 },
        &filter,
        &path,
    );
}
