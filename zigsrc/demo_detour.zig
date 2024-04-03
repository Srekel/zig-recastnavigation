const std = @import("std");
const zignav = @import("zignav");
const Recast = zignav.Recast;
const DetourNavMesh = zignav.DetourNavMesh;
const DetourNavMeshBuilder = zignav.DetourNavMeshBuilder;
const DetourNavMeshQuery = zignav.DetourNavMeshQuery;
const DetourStatus = zignav.DetourStatus;
const DetourPathCorridor = zignav.DetourPathCorridor;
const recast_util = @import("recast_util.zig");
const detour_util = @import("detour_util.zig");

pub fn run_demo() !void {

    // Create Recast Navmesh

    var nav_ctx: Recast.rcContext = undefined;
    nav_ctx.init(false);
    defer nav_ctx.deinit();

    const game_config: recast_util.GameConfig = .{
        .indoors = true,
    };
    const config = recast_util.generateConfig(game_config);

    nav_ctx.resetTimers();
    nav_ctx.startTimer(Recast.rcTimerLabel.RC_TIMER_TOTAL);

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

    nav_ctx.stopTimer(Recast.rcTimerLabel.RC_TIMER_TOTAL);
    const total_build_time = nav_ctx.getAccumulatedTime(Recast.rcTimerLabel.RC_TIMER_TOTAL);
    _ = total_build_time;

    // Create Detour navmesh

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
    try detour_util.initNavMeshFromPolyMesh(poly_mesh, poly_mesh_detail, config, nav_mesh);

    // Find a path

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

    // Follow path

    const speed = 5; // 5 m/s
    const delta_time = 0.1; // 10hz

    var corridor: DetourPathCorridor.dtPathCorridor = undefined;
    corridor.init();
    if (!corridor.init__Overload2(256)) {
        return error.CorridorInit;
    }

    var pos = path.start_pos;
    corridor.reset(path.start_poly, &path.start_pos);
    corridor.setCorridor(&path.end_pos, &path_polys, @intCast(path.path_length));

    const max_corners = 64;
    var corner_verts: [max_corners][3]f32 = undefined;
    var corner_flags: [max_corners]u8 = undefined;
    var corner_polys: [max_corners]DetourNavMesh.dtPolyRef = undefined;
    for (0..100) |_| {
        const corner_count = corridor.findCorners(@ptrCast(&corner_verts), &corner_flags, &corner_polys, max_corners, query, &filter);
        if (corner_count == 0) {
            break;
        }

        const to_target = .{
            corner_verts[0][0] - pos[0],
            corner_verts[0][1] - pos[1],
            corner_verts[0][2] - pos[2],
        };
        const length = std.math.sqrt(to_target[0] * to_target[0] + to_target[1] * to_target[1] + to_target[2] * to_target[2]);
        if (length < 0.01) {
            break;
        }
        const dir = .{
            to_target[0] / length,
            to_target[1] / length,
            to_target[2] / length,
        };

        pos[0] += dir[0] * speed * delta_time;
        pos[1] += dir[1] * speed * delta_time;
        pos[2] += dir[2] * speed * delta_time;

        if (!corridor.movePosition(&pos, query, &filter)) {
            break;
        }
    }
}
