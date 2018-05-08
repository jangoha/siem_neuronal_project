function net = multiple_set_train(net, training_sets, alpha, beta, nIteration, method)
% Trainingsmethode um mehrere Groundtruthsets in Signal einzuspeisen und zu
% trianieren

% n = length(training_sets);

% instant Update: lässt jedes einzelne Trainingsmuster mit einer Iteration
% trainieren und springt dann weiter zum nächsten Muster. Ganzer Vorgang
% für alle Muster wird mit nIterations wiederholt.
% 
% epoch Update: trainiert jedes Muster aus dem Satz einzelnund nacheinander mit nIterations
% Gewichtsanpassungen. 
switch method
    case 'instant Update'
        switch_run_parameter       = nIteration;
        switch_Iteration_parameter = 1;
    case 'epoch Update'
        switch_run_parameter       = 1;
        switch_Iteration_parameter = nIteration;
end

for k=1:switch_run_parameter
    for j=1:length(training_sets)
        
        % train_samples = training_sets(j);
        net = multiple_sample_train(net, training_sets(j), alpha, beta, switch_Iteration_parameter, method);
    end

    
end
