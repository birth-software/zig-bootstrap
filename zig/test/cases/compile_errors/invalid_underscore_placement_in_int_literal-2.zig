fn main() void {
    var bad: u128 = 0b0010_;
    _ = bad;
}

// error
// backend=stage2
// target=native
//
// :2:27: error: trailing digit separator
