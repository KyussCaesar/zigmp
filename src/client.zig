const std = @import("std");

const Position = packed struct {
    x: f64,
    y: f64,
};

pub fn main() !void {
    var p2 = Position{ .x = 0, .y = 0};

    var conn = try std.net.tcpConnectToAddress(
        try std.net.Address.parseIp4("127.0.0.1", 8954)
    );

    while (true) {
        try conn.writer().writeStruct(p2);
        p2.x += 0.1;
    }
}
