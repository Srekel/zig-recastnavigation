// auto generated by c2z
#include <new>
#include "DetourPathCorridor.h"

extern "C" void _1_dtPathCorridor_init_(::dtPathCorridor* self) { new (self) ::dtPathCorridor(); }
extern "C" void _1_dtPathCorridor_deinit_(::dtPathCorridor *self) { self->~dtPathCorridor(); }
extern "C" bool _2_dtPathCorridor_init_(::dtPathCorridor* self, const int maxPath) { return self->init(maxPath); }
extern "C" void _1_dtPathCorridor_reset_(::dtPathCorridor* self, dtPolyRef ref, const float * pos) { self->reset(ref, pos); }
extern "C" int _1_dtPathCorridor_findCorners_(::dtPathCorridor* self, float * cornerVerts, unsigned char * cornerFlags, dtPolyRef * cornerPolys, const int maxCorners, dtNavMeshQuery * navquery, const dtQueryFilter * filter) { return self->findCorners(cornerVerts, cornerFlags, cornerPolys, maxCorners, navquery, filter); }
extern "C" void _1_dtPathCorridor_optimizePathVisibility_(::dtPathCorridor* self, const float * next, const float pathOptimizationRange, dtNavMeshQuery * navquery, const dtQueryFilter * filter) { self->optimizePathVisibility(next, pathOptimizationRange, navquery, filter); }
extern "C" bool _1_dtPathCorridor_optimizePathTopology_(::dtPathCorridor* self, dtNavMeshQuery * navquery, const dtQueryFilter * filter) { return self->optimizePathTopology(navquery, filter); }
extern "C" bool _1_dtPathCorridor_moveOverOffmeshConnection_(::dtPathCorridor* self, dtPolyRef offMeshConRef, dtPolyRef * refs, float * startPos, float * endPos, dtNavMeshQuery * navquery) { return self->moveOverOffmeshConnection(offMeshConRef, refs, startPos, endPos, navquery); }
extern "C" bool _1_dtPathCorridor_fixPathStart_(::dtPathCorridor* self, dtPolyRef safeRef, const float * safePos) { return self->fixPathStart(safeRef, safePos); }
extern "C" bool _1_dtPathCorridor_trimInvalidPath_(::dtPathCorridor* self, dtPolyRef safeRef, const float * safePos, dtNavMeshQuery * navquery, const dtQueryFilter * filter) { return self->trimInvalidPath(safeRef, safePos, navquery, filter); }
extern "C" bool _1_dtPathCorridor_isValid_(::dtPathCorridor* self, const int maxLookAhead, dtNavMeshQuery * navquery, const dtQueryFilter * filter) { return self->isValid(maxLookAhead, navquery, filter); }
extern "C" bool _1_dtPathCorridor_movePosition_(::dtPathCorridor* self, const float * npos, dtNavMeshQuery * navquery, const dtQueryFilter * filter) { return self->movePosition(npos, navquery, filter); }
extern "C" bool _1_dtPathCorridor_moveTargetPosition_(::dtPathCorridor* self, const float * npos, dtNavMeshQuery * navquery, const dtQueryFilter * filter) { return self->moveTargetPosition(npos, navquery, filter); }
extern "C" void _1_dtPathCorridor_setCorridor_(::dtPathCorridor* self, const float * target, const dtPolyRef * polys, const int npath) { self->setCorridor(target, polys, npath); }
extern "C" const float * _1_dtPathCorridor_getPos_(const ::dtPathCorridor *self) { return self->getPos(); }
extern "C" const float * _1_dtPathCorridor_getTarget_(const ::dtPathCorridor *self) { return self->getTarget(); }
extern "C" dtPolyRef _1_dtPathCorridor_getFirstPoly_(const ::dtPathCorridor *self) { return self->getFirstPoly(); }
extern "C" dtPolyRef _1_dtPathCorridor_getLastPoly_(const ::dtPathCorridor *self) { return self->getLastPoly(); }
extern "C" const dtPolyRef * _1_dtPathCorridor_getPath_(const ::dtPathCorridor *self) { return self->getPath(); }
extern "C" int _1_dtPathCorridor_getPathCount_(const ::dtPathCorridor *self) { return self->getPathCount(); }
extern "C" int _1_dtMergeCorridorStartMoved_(dtPolyRef * path, const int npath, const int maxPath, const dtPolyRef * visited, const int nvisited) { return ::dtMergeCorridorStartMoved(path, npath, maxPath, visited, nvisited); }
extern "C" int _1_dtMergeCorridorEndMoved_(dtPolyRef * path, const int npath, const int maxPath, const dtPolyRef * visited, const int nvisited) { return ::dtMergeCorridorEndMoved(path, npath, maxPath, visited, nvisited); }
extern "C" int _1_dtMergeCorridorStartShortcut_(dtPolyRef * path, const int npath, const int maxPath, const dtPolyRef * visited, const int nvisited) { return ::dtMergeCorridorStartShortcut(path, npath, maxPath, visited, nvisited); }
