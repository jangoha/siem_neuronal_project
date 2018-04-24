function plot_variables = compute_plotvariables_sets(net,test_sets,method,smooth)

% Generiert Variablen die leichter zu plotten sind, anhand von testSets.
% Merhere Methiden wählbar siehe Doku "compute_plotvariables"

n = length(test_sets);

for j=n:-1:1
    
   test_samples = test_sets(j);
   
   plot_variables(j) = compute_plotvariables(net,test_samples,method,smooth);
    
end