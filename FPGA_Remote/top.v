module top(
    input wire clk,
    input wire rst,
    input wire uart_rx,
    output wire programming_done
);

    wire [7:0] uart_data;
    wire data_valid;

    uart_receiver_fpga_program uart_inst(
        .clk(clk),
        .rx(uart_rx),
        .data_out(uart_data),
        .valid(data_valid),
        .programming_done(programming_done)
    );

    // 비트스트림을 FPGA에 프로그래밍하는 로직은 이곳에서 구현할 수 있습니다.
    // 예: Internal Configuration Access Port (ICAP)를 통한 프로그래밍 제어
endmodule
