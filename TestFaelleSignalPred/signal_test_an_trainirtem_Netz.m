file='I:\1_MR\1_HQMR\R&D\SYS_APPL\TeamMitglieder\Werkstudenten\Ruben\RespatoryFiles\copy\test';type='rasp'
% file='I:\1_MR\1_HQMR\R&D\SYS_APPL\TeamMitglieder\Werkstudenten\Ruben\sinussignale'; type='sinus'
setwahl = [14];%11:11;

tic
sets = generate_sets(file,type,setwahl);
loadtime = toc;

cleanmethod = 'normal';
% cleanmethod = 'gaussian';
sets = clean_sets(sets,cleanmethod);



for j=1:length(sets)
   
    values = mittelung(sets(j),mittelungslaenge);
    sets(j).y_values = values.y_values;
%    sets(j).y_values = sin((5+0.0001*values.x_values).*values.x_values);%+sin(7*values.x_values)+values.x_values*1.5/300;
    sets(j).x_values = values.x_values;
end

tests = generate_test_sets(net,sets);

predictionmethod = 'continuous feed';
smoothing = 'smooth off';


plot_variables = compute_plotvariables_sets(net,tests,predictionmethod,smoothing);

for k=1:length(tests)
    
   figure()
   plot(vertcat(plot_variables(k).x_values{:})',vertcat(plot_variables(k).y_values{:})',sets(k).x_values,sets(k).y_values,'-.')
   title(['Berechnung an Sets: ', num2str(setwahl)])
    
end

