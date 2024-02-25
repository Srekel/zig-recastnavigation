const std = @import("std");
const zignav = @import("zignav");
const Recast = zignav.Recast;
const recast_util = @import("recast_util.zig");

pub fn run_demo() !void {
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
        0,  0,  0,
        10, 0,  0,
        10, 10, 0,
        0,  10, 0,
    };

    const triangles = [_]i32{
        0, 1, 2,
        1, 2, 3,
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
}
