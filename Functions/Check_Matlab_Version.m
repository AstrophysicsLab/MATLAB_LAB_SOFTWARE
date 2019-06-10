function [Release] = Check_Matlab_Version()
%Check Matlab Version
%   Checks which version of Matlab is running in order
%   to select which functions to use.

Version = version('-release');   % Returns Matlab release format yyyy(ab)
Version = Version(1:4);          % Truncates to year only
Release = str2double(Version);      % String to number
end

