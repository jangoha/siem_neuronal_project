function net = generate_tanh_feedforward(Structure,range,varargin)

% Generiert ein Feedforward-Netz welches eine tanh-Funktion als Standard-Aktivierungsfunktion in den Neuronen besitzt.
% Die Structure wird als Matrix eingegeben.
% Bsp. [4,8,2] entspricht 4 Inputneuronen 8 Hiddenneuronen und 2 Outputneuronen.
% 
% Die Gewichte zwischen den einzelnen Schichten werden zufällig in "range" (bspw. [-1,1]) gewählt, wobei für den Output keine Gewichtung mehr vorgenommen wird.


if all(Structure) == 0

    error('Choosen Networkstructure not permitted.');
    
    
else
    
    args  = varargin;
    nargs = length(varargin);
    
    
    
    net.Structure           = Structure;
    dim                     = size(Structure);
    net.nLayers             = dim(2);
    net.nHiddenLayers       = dim(2)-2;
    net.nInputUnits         = Structure(1);
    net.nHiddenUnits        = sum(Structure(2:end-1));
    net.nOutputUnits        = Structure(end);
    
    net.Weights             = generate_net_weights(net,range);  % generiert Gewichtsmatrizen in den internen Schichten
%     net.Weights             = {net.Weights{:},generate_OutputWeights(net,'identity')};  
    
    net.NetworkType         = 'Feedforward Network';
    net.Activationfun       = 'tanh'; % Optionen: 'tanh' , 'linear' , 'logistic'
    
    
%   b stellt hier die Breite des quasi linearen Bereiches der tanh-Funktion ein. Gleichzeitig wird der
%   erste Parameter in Abhängigkeit von b so gewählt, dass das Maximum der
%   Ableitung kleiner 1 ist, damit des Verfahren konvergiert. b = 0.4 lässt
%   Werte zw. ca. -6,6 für tanh zu, was den Werte Bereich mit
%   Normalisierung entspricht
    b= 0.4;
    net.ActivFunParameter   = {0.99/b,b,0};
%   Für das plotten der tanh-Funktion und Ableitung : b=0.4;a=0.99/b;x=linspace(-8,8,200);figure(44),plot(x,a*tanh(b*x),x,a*b*(1-tanh(b*x).^2))
    
    
    net.Uebertragungsfun    = 'summe';  % Definiert wie die eingehenden Signale eines Neurons gebündelt werden. Wird durch Matrixmultiplikation realisiert.
    net.Bias                = 'inactive';
  
    net.TrainingStatus      = 'untrained';
    net.Trainingmethod      = 'Backpropagation'; % Vorgegebene Trainingsmethode
    
    for o=1:2:nargs
        
        switch args{o}
            case 'Bias'
                if strcmp(args{o+1},'active') == 1
                    
                    net.Bias    = 'active';
                   
                    net.Weights = generate_bias_weights(net,range);
                    
                elseif strcmp(args{o+1},'inactive') == 1
                    
                else
                    error('Invalid Bias-Configuration')
                end
                
            case 'ActivFunParameter'
                
                net.ActivFunParameter = args{o+1};
                
                
        end
   
    end
      net.BiasBoolean = strcmp(net.Bias,'active');
end