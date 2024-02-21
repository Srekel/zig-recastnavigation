// auto generated by c2z
#include <new>
#include "DetourCommon.h"

extern "C" void _1_dtVcross_(float * dest, const float * v1, const float * v2) { ::dtVcross(dest, v1, v2); }
extern "C" float _1_dtVdot_(const float * v1, const float * v2) { return ::dtVdot(v1, v2); }
extern "C" void _1_dtVmad_(float * dest, const float * v1, const float * v2, const float s) { ::dtVmad(dest, v1, v2, s); }
extern "C" void _1_dtVlerp_(float * dest, const float * v1, const float * v2, const float t) { ::dtVlerp(dest, v1, v2, t); }
extern "C" void _1_dtVadd_(float * dest, const float * v1, const float * v2) { ::dtVadd(dest, v1, v2); }
extern "C" void _1_dtVsub_(float * dest, const float * v1, const float * v2) { ::dtVsub(dest, v1, v2); }
extern "C" void _1_dtVscale_(float * dest, const float * v, const float t) { ::dtVscale(dest, v, t); }
extern "C" void _1_dtVmin_(float * mn, const float * v) { ::dtVmin(mn, v); }
extern "C" void _1_dtVmax_(float * mx, const float * v) { ::dtVmax(mx, v); }
extern "C" void _1_dtVset_(float * dest, const float x, const float y, const float z) { ::dtVset(dest, x, y, z); }
extern "C" void _1_dtVcopy_(float * dest, const float * a) { ::dtVcopy(dest, a); }
extern "C" float _1_dtVlen_(const float * v) { return ::dtVlen(v); }
extern "C" float _1_dtVlenSqr_(const float * v) { return ::dtVlenSqr(v); }
extern "C" float _1_dtVdist_(const float * v1, const float * v2) { return ::dtVdist(v1, v2); }
extern "C" float _1_dtVdistSqr_(const float * v1, const float * v2) { return ::dtVdistSqr(v1, v2); }
extern "C" float _1_dtVdist2D_(const float * v1, const float * v2) { return ::dtVdist2D(v1, v2); }
extern "C" float _1_dtVdist2DSqr_(const float * v1, const float * v2) { return ::dtVdist2DSqr(v1, v2); }
extern "C" void _1_dtVnormalize_(float * v) { ::dtVnormalize(v); }
extern "C" bool _1_dtVequal_(const float * p0, const float * p1) { return ::dtVequal(p0, p1); }
extern "C" bool _1_dtVisfinite_(const float * v) { return ::dtVisfinite(v); }
extern "C" bool _1_dtVisfinite2D_(const float * v) { return ::dtVisfinite2D(v); }
extern "C" float _1_dtVdot2D_(const float * u, const float * v) { return ::dtVdot2D(u, v); }
extern "C" float _1_dtVperp2D_(const float * u, const float * v) { return ::dtVperp2D(u, v); }
extern "C" float _1_dtTriArea2D_(const float * a, const float * b, const float * c) { return ::dtTriArea2D(a, b, c); }
extern "C" bool _1_dtOverlapQuantBounds_(const unsigned short * amin, const unsigned short * amax, const unsigned short * bmin, const unsigned short * bmax) { return ::dtOverlapQuantBounds(amin, amax, bmin, bmax); }
extern "C" bool _1_dtOverlapBounds_(const float * amin, const float * amax, const float * bmin, const float * bmax) { return ::dtOverlapBounds(amin, amax, bmin, bmax); }
extern "C" void _1_dtClosestPtPointTriangle_(float * closest, const float * p, const float * a, const float * b, const float * c) { ::dtClosestPtPointTriangle(closest, p, a, b, c); }
extern "C" bool _1_dtClosestHeightPointTriangle_(const float * p, const float * a, const float * b, const float * c, float & h) { return ::dtClosestHeightPointTriangle(p, a, b, c, h); }
extern "C" bool _1_dtIntersectSegmentPoly2D_(const float * p0, const float * p1, const float * verts, int nverts, float & tmin, float & tmax, int & segMin, int & segMax) { return ::dtIntersectSegmentPoly2D(p0, p1, verts, nverts, tmin, tmax, segMin, segMax); }
extern "C" bool _1_dtIntersectSegSeg2D_(const float * ap, const float * aq, const float * bp, const float * bq, float & s, float & t) { return ::dtIntersectSegSeg2D(ap, aq, bp, bq, s, t); }
extern "C" bool _1_dtPointInPolygon_(const float * pt, const float * verts, const int nverts) { return ::dtPointInPolygon(pt, verts, nverts); }
extern "C" bool _1_dtDistancePtPolyEdgesSqr_(const float * pt, const float * verts, const int nverts, float * ed, float * et) { return ::dtDistancePtPolyEdgesSqr(pt, verts, nverts, ed, et); }
extern "C" float _1_dtDistancePtSegSqr2D_(const float * pt, const float * p, const float * q, float & t) { return ::dtDistancePtSegSqr2D(pt, p, q, t); }
extern "C" void _1_dtCalcPolyCenter_(float * tc, const unsigned short * idx, int nidx, const float * verts) { ::dtCalcPolyCenter(tc, idx, nidx, verts); }
extern "C" bool _1_dtOverlapPolyPoly2D_(const float * polya, const int npolya, const float * polyb, const int npolyb) { return ::dtOverlapPolyPoly2D(polya, npolya, polyb, npolyb); }
extern "C" unsigned int _1_dtNextPow2_(unsigned int v) { return ::dtNextPow2(v); }
extern "C" void _1_dtRandomPointInConvexPoly_(const float * pts, const int npts, float * areas, const float s, const float t, float * out) { ::dtRandomPointInConvexPoly(pts, npts, areas, s, t, out); }
