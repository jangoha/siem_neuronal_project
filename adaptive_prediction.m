function [trainValues,net,varargout] = adaptive_prediction(net,set,nSteps,nTrainSamples,startIndex,alpha, beta, nIteration,timeLag)


% Definiere Start der Vorraussage

    x = set.x_values(startIndex:end);
    y = set.y_values(startIndex:end);

% Erzeuge Trainingssample
    trainValues = generate_train_samples(net,x,y,'samples','all');

    trainValues.train_y_values = horzcat(trainValues.train_y_values(1+timeLag:nTrainSamples));
    trainValues.train_x_values = horzcat(trainValues.train_x_values(1+timeLag:nTrainSamples));
    trainValues.nTrainSamples = nTrainSamples-timeLag;
    

% Trainiere das Netz auf alle Samples
tic
net = multiple_sample_train(net, trainValues, alpha, beta, nIteration,'instant Update');
varargout{1} = toc;


% Berechne Outputwerte zum Plotten der Ergebnisse
trainValues.x_Outputs = cell(1,trainValues.nTrainSamples);
trainValues.y_Outputs = cell(1,trainValues.nTrainSamples);

timeShift = max(0,timeLag-1); %Hilfsvariable zur x-Wertverschiebung in der for-schleife, da bei timeLag=0 eine versatz von 1 benötigt wird, sonst jedoch eine Verschiebung der Länge timeLag nötig ist.

for k = 1:(nSteps+nTrainSamples)
    
    in = trainValues.y_values{k};
    trainValues.y_Outputs{k} = test_net(net,in);
    trainValues.x_Outputs{k} = trainValues.x_values{k+1+timeShift}(end-trainValues.shift+1:end);
end

    