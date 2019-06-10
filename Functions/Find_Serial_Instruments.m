function [Device_List] = Find_Serial_Instruments()
%Find Serial Instruments 
%   Detailed explanation goes here
Device_List = [];
Default_Comports = readtable('Default_Comports.txt');
Found_Serial_Ports = seriallist;
Lakeshore_Default = Default_Comports{1,1};
Sierra_Default = Default_Comports{1,2};
VQM_Default = Default_Comports{1,3};
Arduino_Default = Default_Comports{1,4};
if ~isempty(Found_Serial_Ports)
    for idx = 1:length(Found_Serial_Ports)

   
            switch Found_Serial_Ports(idx)
                case Sierra_Default
                      Device_List = [Device_List, "Sierra Instruments Microtrak Controller"];
                case VQM_Default
                      Device_List = [Device_List, "Granvillie Phillips VQM"];
                case Lakeshore_Default
                      Device_List = [Device_List, "Lakeshore 336 Temperature Controller"];
                      
                case Arduino_Default 
                      Device_List = [Device_List, "Arduino"];
                otherwise
                      
                      Device_List = [Device_List,"Unknown Instruments Found"];
            end
            
    end
         elseif isempty(Found_Serial_Ports) == 1
                      Device_List = "No Instruments Found";
                      msgbox('No Instrument Found.');

        
end

