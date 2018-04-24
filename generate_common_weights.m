function weights = generate_common_weights(nEndNods, nStartingNods, weight_range,varargin)

% generiert zuf�llige gewichtsmatrix mit Elementen aus dem gew�hlten Interval.
% weight_range wird als Matrix �bergeben zB [-1, 1]
% Dimension der Matrix wird �ber Anzahl der Neuronen in der Start- und
% Zielschicht bestimmt.

weights = weight_range(1) + (weight_range(2)-weight_range(1)).*rand(nEndNods,nStartingNods);