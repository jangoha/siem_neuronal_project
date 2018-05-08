

% Atmungsperiode ~ Anzahl der Trigger / Gesamtzeit    % f�r berechnung der Zeitsperre
% -> Zeitsperre = 1/5 Atmungsperiode                  % Zeit in der kein Trigger gesetzt werden darf -> wird �bersprungen

Anzahl der Trigger  ->      sum( trigger(1).marker.y_values == 1 )
Gesamtzeit          ->      trigger(1).marker.x_values(length(trigger(1).marker.x_values))

gstd_trigger = simplify_trigger

plot(trigger(1).marker.x_values(struc(1)+1:end), outs{1,1} ,'x') %  triggermarker ohne die ersten 50 werte