function [mol] = H2cm32mol(H2Vol)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Density_H2_Room_Temperature =8.375E-5; %  in g/cm^3
Molar_Mass_H2 = 2.016;  % g/mol

  mol =(H2Vol*Density_H2_Room_Temperature)/Molar_Mass_H2;
end

