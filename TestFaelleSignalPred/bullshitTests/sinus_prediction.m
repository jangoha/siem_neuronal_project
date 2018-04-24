clear all


InputNeuronen=50;
OutputNeuronen=50;
trainShift = 500;
trainShiftStep = 10;
schrittweite = 0.001;
anzahlIterationen = 50;
momentumsFaktor = 0.05;

strc = [InputNeuronen,50,OutputNeuronen];

n = InputNeuronen;
laenge = n*InputNeuronen+OutputNeuronen;

x = linspace(0,7,laenge);
func = @(x) (sin(5*x))/2;cos(8*x);
y = func(x);

in = y(1:InputNeuronen+trainShift)';
t = y(InputNeuronen+1:InputNeuronen+OutputNeuronen+trainShift)';


tests = cell(1,n-1);
comps = tests;
x_values = tests;

for j=1:n-1
    tests{j} = y(j*n+1:j*n+n)';
    comps{j} = y(j*n+n+1:j*n+n+OutputNeuronen)';
    x_values{j} = x(j*n+n+1:j*n+n+OutputNeuronen);
end



tanhParameter = {3,0.55,0}; % {a,b} -> a*tanh(b*in)
% p=linspace(-4,4), a=tanhParameter{1}, b=tanhParameter{2},funcc=@(x) a*tanh(b*x), plot(p,funcc(p)), shg
gewichtsInitialBelegung = -0.1;





net = generate_tanh_feedforward(strc,[gewichtsInitialBelegung,-gewichtsInitialBelegung],'Bias','inactive','ActivFunParameter',tanhParameter);


tic

for(zaehler=1:trainShiftStep:trainShift)
    
    net = train(net,in(zaehler:end-trainShift+zaehler-1), t(zaehler:end-trainShift+zaehler-1), schrittweite,momentumsFaktor, anzahlIterationen);
    
end

toc

% g = give_all(net,in);
inCut = in(1:InputNeuronen);
tCut = t(1:InputNeuronen);
output = test_net(net,inCut);
% diff = output-tCut


outs_n_diffs= cell(2,n-1);
for j=1:n-1
    outs_n_diffs{1,j} = test_net(net,tests{j});
    outs_n_diffs{2,j} = outs_n_diffs{1,j}-comps{j};
end

figure(4)
subplot(2,1,1)
hold off
plot(x,y);
hold on
% plot(x(InputNeuronen+1:InputNeuronen+OutputNeuronen),tCut','x',x(InputNeuronen+1:InputNeuronen+OutputNeuronen),output','o');
plot(x(InputNeuronen+1:InputNeuronen+OutputNeuronen),output','o');
title('Trainiertes Netz O Vorhersagen')
for j=1:n-1
    plot(x_values{j},outs_n_diffs{1,j}','o');
end

subplot(2,1,2)
plot(in);
