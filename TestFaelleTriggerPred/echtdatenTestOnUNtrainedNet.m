clear all; close all; clc; 
% cd ../.   <- geht einen folder hoch, wird aber bei nächstem programmstart
% aufaddiert, deswegen so (janko):
 cd('D:\My Documents\matlab janko\NeuronaleNetze\NeuronalesNetz\FeedForward');   % eingefügt (janko)

newPath = pwd; % geändert von cd auf pwd (janko)
setPath(newPath,true)

% % % lade Signale und Triggerdaten
fileTrigger = 'D:\My Documents\matlab janko\NeuronaleNetze\RespatoryFiles\copyTrigger\tests'; 
typeTrigger = 'normal';% Normal damit load in generate_sets, in den rihctigen SwitchCase fällt
fileSignals = 'D:\My Documents\matlab janko\NeuronaleNetze\RespatoryFiles\copy\test';
typeSignals = 'rasp';

Wahl = [1 4 17];
tic
trigger = generate_sets(fileTrigger,typeTrigger,Wahl);  % generate_sets läd x und y daten (janko)
sets = generate_sets(fileSignals,typeSignals,Wahl);     % macht dasselbe für signals statt trigger (janko)
%trigger = generate_sets(fileTrigger,typeTrigger);
% sets = generate_sets(fileSignals,typeSignals);
loadTime = toc;
disp(['loadTime = ',num2str(loadTime)]);  


% % % Preprocess Datensätze

% cleanmethod = 'gaussian';
cleanMethod = 'normal';
scale = 0.1;
sets = clean_sets(sets,cleanMethod,scale);
trigger = clean_trigger(trigger,scale);
%figure();hold on,plot(sets.x_values, sets.y_values)%trigger.x_values, trigger.y_values);
mittelungslaenge = 21;

for j=1:length(sets) % hier wird die mittelung für die set-werte und für die trigger-werte durchgeführt (janko)
   
    values = mittelung(sets(j).x_values,sets(j).y_values,mittelungslaenge);
    sets(j).y_values = values.y_values;
    sets(j).x_values = values.x_values;
    %   sets(j).y_values = sin((5+0.0001*values.x_values).*values.x_values);%+sin(7*values.x_values)+values.x_values*1.5/300;
    
    triggerValues = mittelung(trigger(j).x_values,trigger(j).marker.y_values,mittelungslaenge);%<--- mitteln der Triggerwerte verschiebt den Triggerpunkt aus dem Original, wird die mittellaenge klein gehalten ist dies unproblematisch
    trigger(j).marker.y_values = triggerValues.y_values./max(triggerValues.y_values);
    trigger(j).marker.x_values = triggerValues.x_values;
    %   trigger(j).y_values = (trigger(j).y_values./max(trigger(j).y_values))*(2*scale)-scale;
    
end     

% plot(sets.x_values, sets.y_values,trigger.marker.x_values,trigger.marker.y_values),hold off;
% legend ('signal ohne mittleung','trigger ohne mittelung','signal mit mittelung','trigger mit mittelung')

% hold on;plot(sets.x_values, sets.y_values,trigger.x_values, trigger.y_values);hold off

%%
% % % Erzeuge FF-Netz
a = 0.3;                            	% war 0.1  (janko)
weight_range    = [-a,a];
struc           = [50,100,1];           % war 100 200 100 1 (janko)
biasStatus = 'inactive';

schwellwert = 0.85;                     %   Schwellwert gibt den x-Wert an der die logistische Funktion 0.5 sein soll
sensibilitaet = -15;                    %   gibt tendenz der Steigung der logistischen Funktion, je sensibler desto steiler ist die Funktion

net = generate_tanh_feedforward(struc,weight_range,'Bias',biasStatus);
net.Activationfun = 'logistic';
net.ActivFunParameter = {sensibilitaet,-schwellwert*sensibilitaet,0}; % formel erhält man durch umstellen und auflösen 
%% set Activation function -> new function
net = set_activationfun(net);       % aktivierungsfunktion wird jetzt nach der netzgenerierung einmalig festgesetzt
%%
% Initzialisiere Trainingsparameter
alpha =  0.01;
beta = 0.1; 
nIterations = 100;                          % war 1000 (janko)
nTrainSamples = 40;                         % war 50 , 124 ist obere Grenze, danach Fehlermeldung -> Index exceeds matrix dimensions.(janko)
startIndex = 1;
timeLag = 0;                                %round(800/mittelungslaenge);

%%

%  Generiere Trainingsdatensätze, da die Inputwerte die in trainValues
%  zuerst abgelegt werden nicht die Werte des Signals sind, werden diese
%  danach mit den richtigen Daten überschrieben

for j=1:length(Wahl)
trainValues = generate_train_samples(net,trigger(j).marker.x_values,trigger(j).marker.y_values,'samples','all');
trainValues2 = generate_train_samples(net,sets(j).x_values,sets(j).y_values,'samples','all'); 
trainValues.y_values = trainValues2.y_values;       %<---- Hier werden die richtigen Inputdaten für das Netz zum Training gesetzt 
trainValues.x_values = trainValues2.x_values;

testValues(j) = generate_test_samples(net,trigger(j).marker.x_values,trigger(j).marker.y_values);
testValues2(j) = generate_test_samples(net,sets(j).x_values,sets(j).y_values);
testValues(j).x_values = testValues2(j).x_values;         %<--- selbes Prozedere wie Oben bei den trainValues
testValues(j).y_values = testValues2(j).y_values;


% Hier wird die gewünschte TimeLag Verschiebung erzeugt, die ersten
% Trainingswerte werden verworfen und damit wird der neue erste
% Trainingswert dem ersten Inputwert zugeordnet. Damit die Methoden
% durchlaufen muss an den Inputwerten am Ende ebenfalls gekürzt werden
trainValues.train_y_values  = trainValues.train_y_values(1+timeLag:end);
trainValues.train_x_values  = trainValues.train_x_values(1+timeLag:end);
trainValues.x_values        = trainValues.x_values(1:end-timeLag);
trainValues.y_values        = trainValues.y_values(1:end-timeLag);


trainValues = prepare_train_Samples(trainValues); %<--- Hier werden die TrainingsSample ausgeglichen, da "nicht Triggern" in den TrainingsSample deutlich überwiegen

% Kürze die Werte auf die gewünschte Anzahl an TrainingsSample
trainValues.train_y_values  = trainValues.train_y_values(1:nTrainSamples);
trainValues.train_x_values  = trainValues.train_x_values(1:nTrainSamples);
trainValues.x_values        = trainValues.x_values(1:nTrainSamples);
trainValues.y_values        = trainValues.y_values(1:nTrainSamples);
trainValues.feed_signal_indices = trainValues.feed_signal_indices(1:nTrainSamples);
trainValues.train_indices =trainValues.train_indices(1:nTrainSamples);
trainValues.nTrainSamples   = nTrainSamples-timeLag;

%%

%  Training...
tic
net = multiple_set_train(net, trainValues, alpha, beta, nIterations, 'instant Update');
trainTime = toc;
disp(['trainTime = ',num2str(trainTime),'sek / ',num2str(trainTime/60),'min'])

end
%%
%Erzeuge Output des Netzes um diese plotten zu können
figure()
for j=1:length(Wahl)
for k = 1:testValues(j).number_samples
    
    in = testValues(j).y_values{k};
    y_Outputs{k} = test_net(net,in);
%     trainValues.x_Outputs{k} = trainValues.x_values{k+1+timeShift}(end-trainValues.shift+1:end);
end

outs{j} = vertcat(y_Outputs{:});

%clear y_Outputs;
 hold on;
    subplot(length(Wahl),1,j)
    plot(testValues(j).original_x_values(struc(1)+1:end)',outs{j}-0.5,'x',trigger(j).marker.x_values(struc(1)+1:end),trigger(j).marker.y_values(struc(1)+1:end)-0.5,...
            sets(j).x_values(struc(1)+1:end),5*sets(j).y_values(struc(1)+1:end)*3)
    ylim([-5.1,5.1]);
    legend('NetzOutput','Original Trigger', 'Signal');
    title(['Set: ',num2str(Wahl),' / Schwellwert: ',num2str(schwellwert),' / Sensibilität: ',num2str(sensibilitaet),' / nIterations: ',num2str(nIterations),...
            ' / timeLag: ',num2str(timeLag),' / Mittelung: ',num2str(mittelungslaenge),' / Struc: [',num2str(struc),'] / Bias: ',biasStatus])
    grid on;
   
end   

%% Bewertung des Outputs :
review = struct('distances',0,'average_distance',0,'average_trigger_ratio',0, 'trigger_not_hit',0);
threshold = 0.95;                                                               %   threshold gibt an ab wann ein outputwert als trigger zählen soll (-> alles ab threshold ist trigger)
simple_output = clean_net_output(outs, threshold);                              %   Triggerwerte werden auf 1 oder 0 gezogen
review = review_net_output(review, simple_output, trigger,struc(1)+1);          %   numerische Bewertung des outputs in einem Array selber Länge 
                                                                                %   umso höher die Zahl desto weiter ist der Netzoutput von Vorgabe weg
%   get_review_output(review, trigger, simple_output, Wahl);        -> funktion um review als text auszugeben                                                                       
%   plot(trigger(1).marker.x_values(struc(1)+1:end)',cell2mat(review.distances(1)),'r*')                                                                    
%   review plot

%%

%%
            % figure(),hold on
            % plot(sets.y_values)
            % plot(trigger.y_values)
            % plot(horzcat(trainValues.y_Outputs{:}))
            % legend('Signal','original Trigger','Netz Trigger')
            % hold off
            % % %  auskommentierter Teil diente zur händischen Selektion der
            % % % Outputwerte in 'Trigger' und 'nicht Trigger' abhängig vom Schwellwert 
            % schwellwert = 0.1;
            % for k=1:length(outs)
            %    
            %     if outs(k)<schwellwert && outs(k)>((-1)*schwellwert)
            %         outs(k) = 0;
            %         
            %     elseif outs(k)>schwellwert
            %         outs(k) = 1;
            %     end
            %     
            % end
            % refs = vertcat(trainValues.train_y_values{:});
            % tab = table(outs,refs);
            % 
            % fehler = 0;
            % 
            % for k=1:length(outs)
            %    
            %     if outs(k)~=refs(k)
            %         fehler = fehler+1;
            %     end
            %     
            % end
            % disp(['Anzahl an Fehlern mit Schwellwert(',num2str(schwellwert),'): ',num2str(fehler),' / ',num2str(length(outs))])
            % In plot müssen hier wieder teilweise die ersten Werte verworfen werden,
            % da diese für die Berechnung des erten Outputwerts gebraucht werden und
            % in diesem Intervall folglich keine Trigger besetzt werden können
 %%           

% figure()
% for j=1:length(Wahl)
%      hold on;
%     subplot(length(Wahl),1,j)
%     plot(testValues.original_x_values(struc(1)+1:end)',outs{j}-0.5,'x',trigger(j).marker.x_values(struc(1)+1:end),trigger(j).marker.y_values(struc(1)+1:end)-0.5,...
%             sets(j).x_values(struc(1)+1:end),5*sets(j).y_values(struc(1)+1:end))
%     ylim([-5.1,5.1]);
%     legend('NetzOutput','Original Trigger', 'Signal');
%     title(['Set: ',num2str(Wahl),' / Schwellwert: ',num2str(schwellwert),' / Sensibilität: ',num2str(sensibilitaet),' / nIterations: ',num2str(nIterations),...
%             ' / timeLag: ',num2str(timeLag),' / Mittelung: ',num2str(mittelungslaenge),' / Struc: [',num2str(struc),'] / Bias: ',biasStatus])
%     grid on;
% end   
 