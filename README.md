```zig
    const sqlite3 = b.dependency("sqlite3", .{
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("sqlite3", sqlite3.module("sqlite3"));
    exe.linkLibrary(sqlite3.artifact("sqlite3"));
```
