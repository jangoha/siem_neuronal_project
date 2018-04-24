function [net, varargout] = train(net,input, trainmaterial, learningparameter, beta, nIterations)


% Trainingsfunktion die mit gewünschter Traingsmethode das gewählte Netz trainiert.
% learningparameter entspricht der Lernrate in der BB. beta bestimmt den
% Momentumsfaktor in der BB

input=input(:); % forme INput und Trainimatrail in Spaltenvektoren um
trainmaterial = trainmaterial(:);


switch net.Trainingmethod
    case 'Backpropagation'
        
        [net, delta_weights]= backpropagation(net,input,trainmaterial,learningparameter, beta, nIterations);
        net.TrainingStatus   = 'trained';
        varargout{1} = delta_weights;
        
    
end