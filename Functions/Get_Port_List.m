function [Availible_Ports] = Get_Port_List()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 verbose =1;
% ttyList={};
% portlist_number =[];

if ispc
    
    % Get COM port info with system (Windows) mode command 
    if verbose >= 3
        [stat, result] = system('mode', '-echo');
    else
        [stat, result] = system('mode');
    end
    if stat ~= 0
        fprintf(1,'get_port_list: Unable to get device list (error %d)\n',stat);
        return
    end
    
%     % identify the COM ports in the output string and format in cell array
     Portlist = regexp(result,'COM\d+:','match');
%     k=0;
%     for p = PortList
%         k=k+1;
%         portNum = regexp(p{1},'\d+','match');
%         portName = regexp(p{1},'COM\d+','match');
%         ttyList = [ttyList; {portNum{1}, portName{1}}];
%         if verbose >= 2, fprintf(1,'  Serial Device at %s\n',ttyList{k,2}); end
%         portOrder = [portOrder str2num(portNum{1})];
%     end
%     % return the list sorted with largest number first
%     [p2,i]=sort(portOrder,2,'descend');
%     ttyList = ttyList(i,:);
    
end
Availible_Ports = string(Portlist);
Availible_Ports = erase(Availible_Ports, ':');

end

