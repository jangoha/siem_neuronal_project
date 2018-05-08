function [err_weights, varargout]= compute_error(net,input,trainmaterial)

% Berechnet Fehlerparameter der einzelnen Neuronen in jeder Schicht nach dem Formalismus der Backpropagation.
% Siehe Formeln(Dokument ebenfalls im Ordner abgelegt): - https://www.pdx.edu/sites/www.pdx.edu.sysc/files/Jaeger_TrainingRNNsTutorial.2005.pdf
                                                    %   -backpropagation.pdf

% Input unhd trainingmaterail muss als Spaltenvektor (mx1) eingegeben werden
   
% Initialisiere mehrere Variabeln die zur Berechnugn benötigt werden.   
          inter_states   = cell(1,net.nLayers);
          derivatives    = cell(1,net.nLayers);
          comp_weights   = retrieve_weights(net); % Zur Berechung der Veränderungen werden nur die Gewcihtsmatrizen ohne Biaswerte benötigt, da die Bias-fehler nciht weiter zurückpropagieren.
          
          output         = test_net(net,input);
          
          err_weights    = cell(1,net.nLayers-1);
          
%           Sammle einmal alle Ableitungen und internalStates, damit diese
%           nciht immer wieder neu von der ersten Schicht her berechnet
%           werden müssen
          for k=1:net.nLayers
              
             inter_states{k} = internal_state(net,k,input);
             derivatives{k}   = diag(net.funcActivation_derivative(inter_states{k})); %setze Ableitungen auf Diagonale
              
          end
          
%  Gebe Ableitung in den Output
          varargout{1}  = derivatives;
          
          
          
%  Berechne Outputfehler, hier bei ist das Vorzeichen in der Klammer zu
%  beachten. Bei einem Wechsel der Variablen output und trainmaterail,
%  muss das VZ vor alpha in backpropagation ebenfalls gedreht werden

          fst_err = derivatives{end}*(output-trainmaterial);
          
          if net.nHiddenLayers == 0
              
              err_weights = {fst_err};
              
              
%  Propagiere Fehler rückwärts durch das Netz
          elseif  net.nHiddenLayers >= 1
              
              
              err_weights{end} = fst_err; 
              
              for m=net.nLayers-2:-1:1 %hier net.nLayers-2, da Fehler nciht in der Inputschicht berechnet werden müssen und der Outputfehler schon gesetzt ist.
                  
                  err_weights{m} = derivatives{m+1}*comp_weights{m+1}'*err_weights{m+1}; %geweichtsmatrix muss an dieser Stelle für das zurückpropagieren des Fehlers transponiert werden.
              
              end
                  
        
        
%         output_activation   = activation(net,net.nLayers,input);
%         inter               = internal_state(net,net.nLayers,input);
%         outputerr           = (trainmaterial-output_activation).*(1-tanh(inter).^2); % Fehler an der Outputschicht
%         err_weights         = cell(1,net.nLayers);
%         err_weights{end}    = outputerr;
%         
%         
%         if net.nHiddenLayers == 0
%             
%             err_weights = err_weights;
%              
%         elseif net.nHiddenLayers >= 1
%             
%             for m = net.nLayers-1:-1:2
%                 delta            = err_weights{m+1}; % Fehler der Neuronen aus der folgenden (m+1)-ten Schicht als Spaltenvektor
%                 weights          = net.Weights{m};
%                 derivative       = (1-tanh(internal_state(net,m,input)).^2); % Ableitungen für die Neuronen in der m-ten Schicht
%                 calc   = repmat(delta,1,size(weights,2)).*(weights(:,:).*repmat(derivative',size(weights,1),1));
%                 err_weights{m}  = sum(calc(:,:),1)';            
                
                
                    
%                     derv_j  = derivative(j,:);
                    
                    
%                     for i=1:net.Structure(m+1)
%                         calc(i)    = delta(i)*weights(i,j).*derv_j;
%                         
%                         calc   = delta(:).*(weights(:,j)*derivative(j));
%                     end

    
%                 for j=1:net.Structure(m)
%                     err_m_j(j,:) = sum(calc(:,j));
%                     err_m_j = ;
%                     calc         = [];
                    
%                 end
                
%                 err_m_j =[];
            
            
        else
            error('Something is wrong...');
        end

end
            