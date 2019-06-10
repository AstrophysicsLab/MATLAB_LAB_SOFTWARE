function [OutTable] = mtable( varargin )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
namearray =[];
OutTable = table(varargin{:});
for K = 1 : nargin
    fprintf('input #%d came from variable "%s"\n', K, inputname(K) );
    namearray{end+1} = inputname(K)

end

OutTable.Properties.VariableNames = namearray;
end

