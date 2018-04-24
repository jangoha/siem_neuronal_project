% file='I:\1_MR\1_HQMR\R&D\SYS_APPL\TeamMitglieder\Werkstudenten\Ruben\RespatoryFiles\copy\test';type='rasp'
file='I:\1_MR\1_HQMR\R&D\SYS_APPL\TeamMitglieder\Werkstudenten\Ruben\sinussignale'; type='sinus'

run_sets = generate_sets(file,type);
% run_sets = clean_sets(run_sets);


runwahl = [1];
runset = run_sets(runwahl);



% mittelungslaenge aus dem geladenen Datensatz entnommen

for j=1:length(runset)
   
    values = mittelung(runset(j),mittelungslaenge);
%     runset(j).y_values = values.y_values;
    runset(j).y_values = sin(5*values.x_values)+sin(7*values.x_values);
    runset(j).x_values = values.x_values;
end


runtest = generate_test_sets(net,runset);

predictionmethod = 'both';
smoothing = 'smooth off';

tic
plot_variables_test = compute_plotvariables_sets(net,runtest,predictionmethod,smoothing);
plotvariabel_time=toc


for j=1:length(runset)
    
figure()
% ntrainsamples = trainsets(j).number_samples;
% percent = trainsets(j).percentage*100;
% subplot(3,2,1)
% plot(runset(j).x_values(1:trainsets(j).feed_last_Index),runset(j).y_values(1:trainsets(j).feed_last_Index))
% title(['Eingespeistes Signal, ', num2str(ntrainsamples),' Teilstücken (',num2str(percent),'%), ' , trainmethod])

subplot(3,2,[1,2])
plot(runset(j).x_values,runset(j).y_values)
title(['original Signal, Set ',num2str(runwahl(j))])

subplot(3,2,[3,4])
plot(vertcat(plot_variables_test(j).continuous_feed.x_values{:})',vertcat(plot_variables_test(j).continuous_feed.y_values{:})',runset(j).x_values,runset(j).y_values,'-.')
title(['continuous feed prediction, ',smoothing]);

subplot(3,2,[5,6])
plot(vertcat(plot_variables_test(j).self_propagation.x_values{:})',vertcat(plot_variables_test(j).self_propagation.y_values{:})',runset(j).x_values,runset(j).y_values,'-.')
title(['self propagating prediction, ',smoothing]);

end