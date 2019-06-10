function [ Serial_Obj ] = VQM_Serial_Create( )
%VQM_Serial Creates serial object for VQM controller.
%   

%Serial_Obj = serial('COM4');  % Creates theserial object on comport 4
%deskmachine
Serial_Obj = serial('COM7');
Serial_Obj.Terminator = 'CR';    % Set the terminator to carriage return
Serial_Obj.InputBufferSize = 1024; % Increases the input buffer size


end

