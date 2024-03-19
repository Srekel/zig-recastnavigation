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
        0,  1, 0,
        10, 1, 0,
        10, 1, 10,
        0,  1, 10,
    };

    const triangles = [_]i32{
        0, 2, 1,
        0, 3, 2,
    };

    var heightfield = Recast.rcAllocHeightfield();
    var compact_heightfield = Recast.rcAllocCompactHeightfield();
    var contour_set = Recast.rcAllocContourSet();
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

    // Allocations completed, start work

    try recast_util.rasterizePolygonSoup(config, &nav_ctx, heightfield, &vertices, &triangles);

    try recast_util.partitionWalkableSurfaceToRegions(config, &nav_ctx, heightfield, compact_heightfield);

    // Will get freed by defer but we *can* do it at this point.
    Recast.rcFreeHeightField(heightfield);
    heightfield = null;

    if (!Recast.rcBuildContours(
        &nav_ctx,
        compact_heightfield,
        config.maxSimplificationError,
        config.maxEdgeLen,
        contour_set,
        .{},
    )) {
        // &nav_ctx.log(RC_LOG_ERROR, "buildNavigation: Could not create contours.");
        return error.BuildContours;
    }

    try recast_util.buildPolygonMesh(
        config,
        &nav_ctx,
        contour_set,
        compact_heightfield,
        poly_mesh,
        poly_mesh_detail,
    );

    // Can free these at this point.
    Recast.rcFreeCompactHeightfield(compact_heightfield);
    compact_heightfield = null;
    Recast.rcFreeContourSet(contour_set);
    contour_set = null;

    nav_ctx.stopTimer(Recast.rcTimerLabel.RC_TIMER_TOTAL);

    // Show performance stats.
    // duLogBuildTimes(*&nav_ctx, &nav_ctx.getAccumulatedTime(Recast.rcTimerLabel.RC_TIMER_TOTAL));
    // &nav_ctx.log(RC_LOG_PROGRESS, ">> Polymesh: %d vertices  %d polygons", m_pmesh->nverts, m_pmesh->npolys);

    const total_build_time = nav_ctx.getAccumulatedTime(Recast.rcTimerLabel.RC_TIMER_TOTAL);
    _ = total_build_time;
}
