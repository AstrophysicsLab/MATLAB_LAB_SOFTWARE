function [Time, Pressure] = plottest()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
filename = 'C:\Users\admin\Documents\MATLAB\Analysis Logs\9-22-2018 HYDROGEN TEST\9-22-2018-trend.csv';
data = readtable(filename);
Time = datetime(data.Var1, 'InputFormat', 'MM-dd-yyyy HH:mm:ss.SSS');
Pressure = data.Var2;
end

