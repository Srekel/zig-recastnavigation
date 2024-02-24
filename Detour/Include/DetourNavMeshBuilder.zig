// auto generated by c2z
const std = @import("std");
//const cpp = @import("cpp");

/// Represents the source data used to build an navigation mesh tile.
/// @UntranspiledVerbatimLineCommentCommand detour
pub const dtNavMeshCreateParams = extern struct {
    /// The polygon mesh vertices. [(x, y, z) * #vertCount] [Unit: vx]
    verts: [*c]const c_ushort,
    /// The number vertices in the polygon mesh. [Limit: >= 3]
    vertCount: c_int,
    /// The polygon data. [Size: #polyCount * 2 * #nvp]
    polys: [*c]const c_ushort,
    /// The user defined flags assigned to each polygon. [Size: #polyCount]
    polyFlags: [*c]const c_ushort,
    /// The user defined area ids assigned to each polygon. [Size: #polyCount]
    polyAreas: [*c]const u8,
    /// Number of polygons in the mesh. [Limit: >= 1]
    polyCount: c_int,
    /// Number maximum number of vertices per polygon. [Limit: >= 3]
    nvp: c_int,
    /// The height detail sub-mesh data. [Size: 4 * #polyCount]
    detailMeshes: [*c]const c_uint,
    /// The detail mesh vertices. [Size: 3 * #detailVertsCount] [Unit: wu]
    detailVerts: [*c]const f32,
    /// The number of vertices in the detail mesh.
    detailVertsCount: c_int,
    /// The detail mesh triangles. [Size: 4 * #detailTriCount]
    detailTris: [*c]const u8,
    /// The number of triangles in the detail mesh.
    detailTriCount: c_int,
    /// Off-mesh connection vertices. [(ax, ay, az, bx, by, bz) * #offMeshConCount] [Unit: wu]
    offMeshConVerts: [*c]const f32,
    /// Off-mesh connection radii. [Size: #offMeshConCount] [Unit: wu]
    offMeshConRad: [*c]const f32,
    /// User defined flags assigned to the off-mesh connections. [Size: #offMeshConCount]
    offMeshConFlags: [*c]const c_ushort,
    /// User defined area ids assigned to the off-mesh connections. [Size: #offMeshConCount]
    offMeshConAreas: [*c]const u8,
    /// The permitted travel direction of the off-mesh connections. [Size: #offMeshConCount]
    ///
    /// 0 = Travel only from endpoint A to endpoint B.
    ///
    /// #DT_OFFMESH_CON_BIDIR = Bidirectional travel.
    offMeshConDir: [*c]const u8,
    /// The user defined ids of the off-mesh connection. [Size: #offMeshConCount]
    offMeshConUserID: [*c]const c_uint,
    /// The number of off-mesh connections. [Limit: >= 0]
    offMeshConCount: c_int,
    /// The user defined id of the tile.
    userId: c_uint,
    /// The tile's x-grid location within the multi-tile destination mesh. (Along the x-axis.)
    tileX: c_int,
    /// The tile's y-grid location within the multi-tile destination mesh. (Along the z-axis.)
    tileY: c_int,
    /// The tile's layer within the layered destination mesh. [Limit: >= 0] (Along the y-axis.)
    tileLayer: c_int,
    /// The minimum bounds of the tile. [(x, y, z)] [Unit: wu]
    bmin: [3]f32,
    /// The maximum bounds of the tile. [(x, y, z)] [Unit: wu]
    bmax: [3]f32,
    /// The agent height. [Unit: wu]
    walkableHeight: f32,
    /// The agent radius. [Unit: wu]
    walkableRadius: f32,
    /// The agent maximum traversable ledge. (Up/Down) [Unit: wu]
    walkableClimb: f32,
    /// The xz-plane cell size of the polygon mesh. [Limit: > 0] [Unit: wu]
    cs: f32,
    /// The y-axis cell height of the polygon mesh. [Limit: > 0] [Unit: wu]
    ch: f32,
    /// True if a bounding volume tree should be built for the tile.
    /// @see The BVTree is not normally needed for layered navigation meshes.
    buildBvTree: bool,
};

extern fn _1_dtCreateNavMeshData_(params: [*c]dtNavMeshCreateParams, outData: [*c][*c]u8, outDataSize: [*c]c_int) bool;
/// Builds navigation mesh tile data from the provided tile creation data.
/// @UntranspiledVerbatimLineCommentCommand detour
///
///  @param[in] params 		Tile creation data.
///  @param[out] outData 		The resulting tile data.
///  @param[out] outDataSize 	The size of the tile data array.
/// @see True if the tile data was successfully created.
pub const dtCreateNavMeshData = _1_dtCreateNavMeshData_;

extern fn _1_dtNavMeshHeaderSwapEndian_(data: [*c]u8, dataSize: c_int) bool;
/// Swaps the endianess of the tile data's header (#dtMeshHeader).
///  @param[in,out] data 		The tile data array.
///  @param[in] dataSize 	The size of the data array.
pub const dtNavMeshHeaderSwapEndian = _1_dtNavMeshHeaderSwapEndian_;

extern fn _1_dtNavMeshDataSwapEndian_(data: [*c]u8, dataSize: c_int) bool;
/// Swaps endianess of the tile data.
///  @param[in,out] data 		The tile data array.
///  @param[in] dataSize 	The size of the data array.
pub const dtNavMeshDataSwapEndian = _1_dtNavMeshDataSwapEndian_;
