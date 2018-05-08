function simple_output = clean_net_output(output, threshold)

%   krumme Zahlen aus Netzoutput werden auf 0 f�r nicht Trigger oder 1 f�r
%   Trigger gesetzt --> treshold ist grenze hierf�r
%   (�ber threshold = 1, unter threshold = 0)

for i = 1 : length(output)
    
    divided_output = cell2mat(output(i));                   %   output kommt als cell -> transf zu double array
    
    for j = 1 : length (divided_output)                     %   Durchlauf des arrays
        
        if divided_output(j) < threshold                    %   falls Output kleiner threshold  -> 0 
            divided_output(j) = 0;                      
        else 
            divided_output(j) = 1;                          %   andernfalls                     -> 1
        end
    end
    
    simple_output(i) = num2cell(divided_output',[1 2]);     %   r�cktransformieren von array zu cell und speichern auf simple output (r�ckgabe)
    
end

end