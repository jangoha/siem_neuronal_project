function weights = generate_net_weights(net,weight_range)

% Generiert Gewichtsmatrizen des gewählten Netzes, außer Outputgewichte.
% weight_range wird als Matrix übergeben zB [-1, 1].

dim = size(net.Structure);

for i=1:dim(2)-1 % Outputgewichtsmatrix wird nicht erzeugt
    
    weights{i} = generate_common_weights(net.Structure(i+1),net.Structure(i),weight_range);
    
end