classdef Data_Management < handle
    %Plot_Management
    
    properties

        Name;
        Path;
        File_Path;
        File_Status;
        Data
        Data_Names;
        Instruments;
        Time_Points;
        Update_Functions;
       
    end
    
    methods
        
        
        function Open_File(obj)
            type = '../*.dat'; % Specify .dat files
            [name, path] =uigetfile(type);
            if name == 0
               msgbox('No File Selected.') 
            else  
                obj.File_Path = [path,name];
                obj.Read_Data();
            end   
        end
        
           function  Read_Data(obj)
            %obj.Data = readtable(obj.File_Path);
            obj.Data = readtable('C:\Users\admin\Documents\MATLAB_PROJECTS\LabCommand\June7thnew.dat');
            %app.UITable.Data = app.Data; 
            obj.Data_Names = string(obj.Data.Properties.VariableNames); 
            obj.Parse_Time();
            %app.Fill_Y_Data();
      
           end
           
           function Parse_Time(obj)
              if strcmp(obj.Data_Names(1),'DateTime')
                 Start = obj.Data.DateTime(1);
                 End = obj.Data.DateTime(end);
                 Duration = (End - Start);
                 obj.Time_Points = table(Start,End,Duration);
                 obj.File_Status = 1;
                 obj.Instruments = obj.Data_Names(3:end);
              else
                  obj.File_Status = 0;
                  msgbox('File not Compatible')
              end
               
           end
           
    
           function Add_Time_Point(obj, New_Point)
               if isdatetime(New_Point)
                   obj.Time_Points = addvars(obj.Time_Points, New_Point);
               end
           end
            
           function Add_Update_Function(obj, Function_Handle)
               if isempty(obj.Update_Functions) ==1
                    obj.Update_Functions =  { Function_Handle};
                    
               else
              obj.Update_Functions(end+1) =  { Function_Handle};
           
               end
           end
           
           function index =Update_Function_Idx(obj, Function_String)
               for idx = 1:length(obj.Update_Functions)
                
                   if strcmp(func2str(obj.Update_Functions{idx}),Function_String) ==1
                       index = idx;
                       break;
                   else 
                       index = 0;
                   end
                   
               end
           end
           
           function Delete_Update_Function(obj, Function_String)
               index = obj.Update_Function_Idx(Function_String);
               if index ~=0
                obj.Update_Functions(index) = [];
               
               else
                   disp('not found')
               end
           end
           
           
           function result =Search_Data(obj, Search_String)
               for idx = 1:length(obj.Instruments) 
                   result = 0; 
                   if strcmp(obj.Instruments, Search_String)
                    result = 1;
                   end   
               end   
           end
           
           
           function String_Sensor =Name_Sensor(obj,idx)
               if idx <= length(obj.Instruments) && idx > 0  
                   switch obj.Instruments(idx)
                       case 'Temperature_A'
                           String_Sensor =  'Temperature A';
                       case 'Temperature_C' 
                           String_Sensor =  'Temperature C';
                       case 'Log_Pressure' 
                           String_Sensor= 'Pressure Chamber';
                   end   
               end   
               
               
           end
           
               function DATA = Search_Label(obj,Label)
                 
                   switch Label
                       case 'Temperature A'
                           DATA =  obj.Data.Temperature_A;
                       case 'Temperature C' 
                           DATA  =  obj.Data.Temperature_C;
                       case 'Pressure Chamber' 
                           DATA = obj.Data.Log_Pressure;
                   end   
               
               
               
           end
           
           
    end
end

