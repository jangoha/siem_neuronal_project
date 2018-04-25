

function trigger = clean_trigger(trigger,scale)

len = length(trigger);

for k=1:len

    y = trigger(k).y_values;
    y = y - min(y);
    trigger(k).marker.y_values = any(y,1); % Filtere nach Triggern
    n = length(y);
    trigger(k).marker.time_values = trigger(k).marker.y_values.*linspace(0,n*0.25/1000,n); %ordne den Triggern die passende Zeit zu
    
    y = y./max(y)*2*scale-scale; % skaliere Triggerpeaks, so dass spätere Darstellungen mit Signal passen
   
    trigger(k).y_values = y;
end