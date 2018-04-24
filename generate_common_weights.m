function weights = generate_common_weights(nEndNods, nStartingNods, weight_range,varargin)

% generiert zufällige gewichtsmatrix mit Elementen aus dem gewählten Interval.
% weight_range wird als Matrix übergeben zB [-1, 1]
% Dimension der Matrix wird über Anzahl der Neuronen in der Start- und
% Zielschicht bestimmt.

weights = weight_range(1) + (weight_range(2)-weight_range(1)).*rand(nEndNods,nStartingNods);