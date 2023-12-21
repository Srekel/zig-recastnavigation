const std = @import("std");

pub const Package = struct {
    zig_recastnavigation: *std.Build.Module,
    zig_recastnavigation_c_cpp: *std.Build.CompileStep,

    pub fn link(pkg: Package, exe: *std.Build.CompileStep) void {
        exe.addModule("zig_recastnavigation", pkg.zig_recastnavigation);
        exe.linkLibrary(pkg.zig_recastnavigation_c_cpp);
    }
};

pub fn package(
    b: *std.Build,
    target: std.zig.CrossTarget,
    optimize: std.builtin.Mode,
    _: struct {},
) Package {
    const zig_recastnavigation = b.createModule(.{
        .source_file = .{ .path = thisDir() ++ "/main.zig" },
    });

    const zig_recastnavigation_c_cpp = b.addStaticLibrary(.{
        .name = "zignav",
        .target = target,
        .optimize = optimize,
    });
    zig_recastnavigation_c_cpp.linkLibC();
    zig_recastnavigation_c_cpp.addIncludePath(.{ .path = thisDir() ++ "/Recast/Include" });
    zig_recastnavigation_c_cpp.addCSourceFiles(.{
        .files = &.{
            thisDir() ++ "/Recast/Include/Recast_glue.cpp",
            thisDir() ++ "/Recast/Source/Recast.cpp",
            thisDir() ++ "/Recast/Source/RecastAlloc.cpp",
            thisDir() ++ "/Recast/Source/RecastArea.cpp",
            thisDir() ++ "/Recast/Source/RecastAssert.cpp",
            thisDir() ++ "/Recast/Source/RecastContour.cpp",
            thisDir() ++ "/Recast/Source/RecastFilter.cpp",
            thisDir() ++ "/Recast/Source/RecastLayers.cpp",
            thisDir() ++ "/Recast/Source/RecastMesh.cpp",
            thisDir() ++ "/Recast/Source/RecastMeshDetail.cpp",
            thisDir() ++ "/Recast/Source/RecastRasterization.cpp",
            thisDir() ++ "/Recast/Source/RecastRegion.cpp",
        },
        .flags = &.{},
    });

    return .{
        .zig_recastnavigation = zig_recastnavigation,
        .zig_recastnavigation_c_cpp = zig_recastnavigation_c_cpp,
    };
}

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const test_step = b.step("test", "Run zig_recastnavigation tests");
    test_step.dependOn(runTests(b, optimize, target));
}

pub fn runTests(
    b: *std.Build,
    optimize: std.builtin.Mode,
    target: std.zig.CrossTarget,
) *std.Build.Step {
    const tests = b.addTest(.{
        .name = "zig_recastnavigation-tests",
        .root_source_file = .{ .path = thisDir() ++ "/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    return &b.addRunArtifact(tests).step;
}

inline fn thisDir() []const u8 {
    return comptime std.fs.path.dirname(@src().file) orelse ".";
}
