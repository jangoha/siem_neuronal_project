
function [new_net, varargout] = backpropagation(net,input,trainmaterial,alpha, beta, nIteration)
input = input(:);
% Trainingsalgorithmus für Feedforward-Systeme mit mehreren oder auch
% keinen innerem Schichten. Berechnung folgt den Formeln aus :(Dokument ebenfalls im Ordner abgelegt): https://www.pdx.edu/sites/www.pdx.edu.sysc/files/Jaeger_TrainingRNNsTutorial.2005.pdf
% Input, Trainingmaterial müssen als Spaltenvektroen übergeben.
% alpha,beta ist ein Skalar zur Regelung der Schrittweiten in der Minimasuche.

% Aufsammeln der Vorherigen Änderungen der Gewichte für Momentumterm in der
% Korrektur (beta). Wobei die Änderungen eines Iterationschrittes in einer
% Spalte des Arrays gespeichert werden.

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

        delta_weights       = cell(net.nLayers-1,nIteration); 
        delta_weights(:,1)  = num2cell(zeros(net.nLayers-1,1)); 

        for p=1:nIteration

            % Berechnung der Fehler jeder Schicht bis auf Inputschicht

            errors      = compute_error(net,input,trainmaterial,funcActivation,funcActivation_derivative);


            dim          = size(net.Weights);
            weights      = cell(dim);

            
            for(kActiv = 1:dim(2))
                activArray{kActiv} =activation(net,kActiv,input,funcActivation);
            end

            for k=dim(2):-1:1 % Schleife zur Berechnugn der neuen Gewichte in der k-ten Gewichtsmatrix
                activ   = activArray{k};
                

                % Verändere neue Gewichtsmatrizen nach Gradientenabstieg und Momentumterm
                delta_weights{k,p+1} = -alpha*errors{k}(:)*activ(:)' + beta*delta_weights{k,p};
        
                weights{k} = net.Weights{k}+ delta_weights{k,p+1};
        
            end

        varargout{1} = delta_weights;
        
        net.Weights = weights;
        new_net     = net;
        end
 end
        
        
        
        
        
        