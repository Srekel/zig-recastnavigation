// auto generated by c2z
const std = @import("std");
//const cpp = @import("cpp");

const dtStatus = u32;
const dtTileCacheLayerHeader = anyopaque;

pub const dtObstacleRef = c_uint;

pub const dtCompressedTileRef = c_uint;

/// Flags for addTile
pub const dtCompressedTileFlags = extern struct {
    bits: c_int = 0,

    /// Navmesh owns the tile memory and should free it.
    pub const DT_COMPRESSEDTILE_FREE_DATA: dtCompressedTileFlags = .{ .bits = @as(c_uint, @intCast(1)) };

    // pub usingnamespace cpp.FlagsMixin(dtCompressedTileFlags);
};

pub const dtCompressedTile = extern struct {
    /// Counter describing modifications to the tile.
    salt: c_uint,
    header: *dtTileCacheLayerHeader,
    compressed: [*c]u8,
    compressedSize: c_int,
    data: [*c]u8,
    dataSize: c_int,
    flags: c_uint,
    next: [*c]dtCompressedTile,
};

pub const ObstacleState = extern struct {
    bits: c_int = 0,

    pub const DT_OBSTACLE_EMPTY: ObstacleState = .{ .bits = 0 };
    pub const DT_OBSTACLE_PROCESSING: ObstacleState = .{ .bits = 1 };
    pub const DT_OBSTACLE_PROCESSED: ObstacleState = .{ .bits = 2 };
    pub const DT_OBSTACLE_REMOVING: ObstacleState = .{ .bits = 3 };

    // pub usingnamespace cpp.FlagsMixin(ObstacleState);
};

pub const ObstacleType = extern struct {
    bits: c_int = 0,

    pub const DT_OBSTACLE_CYLINDER: ObstacleType = .{ .bits = 0 };
    /// AABB
    pub const DT_OBSTACLE_BOX: ObstacleType = .{ .bits = 1 };
    /// OBB
    pub const DT_OBSTACLE_ORIENTED_BOX: ObstacleType = .{ .bits = 2 };

    // pub usingnamespace cpp.FlagsMixin(ObstacleType);
};

pub const dtObstacleCylinder = extern struct {
    pos: [3]f32,
    radius: f32,
    height: f32,
};

pub const dtObstacleBox = extern struct {
    bmin: [3]f32,
    bmax: [3]f32,
};

pub const dtObstacleOrientedBox = extern struct {
    center: [3]f32,
    halfExtents: [3]f32,
    ///{ cos(0.5f*angle)*sin(-0.5f*angle); cos(0.5f*angle)*cos(0.5f*angle) - 0.5 }
    rotAux: [2]f32,
};

extern const _1_DT_MAX_TOUCHED_TILES_: *const c_int;
pub const DT_MAX_TOUCHED_TILES = _1_DT_MAX_TOUCHED_TILES_;

pub const dtTileCacheObstacle = extern struct {
    __union_field1: __Union0,
    touched: [8]dtCompressedTileRef,
    pending: [8]dtCompressedTileRef,
    salt: c_ushort,
    type: u8,
    state: u8,
    ntouched: u8,
    npending: u8,
    next: [*c]dtTileCacheObstacle,

    pub const __Union0 = extern union {
        cylinder: dtObstacleCylinder,
        box: dtObstacleBox,
        orientedBox: dtObstacleOrientedBox,
    };
};

pub const dtTileCacheParams = extern struct {
    orig: [3]f32,
    cs: f32,
    ch: f32,
    width: c_int,
    height: c_int,
    walkableHeight: f32,
    walkableRadius: f32,
    walkableClimb: f32,
    maxSimplificationError: f32,
    maxTiles: c_int,
    maxObstacles: c_int,
};

pub const dtTileCacheMeshProcess = extern struct {
    vtable: *const anyopaque,

    extern fn _1_dtTileCacheMeshProcess_deinit_(self: *dtTileCacheMeshProcess) void;
    pub const deinit = _1_dtTileCacheMeshProcess_deinit_;

    extern fn _1_dtTileCacheMeshProcess_process_(self: *dtTileCacheMeshProcess, params: [*c]dtNavMeshCreateParams, polyAreas: [*c]u8, polyFlags: [*c]c_ushort) void;
    pub const process = _1_dtTileCacheMeshProcess_process_;

    // opaques

    const dtNavMeshCreateParams = anyopaque;
};

pub const dtTileCache = extern struct {
    pub const ObstacleRequestAction = extern struct {
        bits: c_int = 0,

        pub const REQUEST_ADD: ObstacleRequestAction = .{ .bits = 0 };
        pub const REQUEST_REMOVE: ObstacleRequestAction = .{ .bits = 1 };

        // pub usingnamespace cpp.FlagsMixin(ObstacleRequestAction);
    };
    
    const MAX_REQUESTS = 64;
    const MAX_UPDATE = 64;

    /// Tile hash lookup size (must be pot).
    m_tileLutSize: c_int,
    /// Tile hash lookup mask.
    m_tileLutMask: c_int,
    /// Tile hash lookup.
    m_posLookup: [*c][*c]dtCompressedTile,
    /// Freelist of tiles.
    m_nextFreeTile: [*c]dtCompressedTile,
    /// List of tiles.
    m_tiles: [*c]dtCompressedTile,
    /// Number of salt bits in the tile ID.
    m_saltBits: c_uint,
    /// Number of tile bits in the tile ID.
    m_tileBits: c_uint,
    m_params: dtTileCacheParams,
    m_talloc: *dtTileCacheAlloc,
    m_tcomp: *dtTileCacheCompressor,
    m_tmproc: [*c]dtTileCacheMeshProcess,
    m_obstacles: [*c]dtTileCacheObstacle,
    m_nextFreeObstacle: [*c]dtTileCacheObstacle,
    m_reqs: [MAX_REQUESTS]ObstacleRequest,
    m_nreqs: c_int,
    m_update: [MAX_UPDATE]dtCompressedTileRef,
    m_nupdate: c_int,

    extern fn _1_dtTileCache_init_(self: *dtTileCache) void;
    pub const init = _1_dtTileCache_init_;

    extern fn _1_dtTileCache_deinit_(self: *dtTileCache) void;
    pub const deinit = _1_dtTileCache_deinit_;

    pub fn getAlloc(self: *dtTileCache) [*c]dtTileCacheAlloc {
        return self.m_talloc;
    }
    pub fn getCompressor(self: *dtTileCache) [*c]dtTileCacheCompressor {
        return self.m_tcomp;
    }
    pub fn getParams(self: *const dtTileCache) [*c]const dtTileCacheParams {
        return &self.m_params;
    }
    pub inline fn getTileCount(self: *const dtTileCache) c_int {
        return self.m_params.maxTiles;
    }
    pub inline fn getTile(self: *const dtTileCache, i: c_int) [*c]const dtCompressedTile {
        return &self.m_tiles[i];
    }
    pub inline fn getObstacleCount(self: *const dtTileCache) c_int {
        return self.m_params.maxObstacles;
    }
    pub inline fn getObstacle(self: *const dtTileCache, i: c_int) [*c]const dtTileCacheObstacle {
        return &self.m_obstacles[i];
    }
    extern fn _1_dtTileCache_getObstacleByRef_(self: *dtTileCache, ref: dtObstacleRef) [*c]const dtTileCacheObstacle;
    pub const getObstacleByRef = _1_dtTileCache_getObstacleByRef_;

    extern fn _1_dtTileCache_getObstacleRef_(self: *const dtTileCache, obmin: [*c]const dtTileCacheObstacle) dtObstacleRef;
    pub const getObstacleRef = _1_dtTileCache_getObstacleRef_;

    extern fn _2_dtTileCache_init_(self: *dtTileCache, params: [*c]const dtTileCacheParams, talloc: *dtTileCacheAlloc, tcomp: *dtTileCacheCompressor, tmproc: [*c]dtTileCacheMeshProcess) dtStatus;
    pub const init__Overload2 = _2_dtTileCache_init_;

    extern fn _1_dtTileCache_getTilesAt_(self: *const dtTileCache, tx: c_int, ty: c_int, tiles: [*c]dtCompressedTileRef, maxTiles: c_int) c_int;
    pub const getTilesAt = _1_dtTileCache_getTilesAt_;

    extern fn _1_dtTileCache_getTileAt_(self: *dtTileCache, tx: c_int, ty: c_int, tlayer: c_int) [*c]dtCompressedTile;
    pub const getTileAt = _1_dtTileCache_getTileAt_;

    extern fn _1_dtTileCache_getTileRef_(self: *const dtTileCache, tile: [*c]const dtCompressedTile) dtCompressedTileRef;
    pub const getTileRef = _1_dtTileCache_getTileRef_;

    extern fn _1_dtTileCache_getTileByRef_(self: *const dtTileCache, ref: dtCompressedTileRef) [*c]const dtCompressedTile;
    pub const getTileByRef = _1_dtTileCache_getTileByRef_;

    extern fn _1_dtTileCache_addTile_(self: *dtTileCache, data: [*c]u8, dataSize: c_int, flags: u8, result: [*c]dtCompressedTileRef) dtStatus;
    pub const addTile = _1_dtTileCache_addTile_;

    extern fn _1_dtTileCache_removeTile_(self: *dtTileCache, ref: dtCompressedTileRef, data: [*c][*c]u8, dataSize: [*c]c_int) dtStatus;
    pub const removeTile = _1_dtTileCache_removeTile_;

    extern fn _1_dtTileCache_addObstacle_(self: *dtTileCache, pos: [*c]const f32, radius: f32, height: f32, result: [*c]dtObstacleRef) dtStatus;
    /// Cylinder obstacle.
    pub const addObstacle = _1_dtTileCache_addObstacle_;

    extern fn _1_dtTileCache_addBoxObstacle_(self: *dtTileCache, bmin: [*c]const f32, bmax: [*c]const f32, result: [*c]dtObstacleRef) dtStatus;
    /// Aabb obstacle.
    pub const addBoxObstacle = _1_dtTileCache_addBoxObstacle_;

    extern fn _2_dtTileCache_addBoxObstacle_(self: *dtTileCache, center: [*c]const f32, halfExtents: [*c]const f32, yRadians: f32, result: [*c]dtObstacleRef) dtStatus;
    /// Box obstacle: can be rotated in Y.
    pub const addBoxObstacle__Overload2 = _2_dtTileCache_addBoxObstacle_;

    extern fn _1_dtTileCache_removeObstacle_(self: *dtTileCache, ref: dtObstacleRef) dtStatus;
    pub const removeObstacle = _1_dtTileCache_removeObstacle_;

    extern fn _1_dtTileCache_queryTiles_(self: *const dtTileCache, bmin: [*c]const f32, bmax: [*c]const f32, results: [*c]dtCompressedTileRef, resultCount: [*c]c_int, maxResults: c_int) dtStatus;
    pub const queryTiles = _1_dtTileCache_queryTiles_;

    extern fn _1_dtTileCache_update_(self: *dtTileCache, dt: f32, navmesh: [*c]dtNavMesh, upToDate: [*c]bool) dtStatus;
    /// Updates the tile cache by rebuilding tiles touched by unfinished obstacle requests.
    ///  @param[in] dt 			The time step size. Currently not used.
    ///  @param[in] navmesh 		The mesh to affect when rebuilding tiles.
    ///  @param[out] upToDate 	Whether the tile cache is fully up to date with obstacle requests and tile rebuilds.
    ///  							If the tile cache is up to date another (immediate) call to update will have no effect;
    ///  							otherwise another call will continue processing obstacle requests and tile rebuilds.
    pub fn update(
        self: *dtTileCache,
        dt: f32,
        navmesh: [*c]dtNavMesh,
        __opt: struct {
            upToDate: [*c]bool = null,
        },
    ) dtStatus {
        return _1_dtTileCache_update_(self, dt, navmesh, __opt.upToDate);
    }

    extern fn _1_dtTileCache_buildNavMeshTilesAt_(self: *dtTileCache, tx: c_int, ty: c_int, navmesh: [*c]dtNavMesh) dtStatus;
    pub const buildNavMeshTilesAt = _1_dtTileCache_buildNavMeshTilesAt_;

    extern fn _1_dtTileCache_buildNavMeshTile_(self: *dtTileCache, ref: dtCompressedTileRef, navmesh: [*c]dtNavMesh) dtStatus;
    pub const buildNavMeshTile = _1_dtTileCache_buildNavMeshTile_;

    extern fn _1_dtTileCache_calcTightTileBounds_(self: *const dtTileCache, header: [*c]const dtTileCacheLayerHeader, bmin: [*c]f32, bmax: [*c]f32) void;
    pub const calcTightTileBounds = _1_dtTileCache_calcTightTileBounds_;

    extern fn _1_dtTileCache_getObstacleBounds_(self: *const dtTileCache, ob: [*c]const dtTileCacheObstacle, bmin: [*c]f32, bmax: [*c]f32) void;
    pub const getObstacleBounds = _1_dtTileCache_getObstacleBounds_;

    extern fn _1_dtTileCache_encodeTileId_(self: *const dtTileCache, salt: c_uint, it: c_uint) dtCompressedTileRef;
    /// Encodes a tile id.
    pub const encodeTileId = _1_dtTileCache_encodeTileId_;

    extern fn _1_dtTileCache_decodeTileIdSalt_(self: *const dtTileCache, ref: dtCompressedTileRef) c_uint;
    /// Decodes a tile salt.
    pub const decodeTileIdSalt = _1_dtTileCache_decodeTileIdSalt_;

    extern fn _1_dtTileCache_decodeTileIdTile_(self: *const dtTileCache, ref: dtCompressedTileRef) c_uint;
    /// Decodes a tile id.
    pub const decodeTileIdTile = _1_dtTileCache_decodeTileIdTile_;

    extern fn _1_dtTileCache_encodeObstacleId_(self: *const dtTileCache, salt: c_uint, it: c_uint) dtObstacleRef;
    /// Encodes an obstacle id.
    pub const encodeObstacleId = _1_dtTileCache_encodeObstacleId_;

    extern fn _1_dtTileCache_decodeObstacleIdSalt_(self: *const dtTileCache, ref: dtObstacleRef) c_uint;
    /// Decodes an obstacle salt.
    pub const decodeObstacleIdSalt = _1_dtTileCache_decodeObstacleIdSalt_;

    extern fn _1_dtTileCache_decodeObstacleIdObstacle_(self: *const dtTileCache, ref: dtObstacleRef) c_uint;
    /// Decodes an obstacle id.
    pub const decodeObstacleIdObstacle = _1_dtTileCache_decodeObstacleIdObstacle_;

    pub const ObstacleRequest = extern struct {
        action: c_int,
        ref: dtObstacleRef,
    };


    // opaques

    const dtTileCacheAlloc = anyopaque;
    const dtTileCacheCompressor = anyopaque;
    const dtNavMesh = anyopaque;
};

extern fn _1_dtAllocTileCache_() [*c]dtTileCache;
pub const dtAllocTileCache = _1_dtAllocTileCache_;

extern fn _1_dtFreeTileCache_(tc: [*c]dtTileCache) void;
pub const dtFreeTileCache = _1_dtFreeTileCache_;
