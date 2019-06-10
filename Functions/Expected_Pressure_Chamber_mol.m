function [Pressure, Pressure_low, Pressure_high] = Expected_Pressure_Chamber_mol(mols, initial_pressure)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
R = 62.3636;
T= 300;
V = 17.7;
V_low = 17.5;
V_high = 17.9;
mols = 0:mols/1000:mols;
Pressure = initial_pressure + (mols*R*T)./V;
Pressure_V_low = initial_pressure + (mols*R*T)./V_low;
Pressure_V_high = initial_pressure +(mols*R*T)./V_high;

plot(mols, Pressure,'-g');
grid on;
hold on;
plot(mols, Pressure_V_low,'-b');
hold on;
plot(mols, Pressure_V_high,'-r');
title('Expected Pressure Increase');
xlabel('Mol');
ylabel('Pressure');
legend('V = 17.7 l','V = 17.5 l','V = 17.9 l', 'Location' , 'northwest');
Pressure = Pressure(end);
Pressure_low = Pressure_V_low(end);
Pressure_high = Pressure_V_high(end);

end

