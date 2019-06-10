classdef ArduinoDHTSerial < handle      %% Class less than handle ensures one instance of class

    
   properties
       
       % There are four temperature readings%% These variables store the current Temperatures
        Current_Temperature;
        Temperature_Log;
        Send_Log;
        Log_Filename;
        Log_Filepath;
        Log_File_Extension;
        CSV_Data = table;
        Comport;
        Serial_Object;
        val=0:1:15;
    end
    
    
    % Class Functions
    methods    
        
        function Get_Temperatures_Kelvin(obj)
        % Queries controller for temperature values in Kelvin 
            Celsius = query(obj.Serial_Object,'t') ;
            Celsius = Celsius(1:5);
            Celsius = str2double(Celsius);
            obj.Current_Temperature = Celsius + 273;
        end


       function Update_Data(obj)
            % This function is used for for updating Log data either in a 
            % standalone application or in a multicontroller GUI, usually 
            % this would involve calling this function in a timer.
            %obj.Get_Temperatures_Kelvin( );
            %disp('In Class Update Data ')
            %disp(obj.Current_Temperature)
            obj.Current_Temperature = randi([8 20], 1);%*1E-7;
            
           obj.Add_Log_Data();
       end 
        
       function Add_Log_Data(obj)
           % Adds Log Data, To be called directly after
           % Update_Data
           
            
          obj.Temperature_Log{end+1} = obj.Current_Temperature;
          obj.Send_Log = cell2mat(obj.Temperature_Log);

       end
        
       
       function Write_Log_Data(obj)
           % Organizes Log Data for unsert into table
           % Currently setup for standalone, needs to be set so all
           % controllers log data will in table format to be added to a final table
           % and written to final file.
           %disp('Write Log!!') 
            obj.Temperature_Log = obj.Temperature_Log(:);
          
       
           obj.CSV_Data = table(obj.Temperature_Log);
           obj.CSV_Data.Properties.VariableNames = {'Temperature_A'};   
           writetable(obj.CSV_Data, obj.Log_Filename, 'Delimiter', '\t')
          % writetable(obj.CSV_Data, 'myTable.txt', 'Delimiter', ' ');
           % writetable(obj.CSV_Data);
           
           
           
       end
       
       function Log_File_Create(obj)
            %UNTITLED Summary of this function goes here
            %   Detailed explanation goes here

            [obj.Log_Filename, obj.Log_Filepath] = uiputfile('.txt', 'Choose Location and Filename');
            

       end
       
       function Serial_Create( obj)
       %
       %serial object
            
            %Lakeshore_Serial_Obj = serial('COM3');
            obj. Serial_Object = serial(obj.Comport);
            obj.Serial_Object.BaudRate = 9600;
            fopen(obj.Serial_Object);
            pause(1.75);
            query(obj.Serial_Object,'t'); 
            disp('Serial create')
           
            
end
       
       
       function Get_Serial_Obj(obj,Serial_Obj)
       obj.Serial_Object = Serial_Obj;
       end
       function Set_Comport(obj, Comport)
       obj.Comport = Comport;
       
           
       end
      
end
end
