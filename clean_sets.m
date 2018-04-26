
function sets = clean_sets(sets,method,scale,varargin)

n=length(sets);




switch method
    case 'normal'
        for j=1:n
   
            y = sets(j).y_values;
    
            y = y-mean(y);
            y = (y./(max(abs(y))))*scale; % Normierung der Signalwerte
          
            
            sets(j).y_values = y;
                
    
        end
        
    case 'gaussian'
        
        for j=1:n
            
            sets(j).y_values= gaussian_normalization(sets(j).y_values);
            
        end
end