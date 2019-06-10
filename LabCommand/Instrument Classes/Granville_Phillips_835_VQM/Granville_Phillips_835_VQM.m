classdef Granville_Phillips_835_VQM < handle
    %GRANVILLE_PHILLIPS_835_VQM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Current_Pressure;
        Pressure_Units;
        Delta_Pressure;
        Serial_Obj;
        Comport;
        Log_Pressure;
         
    end
    
    methods
        
        
        function get_VQM_Data(obj)
%get_VQM_Data Function retrives VQM data from serial(Vacuum Quality Monitor) 
%   

            query(obj.Serial_Obj,'fetch?');   % Queries controller for data

        end
        function Get_Total_Pressure(obj)
            fprintf(obj.Serial_Obj,'inst etpr');
            fprintf(obj.Serial_Obj,'outp on');
            obj.Current_Pressure = str2double(query(obj.Serial_Obj, 'meas:pres?'));
        end
        
        function Get_Pressure_Units(obj)
            query(obj.Serial_Obj,'CONF:units?' )
        
        end
        function Add_Log_Data(obj)
           obj.Log_Pressure{end+1} = obj.Current_Pressure; 
        end
        
        function VQM_Update(obj)
           obj.Get_Total_Pressure();
           obj.Add_Log_Data()
        end
        
        function  VQM_Serial_Create(obj )
            %VQM_Serial Creates serial object for VQM controller.
            %Serial_Obj = serial('COM4');  % Creates theserial object on comport 4
            %deskmachine
            
            obj.Serial_Obj = serial(obj.Comport);
            obj.Serial_Obj.Terminator = 'CR';    % Set the terminator to carriage return
            obj.Serial_Obj.InputBufferSize = 1024; % Increases the input buffer size
            fopen(obj.Serial_Obj);
        end
        
        function VQM_Set_Comport(obj, Comport)
           obj.Comport = Comport; 
        end

        function Delta_Pressure_over_Delta_Time(obj , Time_Log)
            obj.Delta_Pressure = diff(obj.Pressure_Log)./ diff(Time_Log);
        end
        
        
    end
    
end

