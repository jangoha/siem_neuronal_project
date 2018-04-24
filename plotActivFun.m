function plotActivFun(net,xRange)


[a,b,c] = net.ActivFunParameter{:};
switch net.Activationfun
    
    case 'tanh'
        funcActivation = @(x) a*tanh(b*x)+c;
        funcActivation_derivative = @(x) a*b*(1-tanh(b*x).^2);
        
    case 'linear'
        funcActivation =@(x) a*b*x+c;
        funcActivation_derivative =@(x) a*b*x;
        
    case 'logistic'
        funcActivation =@(x) 1./(1+exp(a*x+b))+c;
        funcActivation_derivative =@(x) (1./(1+exp(a*x+b))+c).*(-1+(1./(1+exp(a*x+b))+c))*a;
end

x = linspace(xRange(1),xRange(2),300);
y = funcActivation(x);
z = funcActivation_derivative(x);

figure(123123123)
plot(x,y,x,z)
legend('Aktivierungsfunktion','Ableitung der Aktivierungsfunkion')
title(['Aktivfunk.: ',func2str(funcActivation),' / Ableitung: ',func2str(funcActivation_derivative),' / Parameter [a,b,c]=[',num2str([a,b,c]),']'])

