function [value_activation, varargout] = activation(net,nLayer,input,func)
% Berechnet die Aktivierung(Outputsignal) eines jeden Neurons in der
% gewählten Schicht.



input=input(:);


%        [calc1,meann , stdd] = internal_state(net,nLayer,input,func);

%        varargout = {meann,stdd};
        calc1 = internal_state(net,nLayer,input,func);   
       

% Ohne ReNormalisierung
       value_activation = func(calc1);
       
%  Mit ReNormalisierung
%        calc2 = func(calc1);     
%        value_activation = reverse_gaussian_normalization(calc2,meann,stdd);
      
      if strcmp(net.Bias,'inactive') == 1
          

        
      elseif strcmp(net.Bias,'active') == 1
          
            value_activation = [value_activation;1];

        
      end
        

        
