type = '../*.csv';
[name, path] = uigetfile(type);
filename = strcat(path,name);
data = readtable(filename);
Time = datetime(data.Var1, 'InputFormat', 'MM-dd-yyyy HH:mm:ss.SSS');
Pressure = data.Var2;
clear data;
subplot(2,1,1);
plot(Time, Pressure);
grid on
subplot(2,1,2);
semilogy(Time, Pressure);
grid on