function [ Pressure_Data ] = Get_Total_Pressure( Serial_Obj )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
fprintf(Serial_Obj,'inst etpr');
fprintf(Serial_Obj,'outp on');
Pressure_Data = str2double(query(Serial_Obj, 'meas:pres?'));

end

