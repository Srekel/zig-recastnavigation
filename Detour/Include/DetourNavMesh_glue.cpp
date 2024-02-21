// auto generated by c2z
#include <new>
#include "DetourNavMesh.h"

extern "C" const void* _1_DT_VERTS_PER_POLYGON_ = (void*)& ::DT_VERTS_PER_POLYGON;
extern "C" const void* _1_DT_NAVMESH_MAGIC_ = (void*)& ::DT_NAVMESH_MAGIC;
extern "C" const void* _1_DT_NAVMESH_VERSION_ = (void*)& ::DT_NAVMESH_VERSION;
extern "C" const void* _1_DT_NAVMESH_STATE_MAGIC_ = (void*)& ::DT_NAVMESH_STATE_MAGIC;
extern "C" const void* _1_DT_NAVMESH_STATE_VERSION_ = (void*)& ::DT_NAVMESH_STATE_VERSION;
extern "C" const void* _1_DT_EXT_LINK_ = (void*)& ::DT_EXT_LINK;
extern "C" const void* _1_DT_NULL_LINK_ = (void*)& ::DT_NULL_LINK;
extern "C" const void* _1_DT_OFFMESH_CON_BIDIR_ = (void*)& ::DT_OFFMESH_CON_BIDIR;
extern "C" const void* _1_DT_MAX_AREAS_ = (void*)& ::DT_MAX_AREAS;
extern "C" const void* _1_DT_RAY_CAST_LIMIT_PROPORTIONS_ = (void*)& ::DT_RAY_CAST_LIMIT_PROPORTIONS;
extern "C" void _1_dtPoly_setArea_(::dtPoly* self, unsigned char a) { self->setArea(a); }
extern "C" void _1_dtPoly_setType_(::dtPoly* self, unsigned char t) { self->setType(t); }
extern "C" unsigned char _1_dtPoly_getArea_(const ::dtPoly *self) { return self->getArea(); }
extern "C" unsigned char _1_dtPoly_getType_(const ::dtPoly *self) { return self->getType(); }
extern "C" int _1_dtGetDetailTriEdgeFlags_(unsigned char triFlags, int edgeIndex) { return ::dtGetDetailTriEdgeFlags(triFlags, edgeIndex); }
extern "C" void _1_dtNavMesh_init_(::dtNavMesh* self) { new (self) ::dtNavMesh(); }
extern "C" void _1_dtNavMesh_deinit_(::dtNavMesh *self) { self->~dtNavMesh(); }
extern "C" dtStatus _1_dtNavMesh_init_(::dtNavMesh* self, const dtNavMeshParams * params) { return self->init(params); }
extern "C" dtStatus _2_dtNavMesh_init_(::dtNavMesh* self, unsigned char * data, const int dataSize, const int flags) { return self->init(data, dataSize, flags); }
extern "C" const dtNavMeshParams * _1_dtNavMesh_getParams_(const ::dtNavMesh *self) { return self->getParams(); }
extern "C" dtStatus _1_dtNavMesh_addTile_(::dtNavMesh* self, unsigned char * data, int dataSize, int flags, dtTileRef lastRef, dtTileRef * result) { return self->addTile(data, dataSize, flags, lastRef, result); }
extern "C" dtStatus _1_dtNavMesh_removeTile_(::dtNavMesh* self, dtTileRef ref, unsigned char ** data, int * dataSize) { return self->removeTile(ref, data, dataSize); }
extern "C" void _1_dtNavMesh_calcTileLoc_(const ::dtNavMesh *self, const float * pos, int * tx, int * ty) { self->calcTileLoc(pos, tx, ty); }
extern "C" const dtMeshTile * _1_dtNavMesh_getTileAt_(const ::dtNavMesh *self, const int x, const int y, const int layer) { return self->getTileAt(x, y, layer); }
extern "C" int _1_dtNavMesh_getTilesAt_(const ::dtNavMesh *self, const int x, const int y, const dtMeshTile ** tiles, const int maxTiles) { return self->getTilesAt(x, y, tiles, maxTiles); }
extern "C" dtTileRef _1_dtNavMesh_getTileRefAt_(const ::dtNavMesh *self, int x, int y, int layer) { return self->getTileRefAt(x, y, layer); }
extern "C" dtTileRef _1_dtNavMesh_getTileRef_(const ::dtNavMesh *self, const dtMeshTile * tile) { return self->getTileRef(tile); }
extern "C" const dtMeshTile * _1_dtNavMesh_getTileByRef_(const ::dtNavMesh *self, dtTileRef ref) { return self->getTileByRef(ref); }
extern "C" int _1_dtNavMesh_getMaxTiles_(const ::dtNavMesh *self) { return self->getMaxTiles(); }
extern "C" const dtMeshTile * _1_dtNavMesh_getTile_(const ::dtNavMesh *self, int i) { return self->getTile(i); }
extern "C" dtStatus _1_dtNavMesh_getTileAndPolyByRef_(const ::dtNavMesh *self, const dtPolyRef ref, const dtMeshTile ** tile, const dtPoly ** poly) { return self->getTileAndPolyByRef(ref, tile, poly); }
extern "C" void _1_dtNavMesh_getTileAndPolyByRefUnsafe_(const ::dtNavMesh *self, const dtPolyRef ref, const dtMeshTile ** tile, const dtPoly ** poly) { self->getTileAndPolyByRefUnsafe(ref, tile, poly); }
extern "C" bool _1_dtNavMesh_isValidPolyRef_(const ::dtNavMesh *self, dtPolyRef ref) { return self->isValidPolyRef(ref); }
extern "C" dtPolyRef _1_dtNavMesh_getPolyRefBase_(const ::dtNavMesh *self, const dtMeshTile * tile) { return self->getPolyRefBase(tile); }
extern "C" dtStatus _1_dtNavMesh_getOffMeshConnectionPolyEndPoints_(const ::dtNavMesh *self, dtPolyRef prevRef, dtPolyRef polyRef, float * startPos, float * endPos) { return self->getOffMeshConnectionPolyEndPoints(prevRef, polyRef, startPos, endPos); }
extern "C" const dtOffMeshConnection * _1_dtNavMesh_getOffMeshConnectionByRef_(const ::dtNavMesh *self, dtPolyRef ref) { return self->getOffMeshConnectionByRef(ref); }
extern "C" dtStatus _1_dtNavMesh_setPolyFlags_(::dtNavMesh* self, dtPolyRef ref, unsigned short flags) { return self->setPolyFlags(ref, flags); }
extern "C" dtStatus _1_dtNavMesh_getPolyFlags_(const ::dtNavMesh *self, dtPolyRef ref, unsigned short * resultFlags) { return self->getPolyFlags(ref, resultFlags); }
extern "C" dtStatus _1_dtNavMesh_setPolyArea_(::dtNavMesh* self, dtPolyRef ref, unsigned char area) { return self->setPolyArea(ref, area); }
extern "C" dtStatus _1_dtNavMesh_getPolyArea_(const ::dtNavMesh *self, dtPolyRef ref, unsigned char * resultArea) { return self->getPolyArea(ref, resultArea); }
extern "C" int _1_dtNavMesh_getTileStateSize_(const ::dtNavMesh *self, const dtMeshTile * tile) { return self->getTileStateSize(tile); }
extern "C" dtStatus _1_dtNavMesh_storeTileState_(const ::dtNavMesh *self, const dtMeshTile * tile, unsigned char * data, const int maxDataSize) { return self->storeTileState(tile, data, maxDataSize); }
extern "C" dtStatus _1_dtNavMesh_restoreTileState_(::dtNavMesh* self, dtMeshTile * tile, const unsigned char * data, const int maxDataSize) { return self->restoreTileState(tile, data, maxDataSize); }
extern "C" dtPolyRef _1_dtNavMesh_encodePolyId_(const ::dtNavMesh *self, unsigned int salt, unsigned int it, unsigned int ip) { return self->encodePolyId(salt, it, ip); }
extern "C" void _1_dtNavMesh_decodePolyId_(const ::dtNavMesh *self, dtPolyRef ref, unsigned int & salt, unsigned int & it, unsigned int & ip) { self->decodePolyId(ref, salt, it, ip); }
extern "C" unsigned int _1_dtNavMesh_decodePolyIdSalt_(const ::dtNavMesh *self, dtPolyRef ref) { return self->decodePolyIdSalt(ref); }
extern "C" unsigned int _1_dtNavMesh_decodePolyIdTile_(const ::dtNavMesh *self, dtPolyRef ref) { return self->decodePolyIdTile(ref); }
extern "C" unsigned int _1_dtNavMesh_decodePolyIdPoly_(const ::dtNavMesh *self, dtPolyRef ref) { return self->decodePolyIdPoly(ref); }
extern "C" dtNavMesh * _1_dtAllocNavMesh_() { return ::dtAllocNavMesh(); }
extern "C" void _1_dtFreeNavMesh_(dtNavMesh * navmesh) { ::dtFreeNavMesh(navmesh); }
