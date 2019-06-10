function Output_Data = Data_Slope(Input_Data, Window_Size)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
Output_Data = zeros(length(Input_Data),1);
if mod(Window_Size,2) ~=0
   Window_Size = floor(Window_Size)+1; 
end
for idx = 1: length(Input_Data)
   if idx >Window_Size/2 && idx< length(Input_Data)-Window_Size/2
      % disp('true')
       Output_Data(idx) =(Input_Data(idx+Window_Size/2)- Input_Data(idx-Window_Size/2))/Window_Size;
        
    elseif idx > length(Input_Data)- (Window_Size/2 +1) 
        Output_Data(idx) = (  Input_Data(idx) - Input_Data(idx-Window_Size))/Window_Size;
    elseif idx < Window_Size/2 +1 
         Output_Data(idx) = (Input_Data(idx+Window_Size) - Input_Data(idx))/Window_Size;
   
   end
end



end

