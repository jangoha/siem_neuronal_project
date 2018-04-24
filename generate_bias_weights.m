function weights = generate_bias_weights(net,range)

% Erzeugt Gewichtsmatrizen mit einem zuästzlichen Bias-Neuron in jeder
% Schicht, bis auf der Outputschicht. Die Biaswerte der einzelnen Neuronen
% werden dabei in der letzten Spalte der Matrizen gespeichert.

% Erweiterung um Bias-Neuron in jeder Schicht
a               = [ones(1,net.nLayers)];
net.Structure   = net.Structure + a;

dim = size(net.Structure);


% Erzeugung der Gewichtsmatrix mit Biaswerten in der letzten Spalte
for i=1:dim(2)-1        
    weights{i} = generate_common_weights(net.Structure(i+1)-1,net.Structure(i),range);
end 

net.Structure   = net.Structure - a; % Rückbildung der ursprünglichen Netzstruktur