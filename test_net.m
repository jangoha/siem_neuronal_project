function [out,varargout] = test_net(net,in,func)

% propagiert den gewählten Input durch das FeedForward-Netz


% Parameter der Aktiviewrungsfunktion
a = net.ActivFunParameter{1};
b = net.ActivFunParameter{2};
c = net.ActivFunParameter{3};

% setze hier die Aktivierungsfunktionen und übergebe diese weiter an
% "activation" zur beschleunigung der Berechnung
switch net.Activationfun
    
    case 'tanh'
        func = @(x) a*tanh(b*x)+c;
    case 'linear'
        func =@(x) a*x+c;
    case 'logistic'
        func =@(x) 1./(1+exp(a*x+b))+c;
end

in = in(:); %Formatiere INput zu Spaltenvektor 

out = activation(net,net.nLayers,in,func);
% out = reverse_gaussian_normalization(calc,meann,stdd);

if strcmp(net.Bias,'active') == 1
             
   out = out(1:end-1);
             
end

varargout{1} = net;
