const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const sqlite3 = b.dependency("sqlite3", .{
        .target = target,
        .optimize = optimize,
    });

    const lib = b.addStaticLibrary(.{
        .name = "sqlite3",
        .target = target,
        .optimize = optimize,
    });

    lib.linkLibC();
    lib.addCSourceFile(.{
        .file = sqlite3.path("sqlite3.c"),
        .flags = &.{
            "-std=c99",
            "-Weverything",
            "-Werror",
            "-Wno-atomic-implicit-seq-cst",
            "-Wno-cast-align",
            "-Wno-cast-function-type-strict",
            "-Wno-cast-qual",
            "-Wno-comma",
            "-Wno-disabled-macro-expansion",
            "-Wno-double-promotion",
            "-Wno-extra-semi-stmt",
            "-Wno-float-equal",
            "-Wno-implicit-fallthrough",
            "-Wno-implicit-float-conversion",
            "-Wno-implicit-int-conversion",
            "-Wno-implicit-int-float-conversion",
            "-Wno-missing-variable-declarations",
            "-Wno-padded",
            "-Wno-reserved-identifier",
            "-Wno-reserved-macro-identifier",
            "-Wno-shorten-64-to-32",
            "-Wno-sign-conversion",
            "-Wno-undef",
            "-Wno-unreachable-code-break",
            "-Wno-unreachable-code-return",
            "-Wno-unreachable-code",
            "-Wno-unsafe-buffer-usage",
            "-Wno-unused-macros",
        },
    });

    const trc = b.addTranslateC(.{
        .root_source_file = sqlite3.path("sqlite3.h"),
        .target = target,
        .optimize = optimize,
    });

    _ = b.addModule("sqlite3", .{
        .root_source_file = .{ .generated = &trc.output_file },
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(lib);
}
