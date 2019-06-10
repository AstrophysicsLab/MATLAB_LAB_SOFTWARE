function [Volume] = H2mol2cm3(H2mol)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Density_H2_Room_Temperature =8.375E-5; %  in g/cm^3
Molar_Mass_H2 = 2.016;  % g/mol


Volume = (H2mol*Molar_Mass_H2)/Density_H2_Room_Temperature;

end

