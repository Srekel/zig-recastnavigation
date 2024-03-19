const std = @import("std");
const zignav = @import("zignav");
const Recast = zignav.Recast;
const DetourNavMesh = zignav.DetourNavMesh;
const DetourNavMeshBuilder = zignav.DetourNavMeshBuilder;
const DetourNavMeshQuery = zignav.DetourNavMeshQuery;
const DetourStatus = zignav.DetourStatus;
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

    // var start_ref: DetourNavMesh.dtPolyRef = undefined;
    // var end_ref: DetourNavMesh.dtPolyRef = undefined;
    // var query: DetourNavMeshQuery.dtNavMeshQuery = undefined;

    const total_build_time = nav_ctx.getAccumulatedTime(Recast.rcTimerLabel.RC_TIMER_TOTAL);
    _ = total_build_time;

    var nav_mesh_params: DetourNavMeshBuilder.dtNavMeshCreateParams = .{
        .verts = poly_mesh.*.verts,
        .vertCount = poly_mesh.*.nverts,
        .polys = poly_mesh.*.polys,
        .polyAreas = poly_mesh.*.areas,
        .polyFlags = poly_mesh.*.flags,
        .polyCount = poly_mesh.*.npolys,
        .nvp = poly_mesh.*.nvp,
        .detailMeshes = poly_mesh_detail.*.meshes,
        .detailVerts = poly_mesh_detail.*.verts,
        .detailVertsCount = poly_mesh_detail.*.nverts,
        .detailTris = poly_mesh_detail.*.tris,
        .detailTriCount = poly_mesh_detail.*.ntris,
        .offMeshConVerts = undefined,
        .offMeshConRad = undefined,
        .offMeshConDir = undefined,
        .offMeshConAreas = undefined,
        .offMeshConFlags = undefined,
        .offMeshConUserID = undefined,
        .offMeshConCount = 0,
        .walkableHeight = @floatFromInt(config.walkableHeight),
        .walkableRadius = @floatFromInt(config.walkableRadius),
        .walkableClimb = @floatFromInt(config.walkableClimb),
        .cs = config.cs,
        .ch = config.ch,
        .buildBvTree = true,
        .userId = 0,
        .tileX = 0,
        .tileY = 0,
        .tileLayer = 0,
        .bmin = .{ 0, 0, 0 },
        .bmax = .{ 10, 10, 0 },
    };

    var nav_data: [*c]u8 = null;
    var nav_data_size: c_int = 0;
    if (!DetourNavMeshBuilder.dtCreateNavMeshData(&nav_mesh_params, &nav_data, &nav_data_size)) {
        return error.FailedBuildingDetourMesh;
    }

    const nav_mesh = DetourNavMesh.dtAllocNavMesh();
    defer DetourNavMesh.dtFreeNavMesh(nav_mesh);

    const status = nav_mesh.*.init__Overload3(nav_data, nav_data_size, DetourNavMesh.dtTileFlags.DT_TILE_FREE_DATA.bits);
    if (DetourStatus.dtStatusFailed(status)) {
        return error.FailedNavMeshInit;
    }

    // status =
}
