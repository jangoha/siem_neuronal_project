clear all


InputNeuronen=50;
OutputNeuronen=10;

strc = [InputNeuronen,50,OutputNeuronen];

train_width  = 0.1;
shift_step_length = 10;

schrittweite = 0.001;
anzahlIterationen = 100;
momentumsFaktor = 0.005;

n = 10;
laenge = n*InputNeuronen+OutputNeuronen;

x = linspace(0,10,laenge);
func = @(x) sin(3*x).^2;
y = func(x);

calc_samples = cell(1,laenge-OutputNeuronen);
for j=1:laenge-OutputNeuronen
    para = j-1;
    calc_samples{j} = y(para*shift_step_length+1:para*shift_step_length+shift_step_length);
end
