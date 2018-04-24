function reversed_data = reverse_gaussian_normalization(normalized_data,mean_value,stdd_deviation)
% Invertiere gaussian_normalisation mit gegebenm mean_values und
% stdd_values


reversed_data = normalized_data*stdd_deviation+mean_value; 

     