// const std = @import("std");
// const zignav = @import("zignav");
// const Recast = zignav.Recast;
// const recast_util = @import("recast_util.zig");
const demo_recast = @import("demo_recast.zig");
const demo_detour = @import("demo_detour.zig");

pub fn main() !void {
    try demo_recast.run_demo();
    try demo_detour.run_demo();
}
