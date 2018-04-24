function test_samples = generate_test_samples(net, x_values,y_values)
% Erzeugt TestSamples aus den übergebenen x und y-Werten, die auf die Struktur des Netzes angepasst sind. 

shift = net.nOutputUnits;
test_samples = dismantle_signal(net, x_values,y_values,'samples','all',shift); % Zerlege Signal
test_samples.original_x_values = x_values; % Speichere original Werte ebenfalss in Strutur, da diese manchmal zum plotten etc. benötigt werden
test_samples.original_y_values = y_values;

