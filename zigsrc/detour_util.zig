const std = @import("std");
const math = std.math;
const zignav = @import("zignav");
const Recast = zignav.Recast;
const DetourNavMesh = zignav.DetourNavMesh;
const DetourNavMeshBuilder = zignav.DetourNavMeshBuilder;
const DetourNavMeshQuery = zignav.DetourNavMeshQuery;
const DetourStatus = zignav.DetourStatus;

// For more on all this, see here:
// https://recastnav.com/md_Docs__1_Introducation.html

pub fn initNavMeshFromPolyMesh(
    poly_mesh: [*c]const Recast.rcPolyMesh,
    poly_mesh_detail: [*c]const Recast.rcPolyMeshDetail,
    config: Recast.rcConfig,
    nav_mesh: [*c]DetourNavMesh.dtNavMesh,
) !void {
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
        .bmin = config.bmin,
        .bmax = config.bmax,
    };

    var nav_data: [*c]u8 = null;
    var nav_data_size: c_int = 0;
    if (!DetourNavMeshBuilder.dtCreateNavMeshData(&nav_mesh_params, &nav_data, &nav_data_size)) {
        return error.FailedBuildingDetourMesh;
    }

    const status = nav_mesh.*.init__Overload3(nav_data, nav_data_size, DetourNavMesh.dtTileFlags.DT_TILE_FREE_DATA.bits);
    if (DetourStatus.dtStatusFailed(status)) {
        return error.FailedNavMeshInit;
    }
}

pub const Path = struct {
    start_poly: DetourNavMesh.dtPolyRef = undefined,
    start_pos: [3]f32 = undefined,
    end_poly: DetourNavMesh.dtPolyRef = undefined,
    end_pos: [3]f32 = undefined,
    poly_buffer: []DetourNavMesh.dtPolyRef,
    path_length: c_int = 0,
};

pub fn findPath(
    query: [*c]const DetourNavMeshQuery.dtNavMeshQuery,
    start: [*c]const f32,
    end: [*c]const f32,
    half_extents: [*c]const f32,
    filter: [*c]const DetourNavMeshQuery.dtQueryFilter,
    path: *Path,
) !void {
    var status = query.*.findNearestPoly(start, half_extents, filter, &path.start_poly, &path.start_pos);

    if (DetourStatus.dtStatusFailed(status)) {
        return error.FailedNavQueryPoly;
    }

    status = query.*.findNearestPoly(end, half_extents, filter, &path.end_poly, &path.end_pos);

    if (DetourStatus.dtStatusFailed(status)) {
        return error.FailedNavQueryPoly;
    }

    status = query.*.findPath(
        path.start_poly,
        path.end_poly,
        &path.start_pos,
        &path.end_pos,
        filter,
        path.poly_buffer.ptr,
        &path.path_length,
        @intCast(path.poly_buffer.len),
    );
    if (DetourStatus.dtStatusFailed(status)) {
        return error.FailedNavQueryPath;
    }
}
