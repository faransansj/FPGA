module seven_segment_controller (
  input wire clk,
  input wire [4:0] buttons, // BTNL, BTNR, BTNU, BTND, BTNC
  output reg [7:0] segment_display, // 7-segment display output
  output reg [7:0] digit_enable // enable specific digit
);
  reg [3:0] digit_value [7:0]; // Values for each of the 8 digits
  reg [2:0] current_digit = 0; // Pointer to the current digit (0 to 7)
  reg [22:0] counter = 0; // Counter for button debouncing and display multiplexing
  reg [4:0] prev_buttons = 0; // Previous button state for edge detection
  reg edit_mode = 0; // Toggle for edit mode
  reg blink_state = 0; // Blink state for the current digit

  // Button logic for navigating and editing
  always @(posedge clk) begin
    counter <= counter + 1;

    // Debounce and edge detection
    if (counter == 23'h7FFFFF) begin
      // Move left/right to select digit
      if (buttons[0] && !prev_buttons[0]) // BTNL
        current_digit <= (current_digit == 0) ? 7 : current_digit - 1;
      else if (buttons[1] && !prev_buttons[1]) // BTNR
        current_digit <= (current_digit == 7) ? 0 : current_digit + 1;

      // Toggle edit mode
      if (buttons[4] && !prev_buttons[4]) // BTNC
        edit_mode <= ~edit_mode;

      // Increment/decrement selected digit value in edit mode
      if (edit_mode) begin
        if (buttons[2] && !prev_buttons[2]) // BTNU
          digit_value[current_digit] <= (digit_value[current_digit] == 9) ? 0 : digit_value[current_digit] + 1;
        else if (buttons[3] && !prev_buttons[3]) // BTND
          digit_value[current_digit] <= (digit_value[current_digit] == 0) ? 9 : digit_value[current_digit] - 1;
      end

      // Store button states for next cycle
      prev_buttons <= buttons;
    end

    // Blink logic (toggle every ~0.5 seconds)
    if (counter[21:0] == 22'h3FFFFF) begin
      blink_state <= ~blink_state;
    end
  end

  // 7-segment multiplexing logic
  reg [2:0] display_digit = 0;
  always @(posedge clk) begin
    if (counter[15:0] == 16'hFFFF) begin
      display_digit <= display_digit + 1;
      // Enable only the current display digit
      digit_enable <= ~(1 << display_digit);
      
      // Display logic
      if (display_digit == current_digit && !edit_mode && !blink_state)
        segment_display <= 8'b11111111; // Turn off the current digit for blinking
      else
        segment_display <= digit_to_7segment(digit_value[display_digit]);
    end
  end

  // Function to convert a digit (0-9) to the 7-segment display pattern
  function [7:0] digit_to_7segment;
    input [3:0] digit;
    case (digit)
      4'd0: digit_to_7segment = 8'b11000000; // 0
      4'd1: digit_to_7segment = 8'b11111001; // 1
      4'd2: digit_to_7segment = 8'b10100100; // 2
      4'd3: digit_to_7segment = 8'b10110000; // 3
      4'd4: digit_to_7segment = 8'b10011001; // 4
      4'd5: digit_to_7segment = 8'b10010010; // 5
      4'd6: digit_to_7segment = 8'b10000010; // 6
      4'd7: digit_to_7segment = 8'b11111000; // 7
      4'd8: digit_to_7segment = 8'b10000000; // 8
      4'd9: digit_to_7segment = 8'b10010000; // 9
      default: digit_to_7segment = 8'b11111111; // blank
    endcase
  endfunction

endmodule
