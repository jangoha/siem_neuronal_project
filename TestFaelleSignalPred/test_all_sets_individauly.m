file = 'I:\1_MR\1_HQMR\R&D\SYS_APPL\TeamMitglieder\Werkstudenten\Ruben\RespatoryFiles\copy\test';type='rasp';

setsss = generate_sets(file,type);
setsss = clean_sets(setsss,'normal',0.1);

g = length(setsss);

for k=1:g
 
   % Setwahl
setwahl = [k];
sets = setsss(setwahl);

% Mittlewertset oder übernehem nur jeden x-ten Wert

schrittweite = 5;

for j=1:length(sets)
   
    sets(j).x_values = sets(j).x_values(1:schrittweite:end);
    sets(j).y_values = sets(j).y_values(1:schrittweite:end);
    
end



% Netzparameter
a=0.2;
weight_range    = [-a,a];
struc           = [100,1000,100];
biasStatus = 'active';

net = generate_tanh_feedforward(struc,weight_range,'Bias',biasStatus);


% Parameter für Training und Testsets
train_percentage = 0.35;
% ntrainsamples = 100;
trainsets = generate_training_sets(net,sets,'percentage',train_percentage);
tests = generate_test_sets(net,sets);


% Training des Netzes auf gewünschte Sets
alpha =  0.001;
beta = 0.02;
nIterations = 500;

tic
trainmethod = 'instant Update';
net=multiple_set_train(net, trainsets, alpha,beta,nIterations, trainmethod);
train_time=toc



% Erzeugung der nörtigen daten zum Ploten, Vergleichen und Begutachten

% predictionmethod = 'self propagation';
predictionmethod = 'both';

tic
plot_variables = compute_plotvariables_sets(net,tests,predictionmethod);
plotvariabel_time=toc

for j=1:length(sets)
    
figure()

ntrainsamples = trainsets(j).number_samples;
percent = trainsets(j).percentage*100;
subplot(3,2,1)
plot(sets(j).x_values(1:trainsets(j).feed_last_Index),sets(j).y_values(1:trainsets(j).feed_last_Index))
title(['Eingespeistes Signal, ', num2str(ntrainsamples),' Teilstücken (',num2str(percent),'%), ' , trainmethod])

subplot(3,2,2)
plot(sets(j).x_values,sets(j).y_values)
title(['original Signal, Set ',num2str(setwahl)])

subplot(3,2,[3,4])
plot(vertcat(plot_variables(j).continuous_feed.x_values{:})',vertcat(plot_variables(j).continuous_feed.y_values{:})',sets(j).x_values,sets(j).y_values,'-.')
title('continuous feed prediction');

subplot(3,2,[5,6])
plot(vertcat(plot_variables(j).self_propagation.x_values{:})',vertcat(plot_variables(j).self_propagation.y_values{:})',sets(j).x_values,sets(j).y_values,'-.')
title('self propagating prediction');

end 
    
% saving data
dataname = sprintf('data%03d',k);
save(dataname);

end