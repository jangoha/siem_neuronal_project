clear all


InputNeuronen=50;
OutputNeuronen=50;
% trainShift = 600;

schrittweite = 0.001;
anzahlIterationen = 100;
momentumsFaktor = 0.005;

strc = [InputNeuronen,50,OutputNeuronen];

n = InputNeuronen;
laenge = (n*InputNeuronen+OutputNeuronen);

x = linspace(0,7,laenge);
func = @(x) sin(6*x)+2*(5*sinc(1*x-35)).^2    ;
y = func(x);

% y(500:610)=1;

tanhParameter = {3,0.55,0}; % {a,b} -> a*tanh(b*in)
% p=linspace(-4,4), a=tanhParameter{1}, b=tanhParameter{2},funcc=@(x) a*tanh(b*x), plot(p,funcc(p)), shg
gewichtsInitialBelegung = -0.1;


net = generate_tanh_feedforward(strc,[gewichtsInitialBelegung,-gewichtsInitialBelegung],'Bias','active','ActivFunParameter',tanhParameter);

[trainSamples,parts] = generate_train_samples(net,x,y,60,10);

tic
net=multiple_sample_train(net, trainSamples, schrittweite, momentumsFaktor, anzahlIterationen, 'instant Update');
trainingTime=toc
%%
figure(23)
subplot(2,1,1)
plot(x(1:trainSamples.Aids.lastSampleIndex),y(1:trainSamples.Aids.lastSampleIndex))
title('zum Training eingespeistes Signal')


subplot(2,1,2)
hold off
% plot([parts.x_values{:}],[parts.y_values{:}],'b')

x = linspace(0,7*10,laenge*10);
y = func(x);
% y(1500:1610)=1;
plot(y,'r');

subplot(2,1,2)
hold on
resultY(1:InputNeuronen)=0;
for(a=1:OutputNeuronen:(numel(x)-InputNeuronen)-1)
    resultY(a+InputNeuronen:a+OutputNeuronen-1+InputNeuronen) = test_net(net,y(a:a+InputNeuronen-1));
end
% plot(trainSamples.Samples)
plot(resultY,'x')
title('vorhergesagtes Signal und original Signal')






