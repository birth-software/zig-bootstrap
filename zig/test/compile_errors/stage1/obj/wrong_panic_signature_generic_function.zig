pub fn panic(comptime msg: []const u8, error_return_trace: ?*builtin.StackTrace) noreturn {
    _ = msg; _ = error_return_trace;
    while (true) {}
}
const builtin = @import("std").builtin;

// wrong panic signature, generic function
//
// error: expected type 'fn([]const u8, ?*std.builtin.StackTrace) noreturn', found 'fn([]const u8,anytype) anytype'
// note: only one of the functions is generic
