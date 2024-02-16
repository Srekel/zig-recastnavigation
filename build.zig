const std = @import("std");

pub const Package = struct {
    zig_recastnavigation: *std.Build.Module,
    zig_recastnavigation_c_cpp: *std.Build.Step.Compile,

    pub fn link(pkg: Package, exe: *std.Build.Step.Compile) void {
        exe.root_module.addImport("zig_recastnavigation", pkg.zig_recastnavigation);
        exe.linkLibrary(pkg.zig_recastnavigation_c_cpp);
    }
};

pub fn package(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.Mode,
    _: struct {},
) Package {
    const zig_recastnavigation = b.createModule(.{
        .root_source_file = .{ .path = thisDir() ++ "/main.zig" },
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

fn buildDemoExe(b: *std.Build, target: std.Build.ResolvedTarget, optimize: std.builtin.Mode) void {
    const exe = b.addExecutable(.{
        .name = "RecastDemo",
        .root_source_file = .{ .path = thisDir() ++ "/zigsrc/demo_recast.zig" },
        .target = target,
        .optimize = optimize,
    });

    const zignav_pkg = package(b, target, optimize, .{});
    exe.root_module.addImport("zignav", zignav_pkg.zig_recastnavigation);
    zignav_pkg.link(exe);

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    buildDemoExe(b, target, optimize);
}

inline fn thisDir() []const u8 {
    return comptime std.fs.path.dirname(@src().file) orelse ".";
}
