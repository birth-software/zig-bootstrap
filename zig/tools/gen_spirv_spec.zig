const std = @import("std");
const g = @import("spirv/grammar.zig");
const Allocator = std.mem.Allocator;

const ExtendedStructSet = std.StringHashMap(void);

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const args = try std.process.argsAlloc(allocator);
    if (args.len != 2) {
        usageAndExit(std.io.getStdErr(), args[0], 1);
    }

    const spec_path = args[1];
    const spec = try std.fs.cwd().readFileAlloc(allocator, spec_path, std.math.maxInt(usize));

    // Required for json parsing.
    @setEvalBranchQuota(10000);

    var scanner = std.json.Scanner.initCompleteInput(allocator, spec);
    var diagnostics = std.json.Diagnostics{};
    scanner.enableDiagnostics(&diagnostics);
    const parsed = std.json.parseFromTokenSource(g.CoreRegistry, allocator, &scanner, .{}) catch |err| {
        std.debug.print("line,col: {},{}\n", .{ diagnostics.getLine(), diagnostics.getColumn() });
        return err;
    };

    var bw = std.io.bufferedWriter(std.io.getStdOut().writer());
    try render(bw.writer(), allocator, parsed.value);
    try bw.flush();
}

/// Returns a set with types that require an extra struct for the `Instruction` interface
/// to the spir-v spec, or whether the original type can be used.
fn extendedStructs(
    arena: Allocator,
    kinds: []const g.OperandKind,
) !ExtendedStructSet {
    var map = ExtendedStructSet.init(arena);
    try map.ensureTotalCapacity(@as(u32, @intCast(kinds.len)));

    for (kinds) |kind| {
        const enumerants = kind.enumerants orelse continue;

        for (enumerants) |enumerant| {
            if (enumerant.parameters.len > 0) {
                break;
            }
        } else continue;

        map.putAssumeCapacity(kind.kind, {});
    }

    return map;
}

// Return a score for a particular priority. Duplicate instruction/operand enum values are
// removed by picking the tag with the lowest score to keep, and by making an alias for the
// other. Note that the tag does not need to be just a tag at this point, in which case it
// gets the lowest score automatically anyway.
fn tagPriorityScore(tag: []const u8) usize {
    if (tag.len == 0) {
        return 1;
    } else if (std.mem.eql(u8, tag, "EXT")) {
        return 2;
    } else if (std.mem.eql(u8, tag, "KHR")) {
        return 3;
    } else {
        return 4;
    }
}

fn render(writer: anytype, allocator: Allocator, registry: g.CoreRegistry) !void {
    try writer.writeAll(
        \\//! This file is auto-generated by tools/gen_spirv_spec.zig.
        \\
        \\pub const Version = packed struct(Word) {
        \\    padding: u8 = 0,
        \\    minor: u8,
        \\    major: u8,
        \\    padding0: u8 = 0,
        \\
        \\    pub fn toWord(self: @This()) Word {
        \\        return @bitCast(self);
        \\    }
        \\};
        \\
        \\pub const Word = u32;
        \\pub const IdResult = struct{
        \\    id: Word,
        \\};
        \\pub const IdResultType = IdResult;
        \\pub const IdRef = IdResult;
        \\
        \\pub const IdMemorySemantics = IdRef;
        \\pub const IdScope = IdRef;
        \\
        \\pub const LiteralInteger = Word;
        \\pub const LiteralString = []const u8;
        \\pub const LiteralContextDependentNumber = union(enum) {
        \\    int32: i32,
        \\    uint32: u32,
        \\    int64: i64,
        \\    uint64: u64,
        \\    float32: f32,
        \\    float64: f64,
        \\};
        \\pub const LiteralExtInstInteger = struct{ inst: Word };
        \\pub const LiteralSpecConstantOpInteger = struct { opcode: Opcode };
        \\pub const PairLiteralIntegerIdRef = struct { value: LiteralInteger, label: IdRef };
        \\pub const PairIdRefLiteralInteger = struct { target: IdRef, member: LiteralInteger };
        \\pub const PairIdRefIdRef = [2]IdRef;
        \\
        \\pub const Quantifier = enum {
        \\    required,
        \\    optional,
        \\    variadic,
        \\};
        \\
        \\pub const Operand = struct {
        \\    kind: OperandKind,
        \\    quantifier: Quantifier,
        \\};
        \\
        \\pub const OperandCategory = enum {
        \\    bit_enum,
        \\    value_enum,
        \\    id,
        \\    literal,
        \\    composite,
        \\};
        \\
        \\pub const Enumerant = struct {
        \\    name: []const u8,
        \\    value: Word,
        \\    parameters: []const OperandKind,
        \\};
        \\
        \\
    );

    try writer.print(
        \\pub const version = Version{{ .major = {}, .minor = {}, .patch = {} }};
        \\pub const magic_number: Word = {s};
        \\
        \\
    ,
        .{ registry.major_version, registry.minor_version, registry.revision, registry.magic_number },
    );

    const extended_structs = try extendedStructs(allocator, registry.operand_kinds);
    try renderClass(writer, allocator, registry.instructions);
    try renderOperandKind(writer, registry.operand_kinds);
    try renderOpcodes(writer, allocator, registry.instructions, extended_structs);
    try renderOperandKinds(writer, allocator, registry.operand_kinds, extended_structs);
}

fn renderClass(writer: anytype, allocator: Allocator, instructions: []const g.Instruction) !void {
    var class_map = std.StringArrayHashMap(void).init(allocator);

    for (instructions) |inst| {
        if (std.mem.eql(u8, inst.class.?, "@exclude")) {
            continue;
        }
        try class_map.put(inst.class.?, {});
    }

    try writer.writeAll("pub const Class = enum {\n");
    for (class_map.keys()) |class| {
        try renderInstructionClass(writer, class);
        try writer.writeAll(",\n");
    }
    try writer.writeAll("};\n");
}

fn renderInstructionClass(writer: anytype, class: []const u8) !void {
    // Just assume that these wont clobber zig builtin types.
    var prev_was_sep = true;
    for (class) |c| {
        switch (c) {
            '-', '_' => prev_was_sep = true,
            else => if (prev_was_sep) {
                try writer.writeByte(std.ascii.toUpper(c));
                prev_was_sep = false;
            } else {
                try writer.writeByte(std.ascii.toLower(c));
            },
        }
    }
}

fn renderOperandKind(writer: anytype, operands: []const g.OperandKind) !void {
    try writer.writeAll("pub const OperandKind = enum {\n");
    for (operands) |operand| {
        try writer.print("{},\n", .{std.zig.fmtId(operand.kind)});
    }
    try writer.writeAll(
        \\
        \\pub fn category(self: OperandKind) OperandCategory {
        \\return switch (self) {
        \\
    );
    for (operands) |operand| {
        const cat = switch (operand.category) {
            .BitEnum => "bit_enum",
            .ValueEnum => "value_enum",
            .Id => "id",
            .Literal => "literal",
            .Composite => "composite",
        };
        try writer.print(".{} => .{s},\n", .{ std.zig.fmtId(operand.kind), cat });
    }
    try writer.writeAll(
        \\};
        \\}
        \\pub fn enumerants(self: OperandKind) []const Enumerant {
        \\return switch (self) {
        \\
    );
    for (operands) |operand| {
        switch (operand.category) {
            .BitEnum, .ValueEnum => {},
            else => {
                try writer.print(".{} => unreachable,\n", .{std.zig.fmtId(operand.kind)});
                continue;
            },
        }

        try writer.print(".{} => &[_]Enumerant{{", .{std.zig.fmtId(operand.kind)});
        for (operand.enumerants.?) |enumerant| {
            if (enumerant.value == .bitflag and std.mem.eql(u8, enumerant.enumerant, "None")) {
                continue;
            }
            try renderEnumerant(writer, enumerant);
            try writer.writeAll(",");
        }
        try writer.writeAll("},\n");
    }
    try writer.writeAll("};\n}\n};\n");
}

fn renderEnumerant(writer: anytype, enumerant: g.Enumerant) !void {
    try writer.print(".{{.name = \"{s}\", .value = ", .{enumerant.enumerant});
    switch (enumerant.value) {
        .bitflag => |flag| try writer.writeAll(flag),
        .int => |int| try writer.print("{}", .{int}),
    }
    try writer.writeAll(", .parameters = &[_]OperandKind{");
    for (enumerant.parameters, 0..) |param, i| {
        if (i != 0)
            try writer.writeAll(", ");
        // Note, param.quantifier will always be one.
        try writer.print(".{}", .{std.zig.fmtId(param.kind)});
    }
    try writer.writeAll("}}");
}

fn renderOpcodes(
    writer: anytype,
    allocator: Allocator,
    instructions: []const g.Instruction,
    extended_structs: ExtendedStructSet,
) !void {
    var inst_map = std.AutoArrayHashMap(u32, usize).init(allocator);
    try inst_map.ensureTotalCapacity(instructions.len);

    var aliases = std.ArrayList(struct { inst: usize, alias: usize }).init(allocator);
    try aliases.ensureTotalCapacity(instructions.len);

    for (instructions, 0..) |inst, i| {
        if (std.mem.eql(u8, inst.class.?, "@exclude")) {
            continue;
        }
        const result = inst_map.getOrPutAssumeCapacity(inst.opcode);
        if (!result.found_existing) {
            result.value_ptr.* = i;
            continue;
        }

        const existing = instructions[result.value_ptr.*];

        const tag_index = std.mem.indexOfDiff(u8, inst.opname, existing.opname).?;
        const inst_priority = tagPriorityScore(inst.opname[tag_index..]);
        const existing_priority = tagPriorityScore(existing.opname[tag_index..]);

        if (inst_priority < existing_priority) {
            aliases.appendAssumeCapacity(.{ .inst = result.value_ptr.*, .alias = i });
            result.value_ptr.* = i;
        } else {
            aliases.appendAssumeCapacity(.{ .inst = i, .alias = result.value_ptr.* });
        }
    }

    const instructions_indices = inst_map.values();

    try writer.writeAll("pub const Opcode = enum(u16) {\n");
    for (instructions_indices) |i| {
        const inst = instructions[i];
        try writer.print("{} = {},\n", .{ std.zig.fmtId(inst.opname), inst.opcode });
    }

    try writer.writeByte('\n');

    for (aliases.items) |alias| {
        try writer.print("pub const {} = Opcode.{};\n", .{
            std.zig.fmtId(instructions[alias.inst].opname),
            std.zig.fmtId(instructions[alias.alias].opname),
        });
    }

    try writer.writeAll(
        \\
        \\pub fn Operands(comptime self: Opcode) type {
        \\return switch (self) {
        \\
    );

    for (instructions_indices) |i| {
        const inst = instructions[i];
        try renderOperand(writer, .instruction, inst.opname, inst.operands, extended_structs);
    }

    try writer.writeAll(
        \\};
        \\}
        \\pub fn operands(self: Opcode) []const Operand {
        \\return switch (self) {
        \\
    );

    for (instructions_indices) |i| {
        const inst = instructions[i];
        try writer.print(".{} => &[_]Operand{{", .{std.zig.fmtId(inst.opname)});
        for (inst.operands) |operand| {
            const quantifier = if (operand.quantifier) |q|
                switch (q) {
                    .@"?" => "optional",
                    .@"*" => "variadic",
                }
            else
                "required";

            try writer.print(".{{.kind = .{s}, .quantifier = .{s}}},", .{ operand.kind, quantifier });
        }
        try writer.writeAll("},\n");
    }

    try writer.writeAll(
        \\};
        \\}
        \\pub fn class(self: Opcode) Class {
        \\return switch (self) {
        \\
    );

    for (instructions_indices) |i| {
        const inst = instructions[i];
        try writer.print(".{} => .", .{std.zig.fmtId(inst.opname)});
        try renderInstructionClass(writer, inst.class.?);
        try writer.writeAll(",\n");
    }

    try writer.writeAll("};\n}\n};\n");
}

fn renderOperandKinds(
    writer: anytype,
    allocator: Allocator,
    kinds: []const g.OperandKind,
    extended_structs: ExtendedStructSet,
) !void {
    for (kinds) |kind| {
        switch (kind.category) {
            .ValueEnum => try renderValueEnum(writer, allocator, kind, extended_structs),
            .BitEnum => try renderBitEnum(writer, allocator, kind, extended_structs),
            else => {},
        }
    }
}

fn renderValueEnum(
    writer: anytype,
    allocator: Allocator,
    enumeration: g.OperandKind,
    extended_structs: ExtendedStructSet,
) !void {
    const enumerants = enumeration.enumerants orelse return error.InvalidRegistry;

    var enum_map = std.AutoArrayHashMap(u32, usize).init(allocator);
    try enum_map.ensureTotalCapacity(enumerants.len);

    var aliases = std.ArrayList(struct { enumerant: usize, alias: usize }).init(allocator);
    try aliases.ensureTotalCapacity(enumerants.len);

    for (enumerants, 0..) |enumerant, i| {
        const result = enum_map.getOrPutAssumeCapacity(enumerant.value.int);
        if (!result.found_existing) {
            result.value_ptr.* = i;
            continue;
        }

        const existing = enumerants[result.value_ptr.*];

        const tag_index = std.mem.indexOfDiff(u8, enumerant.enumerant, existing.enumerant).?;
        const enum_priority = tagPriorityScore(enumerant.enumerant[tag_index..]);
        const existing_priority = tagPriorityScore(existing.enumerant[tag_index..]);

        if (enum_priority < existing_priority) {
            aliases.appendAssumeCapacity(.{ .enumerant = result.value_ptr.*, .alias = i });
            result.value_ptr.* = i;
        } else {
            aliases.appendAssumeCapacity(.{ .enumerant = i, .alias = result.value_ptr.* });
        }
    }

    const enum_indices = enum_map.values();

    try writer.print("pub const {s} = enum(u32) {{\n", .{std.zig.fmtId(enumeration.kind)});

    for (enum_indices) |i| {
        const enumerant = enumerants[i];
        if (enumerant.value != .int) return error.InvalidRegistry;

        try writer.print("{} = {},\n", .{ std.zig.fmtId(enumerant.enumerant), enumerant.value.int });
    }

    try writer.writeByte('\n');

    for (aliases.items) |alias| {
        try writer.print("pub const {} = {}.{};\n", .{
            std.zig.fmtId(enumerants[alias.enumerant].enumerant),
            std.zig.fmtId(enumeration.kind),
            std.zig.fmtId(enumerants[alias.alias].enumerant),
        });
    }

    if (!extended_structs.contains(enumeration.kind)) {
        try writer.writeAll("};\n");
        return;
    }

    try writer.print("\npub const Extended = union({}) {{\n", .{std.zig.fmtId(enumeration.kind)});

    for (enum_indices) |i| {
        const enumerant = enumerants[i];
        try renderOperand(writer, .@"union", enumerant.enumerant, enumerant.parameters, extended_structs);
    }

    try writer.writeAll("};\n};\n");
}

fn renderBitEnum(
    writer: anytype,
    allocator: Allocator,
    enumeration: g.OperandKind,
    extended_structs: ExtendedStructSet,
) !void {
    try writer.print("pub const {s} = packed struct {{\n", .{std.zig.fmtId(enumeration.kind)});

    var flags_by_bitpos = [_]?usize{null} ** 32;
    const enumerants = enumeration.enumerants orelse return error.InvalidRegistry;

    var aliases = std.ArrayList(struct { flag: usize, alias: u5 }).init(allocator);
    try aliases.ensureTotalCapacity(enumerants.len);

    for (enumerants, 0..) |enumerant, i| {
        if (enumerant.value != .bitflag) return error.InvalidRegistry;
        const value = try parseHexInt(enumerant.value.bitflag);
        if (value == 0) {
            continue; // Skip 'none' items
        }

        std.debug.assert(@popCount(value) == 1);

        const bitpos = std.math.log2_int(u32, value);
        if (flags_by_bitpos[bitpos]) |*existing| {
            const tag_index = std.mem.indexOfDiff(u8, enumerant.enumerant, enumerants[existing.*].enumerant).?;
            const enum_priority = tagPriorityScore(enumerant.enumerant[tag_index..]);
            const existing_priority = tagPriorityScore(enumerants[existing.*].enumerant[tag_index..]);

            if (enum_priority < existing_priority) {
                aliases.appendAssumeCapacity(.{ .flag = existing.*, .alias = bitpos });
                existing.* = i;
            } else {
                aliases.appendAssumeCapacity(.{ .flag = i, .alias = bitpos });
            }
        } else {
            flags_by_bitpos[bitpos] = i;
        }
    }

    for (flags_by_bitpos, 0..) |maybe_flag_index, bitpos| {
        if (maybe_flag_index) |flag_index| {
            try writer.print("{}", .{std.zig.fmtId(enumerants[flag_index].enumerant)});
        } else {
            try writer.print("_reserved_bit_{}", .{bitpos});
        }

        try writer.writeAll(": bool = false,\n");
    }

    try writer.writeByte('\n');

    for (aliases.items) |alias| {
        try writer.print("pub const {}: {} = .{{.{} = true}};\n", .{
            std.zig.fmtId(enumerants[alias.flag].enumerant),
            std.zig.fmtId(enumeration.kind),
            std.zig.fmtId(enumerants[flags_by_bitpos[alias.alias].?].enumerant),
        });
    }

    if (!extended_structs.contains(enumeration.kind)) {
        try writer.writeAll("};\n");
        return;
    }

    try writer.print("\npub const Extended = struct {{\n", .{});

    for (flags_by_bitpos, 0..) |maybe_flag_index, bitpos| {
        const flag_index = maybe_flag_index orelse {
            try writer.print("_reserved_bit_{}: bool = false,\n", .{bitpos});
            continue;
        };
        const enumerant = enumerants[flag_index];

        try renderOperand(writer, .mask, enumerant.enumerant, enumerant.parameters, extended_structs);
    }

    try writer.writeAll("};\n};\n");
}

fn renderOperand(
    writer: anytype,
    kind: enum {
        @"union",
        instruction,
        mask,
    },
    field_name: []const u8,
    parameters: []const g.Operand,
    extended_structs: ExtendedStructSet,
) !void {
    if (kind == .instruction) {
        try writer.writeByte('.');
    }
    try writer.print("{}", .{std.zig.fmtId(field_name)});
    if (parameters.len == 0) {
        switch (kind) {
            .@"union" => try writer.writeAll(",\n"),
            .instruction => try writer.writeAll(" => void,\n"),
            .mask => try writer.writeAll(": bool = false,\n"),
        }
        return;
    }

    if (kind == .instruction) {
        try writer.writeAll(" => ");
    } else {
        try writer.writeAll(": ");
    }

    if (kind == .mask) {
        try writer.writeByte('?');
    }

    try writer.writeAll("struct{");

    for (parameters, 0..) |param, j| {
        if (j != 0) {
            try writer.writeAll(", ");
        }

        try renderFieldName(writer, parameters, j);
        try writer.writeAll(": ");

        if (param.quantifier) |q| {
            switch (q) {
                .@"?" => try writer.writeByte('?'),
                .@"*" => try writer.writeAll("[]const "),
            }
        }

        try writer.print("{}", .{std.zig.fmtId(param.kind)});

        if (extended_structs.contains(param.kind)) {
            try writer.writeAll(".Extended");
        }

        if (param.quantifier) |q| {
            switch (q) {
                .@"?" => try writer.writeAll(" = null"),
                .@"*" => try writer.writeAll(" = &.{}"),
            }
        }
    }

    try writer.writeAll("}");

    if (kind == .mask) {
        try writer.writeAll(" = null");
    }

    try writer.writeAll(",\n");
}

fn renderFieldName(writer: anytype, operands: []const g.Operand, field_index: usize) !void {
    const operand = operands[field_index];

    // Should be enough for all names - adjust as needed.
    var name_backing_buffer: [64]u8 = undefined;
    var name_buffer = std.ArrayListUnmanaged(u8).initBuffer(&name_backing_buffer);

    derive_from_kind: {
        // Operand names are often in the json encoded as "'Name'" (with two sets of quotes).
        // Additionally, some operands have ~ in them at the end (D~ref~).
        const name = std.mem.trim(u8, operand.name, "'~");
        if (name.len == 0) {
            break :derive_from_kind;
        }

        // Some names have weird characters in them (like newlines) - skip any such ones.
        // Use the same loop to transform to snake-case.
        for (name) |c| {
            switch (c) {
                'a'...'z', '0'...'9' => name_buffer.appendAssumeCapacity(c),
                'A'...'Z' => name_buffer.appendAssumeCapacity(std.ascii.toLower(c)),
                ' ', '~' => name_buffer.appendAssumeCapacity('_'),
                else => break :derive_from_kind,
            }
        }

        // Assume there are no duplicate 'name' fields.
        try writer.print("{}", .{std.zig.fmtId(name_buffer.items)});
        return;
    }

    // Translate to snake case.
    name_buffer.items.len = 0;
    for (operand.kind, 0..) |c, i| {
        switch (c) {
            'a'...'z', '0'...'9' => name_buffer.appendAssumeCapacity(c),
            'A'...'Z' => if (i > 0 and std.ascii.isLower(operand.kind[i - 1])) {
                name_buffer.appendSliceAssumeCapacity(&[_]u8{ '_', std.ascii.toLower(c) });
            } else {
                name_buffer.appendAssumeCapacity(std.ascii.toLower(c));
            },
            else => unreachable, // Assume that the name is valid C-syntax (and contains no underscores).
        }
    }

    try writer.print("{}", .{std.zig.fmtId(name_buffer.items)});

    // For fields derived from type name, there could be any amount.
    // Simply check against all other fields, and if another similar one exists, add a number.
    const need_extra_index = for (operands, 0..) |other_operand, i| {
        if (i != field_index and std.mem.eql(u8, operand.kind, other_operand.kind)) {
            break true;
        }
    } else false;

    if (need_extra_index) {
        try writer.print("_{}", .{field_index});
    }
}

fn parseHexInt(text: []const u8) !u31 {
    const prefix = "0x";
    if (!std.mem.startsWith(u8, text, prefix))
        return error.InvalidHexInt;
    return try std.fmt.parseInt(u31, text[prefix.len..], 16);
}

fn usageAndExit(file: std.fs.File, arg0: []const u8, code: u8) noreturn {
    file.writer().print(
        \\Usage: {s} <spirv json spec>
        \\
        \\Generates Zig bindings for a SPIR-V specification .json (either core or
        \\extinst versions). The result, printed to stdout, should be used to update
        \\files in src/codegen/spirv. Don't forget to format the output.
        \\
        \\The relevant specifications can be obtained from the SPIR-V registry:
        \\https://github.com/KhronosGroup/SPIRV-Headers/blob/master/include/spirv/unified1/
        \\
    , .{arg0}) catch std.process.exit(1);
    std.process.exit(code);
}
