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
    zignav_c_cpp.addCSourceFiles(.{
        .files = &.{
            "/Recast/Include/Recast_glue.cpp",
            "/Recast/Source/Recast.cpp",
            "/Recast/Source/RecastAlloc.cpp",
            "/Recast/Source/RecastArea.cpp",
            "/Recast/Source/RecastAssert.cpp",
            "/Recast/Source/RecastContour.cpp",
            "/Recast/Source/RecastFilter.cpp",
            "/Recast/Source/RecastLayers.cpp",
            "/Recast/Source/RecastMesh.cpp",
            "/Recast/Source/RecastMeshDetail.cpp",
            "/Recast/Source/RecastRasterization.cpp",
            "/Recast/Source/RecastRegion.cpp",
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
