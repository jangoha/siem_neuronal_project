function sets = clean_sets(sets,method,scale,varargin)


switch method
    case 'normal'
        for j = 1 : length(sets)
   
%             y = sets(j).y_values;
            sets(j).y_values = sets(j).y_values - mean(sets(j).y_values);
%             y = y - mean(y);
             sets(j).y_values = ( sets(j).y_values / ( max( abs( sets(j).y_values ) ) ) )% * scale; % Normierung der Signalwerte
          
            
%             sets(j).y_values = y;
                
    
        end
   
        
    case 'gaussian'
        
        for j = 1 : length(sets)
            
            sets(j).y_values= gaussian_normalization(sets(j).y_values);
            
        end
end