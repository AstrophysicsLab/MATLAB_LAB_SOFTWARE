function [Volume] = airmol2cm3(airmol)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Density_air_Room_Temperature =1.201E-3; %  in g/cm^3
Molar_Mass_air = 28.96;  % g/mol


Volume = (airmol*Molar_Mass_air)/Density_air_Room_Temperature;

end




