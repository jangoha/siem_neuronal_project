function net = set_activationfun(net)

a = net.ActivFunParameter{1};
b = net.ActivFunParameter{2};
c = net.ActivFunParameter{3};

switch net.Activationfun
    
    case 'tanh'
        funcActivation = @(x) a*tanh(b*x)+c;
        funcActivation_derivative = @(x) a*b*(1-tanh(b*x).^2);
        
    case 'linear'
        funcActivation =@(x) a*x+c;
        funcActivation_derivative =@(x) a*x;
        
    case 'logistic'
        funcActivation =@(x) 1./(1+exp(a*x+b))+c;
        funcActivation_derivative =@(x) (1./(1+exp(a*x+b))+c).*(-1+(1./(1+exp(a*x+b))+c))*a;
end

net.funcActivation = funcActivation;
net.funcActivation_derivative = funcActivation_derivative;

end