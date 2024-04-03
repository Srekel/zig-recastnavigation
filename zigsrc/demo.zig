// const std = @import("std");
// const zignav = @import("zignav");
// const Recast = zignav.Recast;
// const recast_util = @import("recast_util.zig");
const demo_recast = @import("demo_recast.zig");
const demo_detour = @import("demo_detour.zig");
const demo_detour_multitile = @import("demo_detour_multitile.zig");
const demo_detour_tilecache = @import("demo_detour_tilecache.zig");

pub fn main() !void {
    // try demo_recast.run_demo();
    try demo_detour.run_demo();
    // try demo_detour_multitile.run_demo();

    // TileCache demo is WIP.
    // try demo_detour_tilecache.run_demo();
}
