const std = @import("std");
const Build = @import("std").Build;

pub fn build(b: *Build) void {
    var target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // For some reason, "#include <new>"" in the binding glue only works with msvc.
    target.query.abi = .msvc;

    const zignav_c_cpp = b.addStaticLibrary(.{
        .name = "zignav_c_cpp",
        .target = target,
        .optimize = optimize,
    });
    zignav_c_cpp.linkLibC();
    zignav_c_cpp.addIncludePath(.{ .path = "Recast/Include" });
    zignav_c_cpp.addIncludePath(.{ .path = "Detour/Include" });
    zignav_c_cpp.addIncludePath(.{ .path = "DetourTileCache/Include" });
    zignav_c_cpp.addIncludePath(.{ .path = "DetourCrowd/Include" });
    zignav_c_cpp.addCSourceFiles(.{
        .files = &.{
            // Recast
            "Recast/Include/Recast_glue.cpp",
            "Recast/Source/Recast.cpp",
            "Recast/Source/RecastAlloc.cpp",
            "Recast/Source/RecastArea.cpp",
            "Recast/Source/RecastAssert.cpp",
            "Recast/Source/RecastContour.cpp",
            "Recast/Source/RecastFilter.cpp",
            "Recast/Source/RecastLayers.cpp",
            "Recast/Source/RecastMesh.cpp",
            "Recast/Source/RecastMeshDetail.cpp",
            "Recast/Source/RecastRasterization.cpp",
            "Recast/Source/RecastRegion.cpp",
            // Detour
            "Detour/Include/DetourAlloc_glue.cpp",
            "Detour/Include/DetourAssert_glue.cpp",
            "Detour/Include/DetourCommon_glue.cpp",
            "Detour/Include/DetourNavMesh_glue.cpp",
            "Detour/Include/DetourNavMeshBuilder_glue.cpp",
            "Detour/Include/DetourNavMeshQuery_glue.cpp",
            "Detour/Include/DetourNode_glue.cpp",
            "Detour/Include/DetourStatus_glue.cpp",
            "Detour/Source/DetourAlloc.cpp",
            "Detour/Source/DetourAssert.cpp",
            "Detour/Source/DetourCommon.cpp",
            "Detour/Source/DetourNavMesh.cpp",
            "Detour/Source/DetourNavMeshBuilder.cpp",
            "Detour/Source/DetourNavMeshQuery.cpp",
            "Detour/Source/DetourNode.cpp",
            // Detour Tile Cache
            "DetourTileCache/Include/DetourTileCache_glue.cpp",
            "DetourTileCache/Include/DetourTileCacheBuilder_glue.cpp",
            "DetourTileCache/Source/DetourTileCache.cpp",
            "DetourTileCache/Source/DetourTileCacheBuilder.cpp",
            // Detour Crowd
            "DetourCrowd/Include/DetourPathCorridor_glue.cpp",
            "DetourCrowd/Source/DetourPathCorridor.cpp",
        },
        .flags = &.{},
    });

    b.installArtifact(zignav_c_cpp);

    var zignav = b.addModule("zignav", .{
        .root_source_file = .{ .path = "main.zig" },
        .target = target,
        .optimize = optimize,
    });

    zignav.linkLibrary(zignav_c_cpp);
}
