function values = mittelung(x,y,mittellaenge)
% Mittelt jeweils 'mittellaenge' Werte aus den daten zusammen zu einem und
% setzt diesen neuen Wert in die Mitte des Intervalls. Daher muss das Intervall
% eine ungerade Anzahl an Werten enthalten

% teste auf gerade/ungerade
if mod(mittellaenge,2) ==1 
   
    
    mitte = (mittellaenge + 1)/2;
    
    new_length = floor(length(y)/mittellaenge);
    
    
    values.y_values = zeros(1,new_length);
    values.x_values = zeros(1,new_length);
    
    param = 0;
    
    for k=1:new_length
        
%         para1 = k-1;                    %Parameter zum verschieben der Mittelung in Abständen von Mittellänge
        param = ( k - 1 ) * mittellaenge;
        values.y_values( k ) = mean( y ( 1 + param : param + mittellaenge ) );
        values.x_values( k ) = x( param + mitte );
        
    end
    values.last_index = param + mittellaenge;
    
else
    error('Mittellänge ist gerade Zahl. Es kann daher keine Intervallmitte gefunden werden')
end

