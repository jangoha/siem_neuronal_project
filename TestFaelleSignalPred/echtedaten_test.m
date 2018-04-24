clear all

%  Generiereung der Sets aus dem Order in file

file='I:\1_MR\1_HQMR\R&D\SYS_APPL\TeamMitglieder\Werkstudenten\Ruben\RespatoryFiles\copy\test';type='rasp';
% file='I:\1_MR\1_HQMR\R&D\SYS_APPL\TeamMitglieder\Werkstudenten\Ruben\sinussignale'; type='sinus'
setwahl = [11];%11:11;
disp(['Datatype: ',type])
tic
sets = generate_sets(file,type,setwahl);
loadTime = toc;
disp(['loadTime: ',num2str(loadTime),'sek'])
%% Begutachtung der Signale für Training

% figure(123123)
% for j=1:length(sets)
%    
%     x=sets(j).x_values;
%     y=sets(j).y_values;
%     subplot(5,4,j);
%     plot(x,y);
%     title(['Set ',num2str(j)]);
%     
% end

%% Auswahl der gewünschten Signale zum Training und Evaluation der Netze

% Setwahl
% sets = sets(setwahl);
cleanmethod = 'normal';
scale = 0.1;
% cleanmethod = 'gaussian';
sets = clean_sets(sets,cleanmethod,scale);
%% Rechenteil

% Mittlewertset oder übernehem nur jeden x-ten Wert

% schrittweite = 5;
% 
% for j= 1:length(sets)
%    
%     sets(j).x_values = sets(j).x_values(1:schrittweite:end);
%     sets(j).y_values = sets(j).y_values(1:schrittweite:end);
%     
% end


mittelungslaenge = 51;

for j=1:length(sets)
   
    values = mittelung(sets(j).x_values,sets(j).y_values,mittelungslaenge);
    sets(j).y_values = values.y_values;
%    sets(j).y_values = sin((5+0.0001*values.x_values).*values.x_values);%+sin(7*values.x_values)+values.x_values*1.5/300;
    sets(j).x_values = values.x_values;
end



% Netzparameter
a=0.1;
weight_range    = [-a,a];
struc           = [50,100,60,13]; %165,100,60,33
biasStatus = 'active';

net = generate_tanh_feedforward(struc,weight_range,'Bias',biasStatus);


% Parameter für Training und Testsets
% train_percentage = 0.02;
% trainsets = generate_training_sets(net,sets,'percentage',train_percentage);
ntrainsamples = 6;
trainsets = generate_training_sets(net,sets,'samples',ntrainsamples);
tests = generate_test_sets(net,sets);


% Training des Netzes auf gewünschte Sets
alpha =  0.001;
beta = 0.01;
nIterations = 2000;

tic
trainmethod = 'instant Update';
net = multiple_set_train(net, trainsets, alpha,beta,nIterations, trainmethod);
trainTime=toc;
disp(['trainTime: ',num2str(trainTime),'sek'])




% Erzeugung der nörtigen daten zum Ploten, Vergleichen und Begutachten

% predictionmethod = 'self propagation';
predictionmethod = 'both';
smoothing = 'smooth off';

tic
plot_variables = compute_plotvariables_sets(net,tests,predictionmethod,smoothing);
plotVariableTime=toc;
disp(['plotVariableTime: ',num2str(plotVariableTime),'sek'])

for j=1:length(sets)
    
figure()
ntrainsamples = trainsets(j).nTrainSamples;
percent = trainsets(j).percentage*100;
subplot(3,2,1)
plot(sets(j).x_values(1:trainsets(j).feed_last_Index),sets(j).y_values(1:trainsets(j).feed_last_Index))
title(['Eingespeistes Signal, ', num2str(ntrainsamples),' Teilstücken (',num2str(percent),'%), ' , trainmethod])

subplot(3,2,2)
plot(sets(j).y_values)
% plot(sets(j).x_values,sets(j).y_values)
title(['original Signal, Set ',num2str(setwahl)])

subplot(3,2,[3,4])
% plot([vertcat(plot_variables(j).continuous_feed.y_values{:}) (sets(j).y_values)],'-.')
plot(vertcat(plot_variables(j).continuous_feed.x_values{:})',vertcat(plot_variables(j).continuous_feed.y_values{:})',sets(j).x_values,sets(j).y_values,'-.')
title(['continuous feed prediction, ',smoothing]);

subplot(3,2,[5,6])
plot(vertcat(plot_variables(j).self_propagation.x_values{:})',vertcat(plot_variables(j).self_propagation.y_values{:})',sets(j).x_values,sets(j).y_values,'-.')
title(['self propagating prediction, ',smoothing]);

end

