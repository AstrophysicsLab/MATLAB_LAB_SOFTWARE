function CMD = CRC_Generator(message)
CR = 13; %% Removed from horzcat below. Matlab serial functions append Terminator
message = double(message);    
crc = uint16(hex2dec('ffff'));

    for i = 1:length(message)
        crc = bitxor(crc,bitshift(message(i),8));

        for j = 1:8
            if (bitand(crc, hex2dec('8000')) > 0)
                crc = bitxor(bitshift(crc, 1), hex2dec('1021'));
            else
                crc = bitshift(crc, 1);
            end
        end
    end

    crc_val = dec2hex(crc);
    temp = (crc_val);
    byte1 = hex2dec(temp(1:2));
    byte2 = hex2dec(temp(3:4));
    CMD = horzcat(message, byte1,byte2);
end