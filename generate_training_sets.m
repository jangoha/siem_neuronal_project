function training_sets = generate_training_sets(net,sets,samples_or_percentage,config_number)

% generiert aus den übergebenen Sets passenende Trainingsdaten, welche in
% das Netz gespeißt werden können.
% Hier bei kann eine Prozentangabe oder eine Sampleanzahl bestimmt werden.

nSets = length(sets);


for j=nSets:-1:1
    
   x_values = sets(j).x_values;
   y_values = sets(j).y_values;
   training_sets(j) = generate_train_samples(net, x_values,y_values,samples_or_percentage,config_number);
   
end

