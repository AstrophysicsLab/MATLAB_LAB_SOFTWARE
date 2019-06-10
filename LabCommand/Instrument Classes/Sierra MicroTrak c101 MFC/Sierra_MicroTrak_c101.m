classdef Sierra_MicroTrak_c101 < handle
    % Sierra_MicroTrak_c101 Mass flow Control
    % Controller class for Sierra Microtrak c101 Mass flow controller
    % Contains functions for serial comunication, flow and pulse control , and
    % logging data. To be used in conjuntion with CRC_Generator function.
    
    properties
        
        
        Gas_Number;
        Gas_String;
        Units_Number;
        Units_String;
        Valve_State_Number;
        Valve_State_String;
        Flowrate;
        Setpoint;
        Volume_Transfered;
        Mol_Transfered;
        Volume_Remaining;
        Mol_Remaining;
        Volume_Transfer_Amount;
        Mol_Transfer_Amount;
        Volume_of_Target;
        Current_Pressure;
        Initial_Pressure;
        Estimated_Final_Pressure
     
        Pulse_Volume;
       
        Flowrate_Log;
        Setpoint_Log;
        Epoch_Time;
        Epoch_Time_Log;
        
        Serial_Object;
        Comport;
    end
    
    methods
        
        function Update_Data(obj)
           obj.Read_Gas();
           obj.Read_Units();
           obj.Read_Setpoint();
           obj.Read_Flow();
           obj.Calculate_Volume_Tranfered();

           obj.Read_Valve_State();
    
        end
        
        
        function  Read_Flow(obj)
           Cmd = [63, 70, 108, 111, 119, 202, 112];
           Response = query(obj.Serial_Object, char(Cmd));
           Response = Response(1:length(Response)- 3);
           obj.Flowrate = str2double(Response(5:end));
           obj.Flowrate_Log{end+1} = obj.Flowrate;
           obj.Epoch_Time = now*24*60*60;
           obj.Epoch_Time_Log{end+1} = obj.Epoch_Time;
           
        end
       
        function Specify_Micro_Mol(obj)
            switch obj.Gas_Number
                case 1    
                     obj.Volume_Transfer_Amount = airmol2cm3(obj.Mol_Transfer_Amount);
                     %obj.Mol_Transfer_Amount = umols*1E-6;
                case 6
                     obj.Volume_Transfer_Amount = H2mol2cm3(obj.Mol_Transfer_Amount);
                     %obj.Mol_Transfer_Amount = umols*1E-6;
            
            end
        end
        
        function Serial_Create(obj)   
           obj.Serial_Object = serial(obj.Comport); 
           obj.Serial_Object.Terminator ='CR';
           obj.Serial_Object.ReadAsyncMode = 'manual';
           fopen(obj.Serial_Object);
        end
        
         function Sierra_MFC_Serial_Destroy(obj)
           
                fclose(obj.Serial_Object);
        
           
        
         end
        function Sierra_MFC_Set_Comport(obj, Comport)
                obj.Comport = Comport;
            
        end
        function Calculate_Volume_Tranfered(obj)
            if sum(cell2mat(obj. Flowrate_Log)) > 0 
               
                obj.Volume_Transfered = trapz(cell2mat(obj.Epoch_Time_Log), cell2mat(obj. Flowrate_Log));
            else
                obj.Volume_Transfered = 0;
            end  
            
            switch obj.Gas_Number
                
                case 1
                  
                    disp(obj.Volume_Transfered)
                    obj.Mol_Transfered = aircm32mol(obj.Volume_Transfered);                    
                    obj.Mol_Remaining = obj.Mol_Transfer_Amount - obj.Mol_Transfered;                    
                    obj.Volume_Remaining = airmol2cm3(obj.Mol_Remaining);
                                                           
                case 6
                    obj.Mol_Transfered = H2cm32mol(obj.Volume_Transfered);
                    obj.Mol_Remaining = obj.Mol_Transfer_Amount - obj.Mol_Transfered;
                    obj.Volume_Remaining = H2cm32mol(obj.Mol_Remaining);
            end
        end
        
%         function Pulse_Control(obj)
%         
%         
%         end
        
function Set_Setpoint(obj, Value)
    Cmd = ['!Setf',num2str(Value)];            
    Cmd = CRC_Generator(Cmd);
    query(obj.Serial_Object,char(Cmd));
    obj.Read_Setpoint();
end

function Read_Setpoint(obj)
    Cmd = CRC_Generator('?Setf');
    Set_point = query(obj.Serial_Object, char(Cmd));
    Set_point = Set_point(5:end-3);
    obj.Setpoint = str2double(Set_point);
end
function Set_Units(obj, New_Units)
    if New_Units > 0 && New_Units < 10
        Cmd = ['!Unti',  num2str(New_Units)];
        Cmd = CRC_Generator(Cmd);
        query(obj.Serial_Object,char(Cmd));
        obj.Read_Units();
    end
end

function Read_Units(obj)
    Cmd = [63,    85,   110,   116,   105,     8,    29];  
    Units = query(obj.Serial_Object,char(Cmd));
    Units = Units(1:end-3);
    switch Units
        case 'Unti1'
            obj.Units_Number =1;
            obj.Units_String = 'scc/s';
        case 'Unti5'
            obj.Units_Number =2;
            obj.Units_String = 'scc/m';
        case 'Unti6'
            obj.Units_Number =4;
            obj.Units_String = 'Ncc/s';
    end
end

function Set_Gas(obj, New_Gas)

    if New_Gas > 0 && New_Gas < 10
        Cmd = ['!Gasi',  num2str(New_Gas)];
        Cmd = CRC_Generator(Cmd);
        query(obj.Serial_Object,char(Cmd))
        obj.Read_Gas();
    end
end

function Read_Gas(obj)
    Cmd = '?Gasi';
    Cmd = CRC_Generator(Cmd);
    Gas = query(obj.Serial_Object,char(Cmd));
    Gas = Gas(1:end-3);
    switch Gas
        case 'Gasi1'
            obj.Gas_Number =1;
            obj.Gas_String = 'Air';
        case 'Gasi5'
            obj.Gas_Number =5;
            obj.Gas_String = 'Helium';
        case 'Gasi6'
            obj.Gas_Number =6;
            obj.Gas_String = 'Hydrogen';
    end
    
end



function Set_Valve(obj, New_Valve_State)
    if New_Valve_State > 0 &&  New_Valve_State < 4
        Cmd = ['!Vlvi',  num2str(New_Valve_State)];
        Cmd = CRC_Generator(Cmd);
        query(obj.Serial_Object,char(Cmd));
        obj.Read_Valve_State();
        
    end
end

function Read_Valve_State(obj)
    Cmd = '?Vlvi';
    Cmd = CRC_Generator(Cmd);
    Valve_State = query(obj.Serial_Object,char(Cmd));
    Valve_State = Valve_State(1:end-3);
    switch Valve_State
        case 'Vlvi1'
            obj.Valve_State_Number =1;
            obj.Valve_State_String = 'Automatic';
        case 'Vlvi2'
            obj.Valve_State_Number =2;
            obj.Valve_State_String = 'Closed';
        case 'Vlvi3'
            obj.Valve_State_Number =3;
            obj.Valve_State_String = 'Purge';
    end
    
end

function Set_Stream(obj, State)
    Cmd = '!Strm';
    switch State
       
        case 'On'
            Cmd = [Cmd,'On' ];
            Cmd = CRC_Generator(Cmd);
            query(obj.Serial_Object, char(Cmd));
        case 'Off'
            Cmd = [Cmd,'Off' ];
            Cmd = CRC_Generator(Cmd);
            query(obj.Serial_Object, char(Cmd));
        case 'Echo'
            Cmd = [Cmd,'Echo' ];
            Cmd = CRC_Generator(Cmd);
            query(obj.Serial_Object, char(Cmd));
    end
end
    function Get_Stream(obj)
        Cmd = CRC_Gernerator('?Strm');
       query(obj.Serial_Object, char(Cmd)); 
    end
    


function Sync(obj)
   Cmd = CRC_Generator('?Sync');
   fprintf(obj.Serial_Object, Cmd);
   for idx = 1:26
      fscanf(obj.Serial_Object) 
   end
    
end


        
        
    end
end

