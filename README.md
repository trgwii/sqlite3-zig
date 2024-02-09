```sh
zig fetch --save https://github.com/trgwii/sqlite3-zig/archive/refs/tags/3.45.1.tar.gz
```

```zig
    const sqlite3 = b.dependency("sqlite3", .{
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("sqlite3", sqlite3.module("sqlite3"));
    exe.linkLibrary(sqlite3.artifact("sqlite3"));
```
