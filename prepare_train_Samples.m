function trainSamples = prepare_train_Samples(trainSamples)

% teste vollständigen Traingssatz auf positive(p) und neagtive(n) Triggermarker.
% Setze zufällig einen neuen Trainigssatz aus gleich vielen negative wie
% positiven Triggermarkern zusammen

pCounter = 0;
nCounter = 0;

% Zähle Anzahl an p und n Markern und deren Position in
% trainSample-Structur
for k = 1:length(trainSamples.train_y_values)
   
    if trainSamples.train_y_values{k}==1
        pCounter = pCounter +1;
        pIndices(pCounter) = k;

    elseif trainSamples.train_y_values{k}==0
        nCounter = nCounter+1;
        nIndices(nCounter) = k;
  
    end 
end

% Setze allgemeine Variablen
if nCounter<=pCounter
    
    turncatedIndices = pIndices;
    indices = nIndices;
     
elseif pCounter<=nCounter
     
    turncatedIndices = nIndices;
    indices = pIndices;
end

maxCounter = max(nCounter,pCounter);
minCounter = min(nCounter,pCounter);
    

% Erzeuge zufällige Indexvariablen zur Auswahl aus dem größeren Datensatz
% (n oder p)
mixer = randi(maxCounter,1,minCounter);
turncatedIndices = turncatedIndices(mixer);


% Verbinde p und n MarkerIndices und permutiere diese für bessere
% Trainigseffekte.
perm = randperm(2*minCounter);
finalIndices = [turncatedIndices,indices];
finalIndices = finalIndices(perm);


% verändere Trainingsvariablen in trainSample-Structur
trainSamples.x_values = trainSamples.x_values(finalIndices);
trainSamples.y_values = trainSamples.y_values(finalIndices);
trainSamples.feed_signal_indices = trainSamples.feed_signal_indices(finalIndices);
trainSamples.train_x_values = trainSamples.train_x_values(finalIndices);
trainSamples.train_y_values = trainSamples.train_y_values(finalIndices);
trainSamples.train_indices = trainSamples.train_indices(finalIndices);
trainSamples.nTrainSamples = minCounter*2;
trainSample.percentage = {};


