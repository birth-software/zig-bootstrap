export fn entry() void {
    const y = @bitCast(enum(u32) { a, b }, @as(u32, 3));
    _ = y;
}

// bitCast to enum type
//
// tmp.zig:2:24: error: cannot cast a value of type 'y'
