%dat = readtable('Default_Comports.dat');
dat = table;
dat{1}
dat{2,:} = {0};
dat{3,:} = {0};
dat.Properties.RowNames = {'Comport', 'Function handle','Active'};
inst = dat.Properties.VariableNames{2};
for idx = 1: length_table
    if strcmp(inst,dat.Properties.VariableNames{idx}) ==1
       dat('Function handle',idx) = {@A_Plot};
       dat('Active',idx) = {num2cell(1)};
      % feval(cell2mat(dat{'Function handle',idx}));
       fun = cell2mat(dat{'Function handle',idx});
       fun();
    end
    
end


% feval(cell2mat(dat{'Function handle',1}))
% dat.Lakeshore{'Function handle'}()
% dat.Lakeshore{3}()