module uart_receiver_fpga_program(
    input wire clk,
    input wire rx,
    output reg [7:0] data_out,
    output reg valid,
    output reg programming_done  // 프로그래밍 완료 신호
);

    parameter BAUD_RATE = 115200;
    parameter CLOCK_FREQ = 100000000; // Assuming 100 MHz clock for Nexys A7

    reg [15:0] baud_counter;
    reg [7:0] bit_index;
    reg receiving;
    reg [7:0] rx_shift_reg;

    reg [15:0] byte_counter;   // 비트스트림 전송 바이트 수 카운터

    initial begin
        baud_counter = 0;
        bit_index = 0;
        receiving = 0;
        rx_shift_reg = 0;
        data_out = 0;
        valid = 0;
        programming_done = 0;
        byte_counter = 0;
    end

    always @(posedge clk) begin
        if (!receiving) begin
            if (!rx) begin  // Start bit detected
                receiving <= 1;
                baud_counter <= (CLOCK_FREQ / BAUD_RATE) / 2; // 중간에서 시작
            end
        end else begin
            baud_counter <= baud_counter - 1;
            if (baud_counter == 0) begin
                baud_counter <= CLOCK_FREQ / BAUD_RATE;
                if (bit_index < 8) begin
                    rx_shift_reg[bit_index] <= rx;  // 데이터 비트를 시프트하여 수신
                    bit_index <= bit_index + 1;
                end else if (bit_index == 8) begin
                    data_out <= rx_shift_reg;  // 데이터가 준비됨
                    valid <= 1;
                    receiving <= 0;
                    bit_index <= 0;
                    byte_counter <= byte_counter + 1;  // 비트스트림 바이트 수 증가
                end
            end
        end

        // 특정 바이트 수에 도달하면 프로그래밍 완료
        if (byte_counter == EXPECTED_BITSTREAM_SIZE) begin
            programming_done <= 1;  // 비트스트림 전송 완료
        end
    end
endmodule
