function  Add_Paths()

Fullpath = mfilename('fullpath');  % Returns the fullpath to this function
[filepath,name,ext] = fileparts(Fullpath)  % Returns path alone
addpath(genpath(filepath))         % Adds all subdirectories


end

