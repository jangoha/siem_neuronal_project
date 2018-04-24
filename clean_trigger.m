function trigger = clean_trigger(trigger,scale)



for k = 1 : length(trigger)

%     y = trigger(k).y_values;
    trigger(k).y_values = trigger(k).y_values - min(trigger(k).y_values);
    trigger(k).marker.y_values = any(trigger(k).y_values,1); % Filtere nach Triggern
    
    trigger(k).marker.time_values = trigger(k).marker.y_values .* linspace(0, length(trigger(k).y_values) * 0.25 / 1000, length(trigger(k).y_values)); %ordne den Triggern die passende Zeit zu
    
    trigger(k).y_values = trigger(k).y_values ./ max(trigger(k).y_values) * 2 * scale - scale; % skaliere Triggerpeaks, so dass spätere Darstellungen mit Signal passen
   
%     trigger(k).y_values = y;
end


