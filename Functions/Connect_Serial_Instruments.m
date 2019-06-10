function Connect_Serial_Instruments(Instruments)
%Connect_Serial_Devices
%   Checks which serial devices were user selected and connects.

for idx = 1:length(Instruments)
    
        switch Instruments(idx)
    case 'Sierra Instruments Microtrak Controller'
        disp('Connecting to Flow Controller');
    case 'Granvillie Phillips VQM'
        disp('Connectiong to VQM');
    case 'Lakeshore 336 Temperature Controller'
        disp('Connecting to Temperature Controller')
    case 'Arduino'
        disp('Connecting to Arduino')
    otherwise
        msgbox('No Instrument Found.')
        end
end 
end

