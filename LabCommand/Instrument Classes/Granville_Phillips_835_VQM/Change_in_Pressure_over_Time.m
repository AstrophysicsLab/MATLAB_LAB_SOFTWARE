function [ DPdt ] = Change_in_Pressure_over_Time( Data)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
        
    Time_Interval   = Data.Time_Now - Data.Time_Last;
    Pressure_Change = Data.Pressure_Now - Pressure_Last;
    
    DPdt = Pressure_Change/ Time_Interval;
end

