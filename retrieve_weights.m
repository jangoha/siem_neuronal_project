function weights = retrieve_weights(net)
% Funktion wird benötigt im Training von FFN mit aktivierten Bais Knoten.
% Funktion kürzt die Gewichtsmatrizen um die jeweilige Spalte, welche die
% Biasinformationen enthält, da die Bias keine Fehler in das Netz
% rückpropagieren.


if strcmp(net.Bias,'inactive') == 1
    
    weights = net.Weights;
    
elseif strcmp(net.Bias,'active') == 1
    
    weights = cell(1,net.nLayers-1);
    
    for k=1:net.nLayers-1
        weights{k} = net.Weights{k}(:,1:end-1); %Biaswerte werden als Gewichte in der letzten Spalte gespeichert und hier abgeschnitten
    end
end