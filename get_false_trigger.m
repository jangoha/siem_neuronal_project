function trigger_not_hit = get_false_trigger(trig_idx, s_o_idx)

%%%     Beschreibung :    %%% 
%   Die Funktion durchsucht den Netzoutput ('s_o_idx') ob jeder vorgegebene
%   (Goldstandard-) Trigger ('trig_idx') mindestens einmal getroffen wurde.
%   Funktion geht f�r 3 oder mehr Goldstandard-Trigger, bei weniger ->error


output_idx_counter  = 1;             	%   z�hlt den Netzoutput-index mit
trigger_hits        = 0;                %   z�hlt wie viele trigger getroffen wurden -> differenz am ende sind die nicht getroffenen Trigger

if (s_o_idx(1) <= ( trig_idx(1) + floor((trig_idx(2) - trig_idx(1)) / 2) ) )
    % hier: wird erster trigger getroffen?? -> aussage �ber ersten und
    % letzten trigger sind m��ig genau weil eine Grenze fehlt und nur der
    % erste bzw. letzte Output-wert gepr�ft werden!
    trigger_hits = trigger_hits + 1;
    output_idx_counter = output_idx_counter + 1;
end


    for i = 2 : (length(trig_idx)-1)    %   Schleife geht von 2. bis vorletzten Triggermarker wegen �berlauf
                                        %   erster und letzter Triggermarker m�ssten seperat behandelt werden

        dist_next_trigger = floor((trig_idx(i+1) - trig_idx(i)) / 2);                   %   obere Grenze des Tr.- Bereichs
        dist_last_trigger = floor((trig_idx(i) - trig_idx(i-1)) / 2);                   %   untere Grenze des Tr.- Bereichs
        
        while ( ( output_idx_counter <= length(s_o_idx) ) &&  ( s_o_idx(output_idx_counter) <= ( trig_idx(i) + dist_next_trigger ) ) )     %   w�hrend output kleiner gleich obere Grenze ...
            if (s_o_idx(output_idx_counter) >= ( trig_idx(i) - dist_last_trigger ) )    %   falls output gr��er gleich untere Grenze ..
                trigger_hits = trigger_hits + 1;                                        %   -> trigger hit
                break;                                                                  %   weiter zu n�chstem Trigger marker
            else if ( output_idx_counter < length(s_o_idx) )
                output_idx_counter = output_idx_counter + 1;                            %   output kleiner unterer Grenze -> hochz�hlen und weiter suchen
            else
                break;
            end
            
            end
        end 
    end
    
    if (s_o_idx(end) >= ( trig_idx(end) - floor((trig_idx(end) - trig_idx(end - 1)) / 2) ) )
        % hier: wird letzter trigger getroffen??
        trigger_hits = trigger_hits + 1;
    end
    
    trigger_not_hit = (length(trig_idx) - trigger_hits);
    string = sprintf('Es wurden %d von %d Trigger marker getroffen.', (trigger_hits), length(trig_idx));
        %   Im string Annahme dass erster und letzter Marker getroffen
        %   wurden obwohl nicht gepr�ft!!! (+2)
    disp(string);