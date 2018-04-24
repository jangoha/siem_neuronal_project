function test_sets = generate_test_sets(net,sets)

% Erzeugt TestSample für jedes der übergebenen Sets

n = length(sets);

for j=n:-1:1
   
   x_values = sets(j).x_values;
   y_values = sets(j).y_values;
   
   test_sets(j) = generate_test_samples(net,x_values,y_values);
   
end