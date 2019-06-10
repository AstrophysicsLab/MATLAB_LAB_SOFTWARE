classdef Lakeshore_336_Temperature_Controller < handle      %% Class less than handle ensures one instance of class
    %   Lakeshore_336_Temperature_Controller 
    %   This is an  class for the Lakeshore 336 Temperature Controller
    %   This class contains functions for sending commands and calling data
    %   as well as storing the data.
  
    
    properties
       
       % There are four temperature readings A-D %% These variables store the current Temperatures
       % Note Currently only A and C are untilized in the lab as of Fall 2018
        A_Current_Temperature;
        B_Current_Temperature;
        C_Current_Temperature;
        D_Current_Temperature;
   
       % There are two heaters:  Input 1 for A, and input 2 for C
       % There are four levels coresponding to a number
       % 0 = Off, 1 = Low, 2 = Medium, 3 = High.
        Input_1_Heater_Range;
        Input_2_Heater_Range;
        
        % A seperate variable holds the string value of the heater for readabiliy 
        Input_1_Heater_Range_Str;
        Input_2_Heater_Range_Str;
        
        % Temperature Setpoint for both heaters: 1 = A, 2 = C.
        Setpoint_1;
        Setpoint_2;
        % Stores Serial object for controller
        Serial_Object;
        Comport;
        % Variables holding Log Data
        A_Temperature_Log;
        B_Temperature_Log;
        C_Temperature_Log;
        D_Temperature_Log;
        
        Input_1_Heater_Range_Log;
        Input_2_Heater_Range_Log;
        
        Input_1_Heater_Range_Str_Log;
        Input_2_Heater_Range_Str_Log;
        
        % Temperature Setpoint: 1 = A, 2 = C.
        Setpoint_1_Log;
        Setpoint_2_Log;
        
        % Log Administration
        % Note this is for standalone use, in a GUI for multiple classes
        % the Gui itself would write the final file.
        Log_Filename;
        Log_Filepath;
        Log_File_Extension;
        CSV_Data = table;
        
    end
    
    
    % Class Functions for Lakeshore Temperature Controller
    methods    
        
        function Get_All_Temperatures_Kelvin(obj)
        % Queries controller for temperature values in Kelvin 
            obj.A_Current_Temperature = query(obj.Serial_Object,'KRDG? A');
            obj.B_Current_Temperature = query(obj.Serial_Object,'KRDG? B');
            obj.C_Current_Temperature = query(obj.Serial_Object,'KRDG? C');
            obj.D_Current_Temperature = query(obj.Serial_Object,'KRDG? D');
        
        end
        
        function Set_All_Temperatures_Kelvin(obj, Value, Range)
           % Sets_All_Temperatures at given Value and Range
           % Set All Ranges
           % Set Temperatures
        end
        
         function Set_Temperature_Setpoint_1(obj, Value)
           % Sets__Temperature at given Value and Range
           % Set Temperature
         end
        
        function Set_Temperature_Setpoint_2(obj, Value)
           % Sets__Temperature at given Value and Range
           % Set Temperature
        end
         
        function Get_Temperature_Setpoint(obj )
            %  Queries controller for Heater A(Output1) and Heater C(Output 2)
            obj.Setpoint_1 = query(obj.Serial_Object, 'SETP? 1');
            obj.Setpoint_2 = query(obj.Serial_Object, 'SETP? 2');
        end
       
        function  Get_Heater_Range( obj )   
            %Queries controller for Heater Range Values and parses for
            %string value
            obj.Input_1_Heater_Range = query(obj.Serial_Object, 'RANGE? 1');
            obj.Input_2_Heater_Range = query(obj.Serial_Object, 'RANGE? 2');
            if str2double(obj.Input_1_Heater_Range) == 0
                obj.Input_1_Heater_Range_Str = 'Off';
            elseif str2double(obj.Input_1_Heater_Range) == 1
                obj.Input_1_Heater_Range_Str = 'Low';
            elseif str2double(obj.Input_1_Heater_Range) == 2
                obj.Input_1_Heater_Range_Str = 'Medium';
            elseif str2double(obj.Input_1_Heater_Range) == 3
                obj.Input_1_Heater_Range_Str = 'High';
            end
            if str2double(obj.Input_2_Heater_Range) == 0
                obj.Input_2_Heater_Range_Str = 'Off';
            elseif str2double(obj.Input_2_Heater_Range) == 1
                obj.Input_2_Heater_Range_Str = 'Low';
            elseif str2double(obj.Input_2_Heater_Range) == 2
                obj.Input_2_Heater_Range_Str = 'Medium';
            elseif str2double(obj.Input_2_Heater_Range) == 3
                obj.Input_2_Heater_Range_Str = 'High';
            end


        end

        
        function Set_All_Range_1(obj, Range)
           % Sets_1 Range
           % Set Range
           
        end
        
        function Set_All_Range_2(obj, Range)
           % Sets_2 Range
           % Set Range
           
        end

       function Lakeshore_Update_Data(obj)
            % This function is used for for updating Log data either in a 
            % standalone application or in a multicontroller GUI, usually 
            % this would involve calling this function in a timer.
            obj.Get_All_Temperatures_Kelvin( );
            obj.Get_Heater_Range();
            obj.Get_Temperature_Setpoint();
       end 
        
       function Add_Log_Data(obj)
           % Adds Log Data, To be called directly after
           % Update_Lakeshore_Data
           
            
            obj.A_Temperature_Log{end+1} = str2double(obj.A_Current_Temperature);
            obj.B_Temperature_Log{end+1} = str2double(obj.B_Current_Temperature);
            obj.C_Temperature_Log{end+1} = str2double(obj.C_Current_Temperature);
            obj.D_Temperature_Log{end+1} = str2double(obj.D_Current_Temperature);
        
            obj.Input_1_Heater_Range_Log{end+1} = str2double(obj.Input_1_Heater_Range);
            obj.Input_2_Heater_Range_Log{end+1} = str2double(obj.Input_2_Heater_Range);
        
            obj.Input_1_Heater_Range_Str_Log{end+1} = obj.Input_1_Heater_Range_Str;
            obj.Input_2_Heater_Range_Str_Log{end+1} = obj.Input_2_Heater_Range_Str;
        
        % Temperature Setpoint: 1 = A, 2 = C.
            obj.Setpoint_1_Log{end+1} = str2double(obj.Setpoint_1);
            obj.Setpoint_2_Log{end+1} = str2double(obj.Setpoint_2);
       end
        
       
       function Write_Log_Data(obj)
           % Organizes Log Data for unsert into table
           % Currently setup for standalone, needs to be set so all
           % controllers log data will in table format to be added to a final table
           % and written to final file.
           %disp('Write Log!!') 
            obj.A_Temperature_Log = obj.A_Temperature_Log(:);
            disp(obj.A_Temperature_Log)
            obj.B_Temperature_Log = obj.B_Temperature_Log(:);
            obj.C_Temperature_Log = obj.C_Temperature_Log(:);
            obj.D_Temperature_Log = obj.D_Temperature_Log(:);
        
            obj.Input_1_Heater_Range_Log = obj.Input_1_Heater_Range_Log(:);
            obj.Input_2_Heater_Range_Log = obj.Input_2_Heater_Range_Log(:);
        
            obj.Input_1_Heater_Range_Str_Log = obj.Input_1_Heater_Range_Str_Log(:);
            obj.Input_2_Heater_Range_Str_Log = obj.Input_2_Heater_Range_Str_Log(:);
        
        % Temperature Setpoint: 1 = A, 2 = C.
            obj.Setpoint_1_Log = obj.Setpoint_1_Log(:);
            obj.Setpoint_2_Log = obj.Setpoint_2_Log(:);
           
           obj.CSV_Data = table(obj.A_Temperature_Log,obj.C_Temperature_Log , obj.Setpoint_1_Log,obj.Setpoint_2_Log);
           obj.CSV_Data.Properties.VariableNames = {'Temperature_A', 'Temperature_C', 'Setpoint_1', 'Setpoint_2'};   
           writetable(obj.CSV_Data, obj.Log_Filename, 'Delimiter', '\t')
          % writetable(obj.CSV_Data, 'myTable.txt', 'Delimiter', ' ');
           % writetable(obj.CSV_Data);
           
           
           
       end
       
       function Log_File_Create(obj)
            %UNTITLED Summary of this function goes here
            %   Detailed explanation goes here

            [obj.Log_Filename, obj.Log_Filepath] = uiputfile('.txt', 'Choose Location and Filename');
            

       end
       
       function Lakeshore_Serial_Create( obj)
       %Lakeshore_Temperature_Controller_Create  Creates  and configures Temperature controller
       %serial object
            
            %Lakeshore_Serial_Obj = serial('COM3');
            Lakeshore_Serial_Obj = serial(obj.Comport);
            Lakeshore_Serial_Obj.BaudRate = 57600;
            Lakeshore_Serial_Obj.Parity = 'odd';
            Lakeshore_Serial_Obj.DataBits = 7;
            obj.Serial_Object = Lakeshore_Serial_Obj;
            fopen(Lakeshore_Serial_Obj);
       end
       
       
       function Get_Serial_Obj(obj,Serial_Obj)
       obj.Serial_Object = Serial_Obj;
       end
       function Set_Comport(obj, Comport)
       obj.Comport = Comport;
       
           
       end
       function Temperature_C = Get_Log_Data(obj)
           Temperature_C = obj.C_Temperature_Log;
       end
       
end
end
