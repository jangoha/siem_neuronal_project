clear all

%  Generiereung der Sets aus dem Order in file

file='I:\1_MR\1_HQMR\R&D\SYS_APPL\TeamMitglieder\Werkstudenten\Ruben\RespatoryFiles\copy\test';type='rasp';
% file='I:\1_MR\1_HQMR\R&D\SYS_APPL\TeamMitglieder\Werkstudenten\Ruben\sinussignale';type='sinus'


setwahl = [19];%,5,6,8,13];%11:11;2,3,
tic
sets = generate_sets(file,type,setwahl);
% sets = generate_sets(file,type);mit21
loadtime = toc;

% cleanmethod = 'gaussian';
cleanmethod = 'normal';
scale = 0.1;
sets = clean_sets(sets,cleanmethod,scale);


%%

% figure(123123)
% for j=length(sets):-1:1
%    
%     x=sets(j).x_values;
%     y=sets(j).y_values;
%     bound1 = zeros(1,length(x));
%     bound2 = zeros(1,length(x));
%     calc = std(y);
%     fakt = 3;
%     bound1(:) = calc*fakt;
%     bound2(:) = -calc*fakt;
%     
%     subplot(5,4,j);
%     plot(x,y,x,bound1,x,bound2);
%     title(['Set ',num2str(j)]);
%     
% end

%%

% Mittlewertset oder übernehem nur jeden x-ten Wert

% schrittweite = 5;
% 
% for j= 1:length(sets)
%    
%     sets(j).x_values = sets(j).x_values(1:schrittweite:end);
%     sets(j).y_values = sets(j).y_values(1:schrittweite:end);
%     
% end

mittelungslaenge = 21;

for j=1:length(sets)
   
    values = mittelung(sets(j).x_values,sets(j).y_values,mittelungslaenge);
    sets(j).y_values = values.y_values;
%    sets(j).y_values = sin((5+0.0001*values.x_values).*values.x_values);%+sin(7*values.x_values)+values.x_values*1.5/300;
    sets(j).x_values = values.x_values;
end


% Netzparameter
a=0.3;
weight_range    = [-a,a];
struc           = [1,100,50,1]; %165,100,60,33
biasStatus = 'active';

net = generate_tanh_feedforward(struc,weight_range,'Bias',biasStatus);


alpha =  0.01;
beta = 0.1; 
nIterations = 15;
nSteps = 500;
nTrainSamples = 500;
startIndex = 1;
trainTime =0;
timeLag = round(800/mittelungslaenge);

% for j= 1:nIterations
    for k=1:length(sets)
    
    [data(k),net,singleTrainTime] = adaptive_prediction(net,sets(k),nSteps,nTrainSamples,startIndex,alpha, beta, nIterations,timeLag);
    trainTime = trainTime+singleTrainTime;
    
    end
% end
disp(['trainTime: ',num2str(trainTime),'sek / ',num2str(trainTime/60),'min / ',num2str(trainTime/3600),'h'])

% MAX_MIN = [max(data.y_Outputs{1}),...
% min(data.y_Outputs{1})]

% save dataOnSets_allBut_10_6870Iterations
for j=1:length(sets)
    
f = figure();
subplot(2,3,1)
plot(sets(j).x_values(startIndex:data(j).train_indices{end}(2)),sets(j).y_values(startIndex:data(j).train_indices{end}(2)),'-.',horzcat(data(j).x_Outputs{1:nTrainSamples}),horzcat(data(j).y_Outputs{1:nTrainSamples}))
legend('Signal','TrainOutput')
title(['Eingespeistes Signal, ', num2str(data(j).nTrainSamples),' Teilstücken'])

subplot(2,3,[2,3])
plot(sets(j).x_values,sets(j).y_values)
title(['original Signal, Set ',num2str(setwahl)])

subplot(2,3,[4 5 6])
plot(sets(j).x_values,sets(j).y_values,'-.',horzcat(data(j).x_Outputs{:}),horzcat(data(j).y_Outputs{:}))
% title(['Vorhergesagtes Signal mit ', num2str(nSteps), ' Schritten']);
legend('Signal','TestOutput')
title(['Test /',' Netz: [' num2str(struc) '] / Iterationen: ' num2str(nIterations),' / Mittelung: ',num2str(mittelungslaenge),'/ TimeLag: ',num2str(timeLag)])
ax = gca;
vab = max(max(horzcat(data(j).x_Outputs{:})));
ax.XLim = [-0.1,vab+1];
set(f, 'Units', 'normalized', 'Position', [0.1, 0.1, 0.7, 0.7]);
end

