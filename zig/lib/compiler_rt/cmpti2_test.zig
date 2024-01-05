const cmp = @import("cmp.zig");
const testing = @import("std").testing;

fn test__cmpti2(a: i128, b: i128, expected: i128) !void {
    const result = cmp.__cmpti2(a, b);
    try testing.expectEqual(expected, result);
}

test "cmpti2" {
    // minInt == -170141183460469231731687303715884105728
    // maxInt == 170141183460469231731687303715884105727
    // minInt/2 == -85070591730234615865843651857942052864
    // maxInt/2 == 85070591730234615865843651857942052863
    // 1. equality minInt, minInt+1, minInt/2, 0, maxInt/2, maxInt-1, maxInt
    try test__cmpti2(-170141183460469231731687303715884105728, -170141183460469231731687303715884105728, 1);
    try test__cmpti2(-170141183460469231731687303715884105727, -170141183460469231731687303715884105727, 1);
    try test__cmpti2(-85070591730234615865843651857942052864, -85070591730234615865843651857942052864, 1);
    try test__cmpti2(-1, -1, 1);
    try test__cmpti2(0, 0, 1);
    try test__cmpti2(1, 1, 1);
    try test__cmpti2(85070591730234615865843651857942052863, 85070591730234615865843651857942052863, 1);
    try test__cmpti2(170141183460469231731687303715884105726, 170141183460469231731687303715884105726, 1);
    try test__cmpti2(170141183460469231731687303715884105727, 170141183460469231731687303715884105727, 1);
    // 2. cmp minInt,   {        minInt + 1, minInt/2, -1,0,1, maxInt/2, maxInt-1, maxInt}
    try test__cmpti2(-170141183460469231731687303715884105728, -170141183460469231731687303715884105727, 0);
    try test__cmpti2(-170141183460469231731687303715884105728, -85070591730234615865843651857942052864, 0);
    try test__cmpti2(-170141183460469231731687303715884105728, -1, 0);
    try test__cmpti2(-170141183460469231731687303715884105728, 0, 0);
    try test__cmpti2(-170141183460469231731687303715884105728, 1, 0);
    try test__cmpti2(-170141183460469231731687303715884105728, 85070591730234615865843651857942052863, 0);
    try test__cmpti2(-170141183460469231731687303715884105728, 170141183460469231731687303715884105726, 0);
    try test__cmpti2(-170141183460469231731687303715884105728, 170141183460469231731687303715884105727, 0);
    // 3. cmp minInt+1, {minInt,             minInt/2, -1,0,1, maxInt/2, maxInt-1, maxInt}
    try test__cmpti2(-170141183460469231731687303715884105727, -170141183460469231731687303715884105728, 2);
    try test__cmpti2(-170141183460469231731687303715884105727, -85070591730234615865843651857942052864, 0);
    try test__cmpti2(-170141183460469231731687303715884105727, -1, 0);
    try test__cmpti2(-170141183460469231731687303715884105727, 0, 0);
    try test__cmpti2(-170141183460469231731687303715884105727, 1, 0);
    try test__cmpti2(-170141183460469231731687303715884105727, 85070591730234615865843651857942052863, 0);
    try test__cmpti2(-170141183460469231731687303715884105727, 170141183460469231731687303715884105726, 0);
    try test__cmpti2(-170141183460469231731687303715884105727, 170141183460469231731687303715884105727, 0);
    // 4. cmp minInt/2, {minInt, minInt + 1,           -1,0,1, maxInt/2, maxInt-1, maxInt}
    try test__cmpti2(-85070591730234615865843651857942052864, -170141183460469231731687303715884105728, 2);
    try test__cmpti2(-85070591730234615865843651857942052864, -170141183460469231731687303715884105727, 2);
    try test__cmpti2(-85070591730234615865843651857942052864, -1, 0);
    try test__cmpti2(-85070591730234615865843651857942052864, 0, 0);
    try test__cmpti2(-85070591730234615865843651857942052864, 1, 0);
    try test__cmpti2(-85070591730234615865843651857942052864, 85070591730234615865843651857942052863, 0);
    try test__cmpti2(-85070591730234615865843651857942052864, 170141183460469231731687303715884105726, 0);
    try test__cmpti2(-85070591730234615865843651857942052864, 170141183460469231731687303715884105727, 0);
    // 5. cmp -1,       {minInt, minInt + 1, minInt/2,    0,1, maxInt/2, maxInt-1, maxInt}
    try test__cmpti2(-1, -170141183460469231731687303715884105728, 2);
    try test__cmpti2(-1, -170141183460469231731687303715884105727, 2);
    try test__cmpti2(-1, -85070591730234615865843651857942052864, 2);
    try test__cmpti2(-1, 0, 0);
    try test__cmpti2(-1, 1, 0);
    try test__cmpti2(-1, 85070591730234615865843651857942052863, 0);
    try test__cmpti2(-1, 170141183460469231731687303715884105726, 0);
    try test__cmpti2(-1, 170141183460469231731687303715884105727, 0);
    // 6. cmp 0,        {minInt, minInt + 1, minInt/2, -1,  1, maxInt/2, maxInt-1, maxInt}
    try test__cmpti2(0, -170141183460469231731687303715884105728, 2);
    try test__cmpti2(0, -170141183460469231731687303715884105727, 2);
    try test__cmpti2(0, -85070591730234615865843651857942052864, 2);
    try test__cmpti2(0, -1, 2);
    try test__cmpti2(0, 1, 0);
    try test__cmpti2(0, 85070591730234615865843651857942052863, 0);
    try test__cmpti2(0, 170141183460469231731687303715884105726, 0);
    try test__cmpti2(0, 170141183460469231731687303715884105727, 0);
    // 7. cmp 1,        {minInt, minInt + 1, minInt/2, -1,0,   maxInt/2, maxInt-1, maxInt}
    try test__cmpti2(1, -170141183460469231731687303715884105728, 2);
    try test__cmpti2(1, -170141183460469231731687303715884105727, 2);
    try test__cmpti2(1, -85070591730234615865843651857942052864, 2);
    try test__cmpti2(1, -1, 2);
    try test__cmpti2(1, 0, 2);
    try test__cmpti2(1, 85070591730234615865843651857942052863, 0);
    try test__cmpti2(1, 170141183460469231731687303715884105726, 0);
    try test__cmpti2(1, 170141183460469231731687303715884105727, 0);
    // 8. cmp maxInt/2, {minInt, minInt + 1, minInt/2, -1,0,1,           maxInt-1, maxInt}
    try test__cmpti2(85070591730234615865843651857942052863, -170141183460469231731687303715884105728, 2);
    try test__cmpti2(85070591730234615865843651857942052863, -170141183460469231731687303715884105727, 2);
    try test__cmpti2(85070591730234615865843651857942052863, -85070591730234615865843651857942052864, 2);
    try test__cmpti2(85070591730234615865843651857942052863, -1, 2);
    try test__cmpti2(85070591730234615865843651857942052863, 0, 2);
    try test__cmpti2(85070591730234615865843651857942052863, 1, 2);
    try test__cmpti2(85070591730234615865843651857942052863, 170141183460469231731687303715884105726, 0);
    try test__cmpti2(85070591730234615865843651857942052863, 170141183460469231731687303715884105727, 0);
    // 9. cmp maxInt-1, {minInt, minInt + 1, minInt/2, -1,0,1, maxInt/2,           maxInt}
    try test__cmpti2(170141183460469231731687303715884105726, -170141183460469231731687303715884105728, 2);
    try test__cmpti2(170141183460469231731687303715884105726, -170141183460469231731687303715884105727, 2);
    try test__cmpti2(170141183460469231731687303715884105726, -85070591730234615865843651857942052864, 2);
    try test__cmpti2(170141183460469231731687303715884105726, -1, 2);
    try test__cmpti2(170141183460469231731687303715884105726, 0, 2);
    try test__cmpti2(170141183460469231731687303715884105726, 1, 2);
    try test__cmpti2(170141183460469231731687303715884105726, 85070591730234615865843651857942052863, 2);
    try test__cmpti2(170141183460469231731687303715884105726, 170141183460469231731687303715884105727, 0);
    // 10.cmp maxInt,   {minInt, minInt + 1, minInt/2, -1,0,1, maxInt/2, maxInt-1,       }
    try test__cmpti2(170141183460469231731687303715884105727, -170141183460469231731687303715884105728, 2);
    try test__cmpti2(170141183460469231731687303715884105727, -170141183460469231731687303715884105727, 2);
    try test__cmpti2(170141183460469231731687303715884105727, -85070591730234615865843651857942052864, 2);
    try test__cmpti2(170141183460469231731687303715884105727, -1, 2);
    try test__cmpti2(170141183460469231731687303715884105727, 0, 2);
    try test__cmpti2(170141183460469231731687303715884105727, 1, 2);
    try test__cmpti2(170141183460469231731687303715884105727, 85070591730234615865843651857942052863, 2);
    try test__cmpti2(170141183460469231731687303715884105727, 170141183460469231731687303715884105726, 2);
}
