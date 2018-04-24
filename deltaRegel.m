function trained_net = deltaRegel (net,in,trainmaterial,learningparameter,nIterations)

% Traingsmethode für Feedforward-Netz ohne Hidden-Schicht.

% Code noch nicht vollständig..

for p=1:nIterations
    out   = test_net(net,in);
    delta = trainmaterial-out;
    net.Weights{1} = net.Weights{1} + learningparameter*delta*activation(net,1,in)';
    
    
end

trained_net = net;