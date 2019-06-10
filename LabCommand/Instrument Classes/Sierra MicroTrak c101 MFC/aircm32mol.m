function mol = aircm32mol(air_vol)
%H2cm32mol  Molecular Hydrogen volume to mol
%   Function uses the densisty of H2 at 294K (70F)
Density_air_Room_Temperature =1.201E-3; %  in g/cm^3
Molar_Mass_air = 28.96;  % g/mol


mol = ((air_vol*Density_air_Room_Temperature) / Molar_Mass_air);
%disp('inside air to mol function  the air_vol is  ')
%disp(air_vol)
end


