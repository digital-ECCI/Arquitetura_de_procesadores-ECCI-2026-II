module banco_registros (
    input  wire        clk,         
    input  wire        rst,         
    input  wire [7:0]  data_in,     
    input  wire [2:0]  addr,
    input  wire        write_en,
    input  wire        read_en,
    output reg  [7:0]  data_out
);
    // 8 registros de 8 bits
    reg [7:0] registros [0:7];

    // Escritura 
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            registros[0] <= 8'b0;
            registros[1] <= 8'b0;
            registros[2] <= 8'b0;
            registros[3] <= 8'b0;
            registros[4] <= 8'b0;
            registros[5] <= 8'b0;
            registros[6] <= 8'b0;
            registros[7] <= 8'b0;
            data_out     <= 8'b0;
        end
        else begin
            if (write_en) begin

                case (addr)
                    3'b000: registros[0] <= data_in;
                    3'b001: registros[1] <= data_in;
                    3'b010: registros[2] <= data_in;
                    3'b011: registros[3] <= data_in;
                    3'b100: registros[4] <= data_in;
                    3'b101: registros[5] <= data_in;
                    3'b110: registros[6] <= data_in;
                    3'b111: registros[7] <= data_in;
                    default: ;
                endcase
            end

            //Lectura
            if (read_en) begin
                case (addr)
                    3'b000: data_out <= registros[0];
                    3'b001: data_out <= registros[1];
                    3'b010: data_out <= registros[2];
                    3'b011: data_out <= registros[3];
                    3'b100: data_out <= registros[4];
                    3'b101: data_out <= registros[5];
                    3'b110: data_out <= registros[6];
                    3'b111: data_out <= registros[7];
                    default: data_out <= 8'b0;
                endcase
            end
        end
    end
endmodule