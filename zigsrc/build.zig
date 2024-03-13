const std = @import("std");
const Build = @import("std").Build;

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const exe = b.addExecutable(.{
        .name = "ZigNavDemo",
        .root_source_file = .{ .path = "demo.zig" },
        .target = target,
        .optimize = optimize,
    });

    const zignav = b.dependency("zignav", .{});
    exe.root_module.addImport("zignav", zignav.module("zignav"));
    exe.linkLibrary(zignav.artifact("zignav_c_cpp"));

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
