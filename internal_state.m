function [state,varargout] = internal_state(net,nLayer,input)

% Berechnet den internen Neuronenstatus in der gewählten Schicht bevor Aktivierungsfunktion auf diese Werte angewandt wird.


input = input(:); 

if nLayer == 1
    
% Mit Normrmalisierung
%         [state,meann,stdd] = gaussian_normalization(input);
        state = gaussian_normalization(input);


% Ohne Normalisierung
%           state = input;
        
        
elseif nLayer>1
    
%  Mit Normalisierung
                activ = activation(net,nLayer-1,input);
                calc = net.Weights{nLayer-1}*activ;
%                 [state,meann,stdd] = gaussian_normalization(calc);
                state = gaussian_normalization(calc);



% Ohne Normalisierung
%                   activ = activation(net,nLayer-1,input,func);
%                   state = net.Weights{nLayer-1}*activ;

                


end


% meann = 1;
% stdd = 1;

% varargout = {meann,stdd};