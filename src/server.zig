const std = @import("std");

const Position = packed struct {
    x: f64,
    y: f64,
};

pub fn main() !void {
    const p1 = Position{ .x = 0, .y = 0};
    var p2 = Position{ .x = 0, .y = 0};

    // wait for peer to connect
    var srv = try std.net.Address.listen(
        try std.net.Address.parseIp4("127.0.0.1", 8954), .{}
    );

    std.debug.print("waiting for peer on 127.0.0.1:8954\n", .{});
    const conn = try srv.accept();

    std.debug.print("accepted connection from {}\n", .{conn.address});

    while (true) {
        p2 = try conn.stream.reader().readStruct(Position);
        std.debug.print("p1: {}, p2: {}\n", .{p1, p2});
    }
}
