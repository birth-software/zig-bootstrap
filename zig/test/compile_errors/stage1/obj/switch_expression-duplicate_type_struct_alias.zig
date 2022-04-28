const Test = struct {
    bar: i32,
};
const Test2 = Test;
fn foo(comptime T: type, x: T) u8 {
    _ = x;
    return switch (T) {
        Test => 0,
        u64 => 1,
        Test2 => 2,
        else => 3,
    };
}
export fn entry() usize { return @sizeOf(@TypeOf(foo(u32, 0))); }

// switch expression - duplicate type (struct alias)
//
// tmp.zig:10:9: error: duplicate switch value
// tmp.zig:8:9: note: previous value here
