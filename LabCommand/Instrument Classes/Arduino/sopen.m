s = serial('COM13');
fopen(s);
pause(2);
query(s,'t');
pause(2);
a =query(s,'t');
a = a(1:5);
a = str2double(a);
Temperature = a;
for i = 1:7200
a = query(s,'t');
a = a(1:5);
a = str2double(a)
Temperature = [Temperature, a];
pause(1);
end

plot(Temperature)

fclose(s);
delete(s);
clear s