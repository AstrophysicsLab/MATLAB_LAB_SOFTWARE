function [ Data ] = get_VQM_Data( Serial_Obj )
%get_VQM_Data Function retrives VQM data from serial(Vacuum Quality Monitor) 
%   

Data = query(Serial_Obj,'fetch?');   % Queries controller for data

end

