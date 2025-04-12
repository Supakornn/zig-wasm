const std = @import("std");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});

    const target = std.Target.Query{
        .cpu_arch = .wasm32,
        .os_tag = .freestanding,
    };

    const lib = b.addExecutable(.{
        .name = "zig-wasm",
        .root_source_file = .{ .cwd_relative = "src/main.zig" },
        .target = b.resolveTargetQuery(target),
        .optimize = optimize,
    });

    lib.entry = .disabled;
    lib.rdynamic = true;

    const install_step = b.addInstallArtifact(lib, .{});
    b.getInstallStep().dependOn(&install_step.step);
}
