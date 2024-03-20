// auto generated by c2z
#include <new>
#include "Recast.h"

extern "C" const void *_1_RC_PI_ = (void *)&::RC_PI;
extern "C" void _1_rcContext_init_(::rcContext *self, bool state) { new (self)::rcContext(state); }
extern "C" void _1_rcContext_deinit_(::rcContext *self) { self->~rcContext(); }
extern "C" void _1_rcContext_enableLog_(::rcContext *self, bool state) { self->enableLog(state); }
extern "C" void _1_rcContext_resetLog_(::rcContext *self) { self->resetLog(); }
extern "C" void _1_rcContext_enableTimer_(::rcContext *self, bool state) { self->enableTimer(state); }
extern "C" void _1_rcContext_resetTimers_(::rcContext *self) { self->resetTimers(); }
extern "C" void _1_rcContext_startTimer_(::rcContext *self, const rcTimerLabel label) { self->startTimer(label); }
extern "C" void _1_rcContext_stopTimer_(::rcContext *self, const rcTimerLabel label) { self->stopTimer(label); }
extern "C" int _1_rcContext_getAccumulatedTime_(const ::rcContext *self, const rcTimerLabel label) { return self->getAccumulatedTime(label); }
extern "C" void _1_rcScopedTimer_init_(::rcScopedTimer *self, rcContext *ctx, const rcTimerLabel label) { new (self)::rcScopedTimer(ctx, label); }
extern "C" void _1_rcScopedTimer_deinit_(::rcScopedTimer *self) { self->~rcScopedTimer(); }
extern "C" const void *_1_RC_SPAN_HEIGHT_BITS_ = (void *)&::RC_SPAN_HEIGHT_BITS;
extern "C" const void *_1_RC_SPAN_MAX_HEIGHT_ = (void *)&::RC_SPAN_MAX_HEIGHT;
extern "C" const void *_1_RC_SPANS_PER_POOL_ = (void *)&::RC_SPANS_PER_POOL;
extern "C" void _1_rcHeightfield_init_(::rcHeightfield *self) { new (self)::rcHeightfield(); }
extern "C" void _1_rcHeightfield_deinit_(::rcHeightfield *self) { self->~rcHeightfield(); }
extern "C" void _1_rcCompactHeightfield_init_(::rcCompactHeightfield *self) { new (self)::rcCompactHeightfield(); }
extern "C" void _1_rcCompactHeightfield_deinit_(::rcCompactHeightfield *self) { self->~rcCompactHeightfield(); }
extern "C" void _1_rcHeightfieldLayerSet_init_(::rcHeightfieldLayerSet *self) { new (self)::rcHeightfieldLayerSet(); }
extern "C" void _1_rcHeightfieldLayerSet_deinit_(::rcHeightfieldLayerSet *self) { self->~rcHeightfieldLayerSet(); }
extern "C" void _1_rcContourSet_init_(::rcContourSet *self) { new (self)::rcContourSet(); }
extern "C" void _1_rcContourSet_deinit_(::rcContourSet *self) { self->~rcContourSet(); }
extern "C" void _1_rcPolyMesh_init_(::rcPolyMesh *self) { new (self)::rcPolyMesh(); }
extern "C" void _1_rcPolyMesh_deinit_(::rcPolyMesh *self) { self->~rcPolyMesh(); }
extern "C" void _1_rcPolyMeshDetail_init_(::rcPolyMeshDetail *self) { new (self)::rcPolyMeshDetail(); }
extern "C" rcHeightfield *_1_rcAllocHeightfield_() { return ::rcAllocHeightfield(); }
extern "C" void _1_rcFreeHeightField_(rcHeightfield *heightfield) { ::rcFreeHeightField(heightfield); }
extern "C" rcCompactHeightfield *_1_rcAllocCompactHeightfield_() { return ::rcAllocCompactHeightfield(); }
extern "C" void _1_rcFreeCompactHeightfield_(rcCompactHeightfield *compactHeightfield) { ::rcFreeCompactHeightfield(compactHeightfield); }
extern "C" rcHeightfieldLayerSet *_1_rcAllocHeightfieldLayerSet_() { return ::rcAllocHeightfieldLayerSet(); }
extern "C" void _1_rcFreeHeightfieldLayerSet_(rcHeightfieldLayerSet *layerSet) { ::rcFreeHeightfieldLayerSet(layerSet); }
extern "C" rcContourSet *_1_rcAllocContourSet_() { return ::rcAllocContourSet(); }
extern "C" void _1_rcFreeContourSet_(rcContourSet *contourSet) { ::rcFreeContourSet(contourSet); }
extern "C" rcPolyMesh *_1_rcAllocPolyMesh_() { return ::rcAllocPolyMesh(); }
extern "C" void _1_rcFreePolyMesh_(rcPolyMesh *polyMesh) { ::rcFreePolyMesh(polyMesh); }
extern "C" rcPolyMeshDetail *_1_rcAllocPolyMeshDetail_() { return ::rcAllocPolyMeshDetail(); }
extern "C" void _1_rcFreePolyMeshDetail_(rcPolyMeshDetail *detailMesh) { ::rcFreePolyMeshDetail(detailMesh); }
extern "C" const void *_1_RC_BORDER_REG_ = (void *)&::RC_BORDER_REG;
extern "C" const void *_1_RC_MULTIPLE_REGS_ = (void *)&::RC_MULTIPLE_REGS;
extern "C" const void *_1_RC_BORDER_VERTEX_ = (void *)&::RC_BORDER_VERTEX;
extern "C" const void *_1_RC_AREA_BORDER_ = (void *)&::RC_AREA_BORDER;
extern "C" const void *_1_RC_CONTOUR_REG_MASK_ = (void *)&::RC_CONTOUR_REG_MASK;
extern "C" const void *_1_RC_MESH_NULL_IDX_ = (void *)&::RC_MESH_NULL_IDX;
extern "C" const void *_1_RC_NULL_AREA_ = (void *)&::RC_NULL_AREA;
extern "C" const void *_1_RC_WALKABLE_AREA_ = (void *)&::RC_WALKABLE_AREA;
extern "C" const unsigned char WALKABLE_AREA = RC_WALKABLE_AREA;
extern "C" const void *_1_RC_NOT_CONNECTED_ = (void *)&::RC_NOT_CONNECTED;
extern "C" float _1_rcSqrt_(float x) { return ::rcSqrt(x); }
extern "C" void _1_rcVcross_(float *dest, const float *v1, const float *v2) { ::rcVcross(dest, v1, v2); }
extern "C" float _1_rcVdot_(const float *v1, const float *v2) { return ::rcVdot(v1, v2); }
extern "C" void _1_rcVmad_(float *dest, const float *v1, const float *v2, const float s) { ::rcVmad(dest, v1, v2, s); }
extern "C" void _1_rcVadd_(float *dest, const float *v1, const float *v2) { ::rcVadd(dest, v1, v2); }
extern "C" void _1_rcVsub_(float *dest, const float *v1, const float *v2) { ::rcVsub(dest, v1, v2); }
extern "C" void _1_rcVmin_(float *mn, const float *v) { ::rcVmin(mn, v); }
extern "C" void _1_rcVmax_(float *mx, const float *v) { ::rcVmax(mx, v); }
extern "C" void _1_rcVcopy_(float *dest, const float *v) { ::rcVcopy(dest, v); }
extern "C" float _1_rcVdist_(const float *v1, const float *v2) { return ::rcVdist(v1, v2); }
extern "C" float _1_rcVdistSqr_(const float *v1, const float *v2) { return ::rcVdistSqr(v1, v2); }
extern "C" void _1_rcVnormalize_(float *v) { ::rcVnormalize(v); }
extern "C" void _1_rcCalcBounds_(const float *verts, int numVerts, float *minBounds, float *maxBounds) { ::rcCalcBounds(verts, numVerts, minBounds, maxBounds); }
extern "C" void _1_rcCalcGridSize_(const float *minBounds, const float *maxBounds, float cellSize, int *sizeX, int *sizeZ) { ::rcCalcGridSize(minBounds, maxBounds, cellSize, sizeX, sizeZ); }
extern "C" bool _1_rcCreateHeightfield_(rcContext *context, rcHeightfield &heightfield, int sizeX, int sizeZ, const float *minBounds, const float *maxBounds, float cellSize, float cellHeight) { return ::rcCreateHeightfield(context, heightfield, sizeX, sizeZ, minBounds, maxBounds, cellSize, cellHeight); }
extern "C" void _1_rcMarkWalkableTriangles_(rcContext *context, float walkableSlopeAngle, const float *verts, int numVerts, const int *tris, int numTris, unsigned char *triAreaIDs) { ::rcMarkWalkableTriangles(context, walkableSlopeAngle, verts, numVerts, tris, numTris, triAreaIDs); }
extern "C" void _1_rcClearUnwalkableTriangles_(rcContext *context, float walkableSlopeAngle, const float *verts, int numVerts, const int *tris, int numTris, unsigned char *triAreaIDs) { ::rcClearUnwalkableTriangles(context, walkableSlopeAngle, verts, numVerts, tris, numTris, triAreaIDs); }
extern "C" bool _1_rcAddSpan_(rcContext *context, rcHeightfield &heightfield, int x, int z, unsigned short spanMin, unsigned short spanMax, unsigned char areaID, int flagMergeThreshold) { return ::rcAddSpan(context, heightfield, x, z, spanMin, spanMax, areaID, flagMergeThreshold); }
extern "C" bool _1_rcRasterizeTriangle_(rcContext *context, const float *v0, const float *v1, const float *v2, unsigned char areaID, rcHeightfield &heightfield, int flagMergeThreshold) { return ::rcRasterizeTriangle(context, v0, v1, v2, areaID, heightfield, flagMergeThreshold); }
extern "C" bool _1_rcRasterizeTriangles_(rcContext *context, const float *verts, int numVerts, const int *tris, const unsigned char *triAreaIDs, int numTris, rcHeightfield &heightfield, int flagMergeThreshold) { return ::rcRasterizeTriangles(context, verts, numVerts, tris, triAreaIDs, numTris, heightfield, flagMergeThreshold); }
extern "C" bool _2_rcRasterizeTriangles_(rcContext *context, const float *verts, int numVerts, const unsigned short *tris, const unsigned char *triAreaIDs, int numTris, rcHeightfield &heightfield, int flagMergeThreshold) { return ::rcRasterizeTriangles(context, verts, numVerts, tris, triAreaIDs, numTris, heightfield, flagMergeThreshold); }
extern "C" bool _3_rcRasterizeTriangles_(rcContext *context, const float *verts, const unsigned char *triAreaIDs, int numTris, rcHeightfield &heightfield, int flagMergeThreshold) { return ::rcRasterizeTriangles(context, verts, triAreaIDs, numTris, heightfield, flagMergeThreshold); }
extern "C" void _1_rcFilterLowHangingWalkableObstacles_(rcContext *context, int walkableClimb, rcHeightfield &heightfield) { ::rcFilterLowHangingWalkableObstacles(context, walkableClimb, heightfield); }
extern "C" void _1_rcFilterLedgeSpans_(rcContext *context, int walkableHeight, int walkableClimb, rcHeightfield &heightfield) { ::rcFilterLedgeSpans(context, walkableHeight, walkableClimb, heightfield); }
extern "C" void _1_rcFilterWalkableLowHeightSpans_(rcContext *context, int walkableHeight, rcHeightfield &heightfield) { ::rcFilterWalkableLowHeightSpans(context, walkableHeight, heightfield); }
extern "C" int _1_rcGetHeightFieldSpanCount_(rcContext *context, const rcHeightfield &heightfield) { return ::rcGetHeightFieldSpanCount(context, heightfield); }
extern "C" bool _1_rcBuildCompactHeightfield_(rcContext *context, int walkableHeight, int walkableClimb, const rcHeightfield &heightfield, rcCompactHeightfield &compactHeightfield) { return ::rcBuildCompactHeightfield(context, walkableHeight, walkableClimb, heightfield, compactHeightfield); }
extern "C" bool _1_rcErodeWalkableArea_(rcContext *context, int erosionRadius, rcCompactHeightfield &compactHeightfield) { return ::rcErodeWalkableArea(context, erosionRadius, compactHeightfield); }
extern "C" bool _1_rcMedianFilterWalkableArea_(rcContext *context, rcCompactHeightfield &compactHeightfield) { return ::rcMedianFilterWalkableArea(context, compactHeightfield); }
extern "C" void _1_rcMarkBoxArea_(rcContext *context, const float *boxMinBounds, const float *boxMaxBounds, unsigned char areaId, rcCompactHeightfield &compactHeightfield) { ::rcMarkBoxArea(context, boxMinBounds, boxMaxBounds, areaId, compactHeightfield); }
extern "C" void _1_rcMarkConvexPolyArea_(rcContext *context, const float *verts, int numVerts, float minY, float maxY, unsigned char areaId, rcCompactHeightfield &compactHeightfield) { ::rcMarkConvexPolyArea(context, verts, numVerts, minY, maxY, areaId, compactHeightfield); }
extern "C" int _1_rcOffsetPoly_(const float *verts, int numVerts, float offset, float *outVerts, int maxOutVerts) { return ::rcOffsetPoly(verts, numVerts, offset, outVerts, maxOutVerts); }
extern "C" void _1_rcMarkCylinderArea_(rcContext *context, const float *position, float radius, float height, unsigned char areaId, rcCompactHeightfield &compactHeightfield) { ::rcMarkCylinderArea(context, position, radius, height, areaId, compactHeightfield); }
extern "C" bool _1_rcBuildDistanceField_(rcContext *ctx, rcCompactHeightfield &chf) { return ::rcBuildDistanceField(ctx, chf); }
extern "C" bool _1_rcBuildRegions_(rcContext *ctx, rcCompactHeightfield &chf, int borderSize, int minRegionArea, int mergeRegionArea) { return ::rcBuildRegions(ctx, chf, borderSize, minRegionArea, mergeRegionArea); }
extern "C" bool _1_rcBuildLayerRegions_(rcContext *ctx, rcCompactHeightfield &chf, int borderSize, int minRegionArea) { return ::rcBuildLayerRegions(ctx, chf, borderSize, minRegionArea); }
extern "C" bool _1_rcBuildRegionsMonotone_(rcContext *ctx, rcCompactHeightfield &chf, int borderSize, int minRegionArea, int mergeRegionArea) { return ::rcBuildRegionsMonotone(ctx, chf, borderSize, minRegionArea, mergeRegionArea); }
extern "C" void _1_rcSetCon_(rcCompactSpan &span, int direction, int neighborIndex) { ::rcSetCon(span, direction, neighborIndex); }
extern "C" int _1_rcGetCon_(const rcCompactSpan &span, int direction) { return ::rcGetCon(span, direction); }
extern "C" int _1_rcGetDirOffsetX_(int direction) { return ::rcGetDirOffsetX(direction); }
extern "C" int _1_rcGetDirOffsetY_(int direction) { return ::rcGetDirOffsetY(direction); }
extern "C" int _1_rcGetDirForOffset_(int offsetX, int offsetZ) { return ::rcGetDirForOffset(offsetX, offsetZ); }
extern "C" bool _1_rcBuildHeightfieldLayers_(rcContext *ctx, const rcCompactHeightfield &chf, int borderSize, int walkableHeight, rcHeightfieldLayerSet &lset) { return ::rcBuildHeightfieldLayers(ctx, chf, borderSize, walkableHeight, lset); }
extern "C" bool _1_rcBuildContours_(rcContext *ctx, const rcCompactHeightfield &chf, float maxError, int maxEdgeLen, rcContourSet &cset, int buildFlags) { return ::rcBuildContours(ctx, chf, maxError, maxEdgeLen, cset, buildFlags); }
extern "C" bool _1_rcBuildPolyMesh_(rcContext *ctx, const rcContourSet &cset, const int nvp, rcPolyMesh &mesh) { return ::rcBuildPolyMesh(ctx, cset, nvp, mesh); }
extern "C" bool _1_rcMergePolyMeshes_(rcContext *ctx, rcPolyMesh **meshes, const int nmeshes, rcPolyMesh &mesh) { return ::rcMergePolyMeshes(ctx, meshes, nmeshes, mesh); }
extern "C" bool _1_rcBuildPolyMeshDetail_(rcContext *ctx, const rcPolyMesh &mesh, const rcCompactHeightfield &chf, float sampleDist, float sampleMaxError, rcPolyMeshDetail &dmesh) { return ::rcBuildPolyMeshDetail(ctx, mesh, chf, sampleDist, sampleMaxError, dmesh); }
extern "C" bool _1_rcCopyPolyMesh_(rcContext *ctx, const rcPolyMesh &src, rcPolyMesh &dst) { return ::rcCopyPolyMesh(ctx, src, dst); }
extern "C" bool _1_rcMergePolyMeshDetails_(rcContext *ctx, rcPolyMeshDetail **meshes, const int nmeshes, rcPolyMeshDetail &mesh) { return ::rcMergePolyMeshDetails(ctx, meshes, nmeshes, mesh); }
