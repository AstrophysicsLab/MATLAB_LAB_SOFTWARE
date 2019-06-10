function [mol] = H2cm32mol(H2vol)
%H2cm32mol  Molecular Hydrogen volume to mol
%   Function uses the densisty of H2 at 294K(70F) 
Density_H2_Room_Temperature =8.351E-5; %  in g/cm^3
Molar_Mass_H2 = 2.016;  % g/mol


mol = ((H2vol*Density_H2_Room_Temperature) / Molar_Mass_H2);

end

