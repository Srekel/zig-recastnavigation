// auto generated by c2z
const std = @import("std");
//const cpp = @import("cpp");

/// An assertion failure function.
///  @param[in] expression   asserted expression.
///  @param[in] file   Filename of the failed assertion.
///  @param[in] line   Line number of the failed assertion.
///  @see dtAssertFailSetCustom
pub const dtAssertFailFunc = fn ([*c]const u8, [*c]const u8, c_int) callconv(.C) void;

extern fn _1_dtAssertFailSetCustom_(assertFailFunc: [*c]dtAssertFailFunc) void;
/// Sets the base custom assertion failure function to be used by Detour.
///  @param[in] assertFailFunc 	The function to be invoked in case of failure of #dtAssert
pub const dtAssertFailSetCustom = _1_dtAssertFailSetCustom_;

extern fn _1_dtAssertFailGetCustom_() [*c]dtAssertFailFunc;
/// Gets the base custom assertion failure function to be used by Detour.
pub const dtAssertFailGetCustom = _1_dtAssertFailGetCustom_;