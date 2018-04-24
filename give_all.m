function ret = give_all(net, input)

% Funktion die alle internalStates und activations für jeweilige Inputs
% berechnet und speichert. Mehrere InpuSample können übergeben werden,in
% dem sie zu einer Matrix zusammengefügt werden.

dim =  size(input);
nInputsamples = dim(2);

ret(nInputsamples) = struct('activations',{0},'internal_states',{0}); % Definiere Structur mit vordefinierter Größe

for m=1:nInputsamples

            ret(m).activations = cell(1,net.nLayers); 
            ret(m).internal_states = ret(m).activations;
            
            for k=1:net.nLayers
                
                ret(m).activations{k} = activation(net,k,input(:,m));
                ret(m).internal_states{k} = internal_state(net,k,input(:,m));
                
            end
end