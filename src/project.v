/*
 * PWM colour mixer: three PWM channels drive the red, green and blue of one LED.
 *
 *   ui_in[1:0]  red level,   0 to 3
 *   ui_in[3:2]  green level, 0 to 3
 *   ui_in[5:4]  blue level,  0 to 3
 *
 *   uo_out[0]   red PWM
 *   uo_out[1]   green PWM
 *   uo_out[2]   blue PWM
 *
 * One PWM period is three clock ticks. A colour's level is the number of those
 * three ticks its output is on for: 0 is off, and 3 is on all the time.
 */

`default_nettype none

module tt_um_rrrrruby1024_pwm_colour_mixer (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    // The level for each colour, from its two switches: 0, 1, 2 or 3.
    wire [1:0] red_level   = ui_in[1:0];
    wire [1:0] green_level = ui_in[3:2];
    wire [1:0] blue_level  = ui_in[5:4];

    // Step 1: declare the counter here.
    reg [1:0] count;  
    // Step 2: make the counter count 0, 1, 2 and round again here.
    always @(posedge clk) begin
    if (!rst_n) begin
        count <= 2'd0;
    end else if (count == 2'd2) begin
        count <= 2'd0;
    end else begin
        count <= count + 2'd1;
    end
end
    // Steps 3 and 4: each output is high while the counter is below its level.
    wire red   = (count < red_level);
    wire green = (count < green_level);
    wire blue  = (count < blue_level);

    assign uo_out  = {5'b0, blue, green, red};
    assign uio_out = 8'h00;
    assign uio_oe  = 8'h00;

    wire _unused_ok = &{ena, clk, rst_n, ui_in[7:6], uio_in, red_level, green_level, blue_level};

endmodule
