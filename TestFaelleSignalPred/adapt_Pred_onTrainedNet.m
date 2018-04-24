% % % Berechnet Siganl mit einem trainierten FeedForward-Netz vorraus. HIer für
% % % muss der netfile angepasst werden, um gewünschtes Netz und zugehörige
% % % Parameter zu laden.



clear all

%  Generiereung der Sets aus dem Order in file

file='I:\1_MR\1_HQMR\R&D\SYS_APPL\TeamMitglieder\Werkstudenten\Ruben\RespatoryFiles\copy\test';type='rasp';
% file='I:\1_MR\1_HQMR\R&D\SYS_APPL\TeamMitglieder\Werkstudenten\Ruben\sinussignale';type='sinus'

netfile = 'I:\1_MR\1_HQMR\R&D\SYS_APPL\TeamMitglieder\Werkstudenten\Ruben\MatLabCodes\26.9\dataSet19_mit21_15kIterations.mat';
load(netfile, 'net');

setwahl = [19];%,5,6,8,13];%11:11;2,3,
tic
sets = generate_sets(file,type,setwahl);
% sets = generate_sets(file,type);
loadtime = toc;
disp(['SetLoadTime: ',num2str(loadtime),'sek'])

% cleanmethod = 'gaussian';
cleanmethod = 'normal';
scale = 0.1;
sets = clean_sets(sets,cleanmethod,scale);

load(netfile, 'mittelungslaenge')

for j=1:length(sets)
   
    values = mittelung(sets(j).x_values,sets(j).y_values,mittelungslaenge);
    sets(j).y_values = values.y_values;
%    sets(j).y_values = sin((5+0.0001*values.x_values).*values.x_values);%+sin(7*values.x_values)+values.x_values*1.5/300;
    sets(j).x_values = values.x_values;
end





nParts = 'all';
load(netfile,'timeLag')


data = dismantle_signal(net, sets.x_values, sets.y_values, 'samples', nParts, net.nOutputUnits);

data.x_Outputs = cell(1,data.number_samples);
data.y_Outputs = cell(1,data.number_samples);
tic
for k = 1:data.number_samples
    
    in = data.y_values{k};
    data.y_Outputs{k} = test_net(net,in)*(-1);
    data.x_Outputs{k} = data.x_values{k+1}(end-data.shift+1:end);
end
computeTime = toc;
disp(['computeTime: ',num2str(computeTime),'sek'])

%%

figure()

plot(horzcat(data.x_Outputs{:}),horzcat(data.y_Outputs{:}),horzcat(data.x_values{:}),horzcat(data.y_values{:}),'-.')
legend('NetOutput','Signal')
title(['Set ',num2str(setwahl),' / FFN: [',num2str(net.Structure),'] / nParts: ',num2str(nParts),' / Mittelung: ',num2str(mittelungslaenge),' / TimeLag: ',num2str(timeLag),' / ',net.TrainingStatus])





