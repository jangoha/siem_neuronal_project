function sets = generate_train_values(sets,ntrainSamples)

switch ntrainSamples
    case 'all'
        ntrainSamples = length(sets.x_values);
    otherwise
        
end

for j=1:ntrainSamples
    
    start_index = sets.signal_indices{j}(2)+1;
    end_index   = start_index+sets.shift-1;
    
    sets.train_x_values{j} = sets.x_values{j+1}(end-sets.shift+1:end);
    sets.train_y_values{j} = sets.y_values{j+1}(end-sets.shift+1:end);
    sets.train_indices{j}  = [start_index,end_index];
    
end