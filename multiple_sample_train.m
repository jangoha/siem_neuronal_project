function  net = multiple_sample_train(net, train_samples, alpha, beta, nIteration, method)

% Trainiert Netzwerk für verschiedene Trainingsamples, welche mit
% generate_train_samples erzeugt wurden. Dh. ein Datensatz wurde in
% verschiedene Teilstücke zerlegt welche nun zum Training genutz werden. Es
% kann weiter unterschieden werden, ob nach einer Backprop-Iteration für
% das jeweils präsentierte Trainings-Sample, die Gewichte angeglichen
% werden oder aber jedes Sample mit der vollen Iterationsanzahl trainiert wird.


n = train_samples.nTrainSamples;

switch method
    case 'instant Update'
        switch_run_parameter       = nIteration;
        switch_Iteration_parameter = 1;
    case 'epoch Update'
        switch_run_parameter       = 1;
        switch_Iteration_parameter = nIteration;
end

for k=1:switch_run_parameter

    for j=1:n

        com_y_values     = train_samples.y_values{j};
        com_train_values = train_samples.train_y_values{j};

        net = train(net, com_y_values, com_train_values, alpha, beta, switch_Iteration_parameter);

    end

end
    
    