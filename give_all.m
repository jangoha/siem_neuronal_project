function ret = give_all(net, input)

% Funktion die alle internalStates und activations f�r jeweilige Inputs
% berechnet und speichert. Mehrere InpuSample k�nnen �bergeben werden,in
% dem sie zu einer Matrix zusammengef�gt werden.

dim =  size(input);
nInputsamples = dim(2);

ret(nInputsamples) = struct('activations',{0},'internal_states',{0}); % Definiere Structur mit vordefinierter Gr��e

for m=1:nInputsamples

            ret(m).activations = cell(1,net.nLayers); 
            ret(m).internal_states = ret(m).activations;
            
            for k=1:net.nLayers
                
                ret(m).activations{k} = activation(net,k,input(:,m));
                ret(m).internal_states{k} = internal_state(net,k,input(:,m));
                
            end
end