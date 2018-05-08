function review = review_net_output(review, simple_output, trigger, cut_first_values)

%   Die Funktion erstellt eine numerische Bewertung des vereinfachten
%   Netzoutputs verglichen mit den Groundtruth Daten.
%   Damit nicht alle Werte durchlaufen werden, wird mit den Indexwerten der
%   Trigger gerechnet
%   für jeden Trigger wird innerhalb der inneren Schleife die Entfernung
%   zum nächsten Trigger berechnet und an richtiger Stelle in 'review'
%   gespeichert


for i = 1 : length(simple_output)
    
   
    
    trigger_counter         =   1;                                                                  %   zählt mit wo sich der current trigger befindet
    review_part             =   zeros(1,length(cell2mat(simple_output(i))));                        %   Bewertung wird erst in parts gespeichert und später als cells im Rückgabewert (review)
    trigger_index           =   find (trigger(i).marker.y_values(cut_first_values:end));            %   Indizes der vorgegebenen Trigger (Groundtruth) entspricht Bewertungskriterium
    simple_output_index     =   find(cell2mat(simple_output(i)));                                   %   Indizes der vom Netz erstellten Trigger (das sind die Daten die bewertet werden)
    current_trigger         =   trigger_index(trigger_counter);                                     %   aktiver Trigger als Indexwert
    distance_to_next_trig   =   (trigger_index(trigger_counter + 1) - current_trigger)/2;           %   halbierte distanz; ab der halben strecke wird auf den nächsten trigger gewechselt
    

     if (sum(cell2mat(simple_output(i))) == 0)                                                                %   Prüfung ob Netzoutput leer
        disp('Fehler: keine Netztrigger zur Bewertung gefunden!');
     else
    for j = 1 : length(simple_output_index)                                                         %   durchläuft alle Triggerwerte des neur. Netzes
        
%   wenn der outputwert in den Bereich des nächsten Groundtruth-Triggers
%   geht, wird der current_trigger auf den nächsten gesetzt und die
%   Entfernung zu dem nächsten Trigger neu berechnet
        
        while ((current_trigger + distance_to_next_trig ) < simple_output_index(j)) && ~(current_trigger == trigger_index(end));
            trigger_counter = trigger_counter + 1;                                          
            current_trigger = trigger_index(trigger_counter);
            if ~(current_trigger == trigger_index(end))                                             %   check ob es der letzte trigger-index ist. falls ja nicht ausführen da sonst überlauf!
                distance_to_next_trig = (trigger_index(trigger_counter + 1) - current_trigger)/2;
            end
        end
        
        review_part(simple_output_index(j)) = abs((current_trigger - simple_output_index(j)));      %   Bewertung: pro Zelle/Zeitwert Abstand zu vorgegebenen Trigger 1 "Minuspunkt"	
           
    end
    
%   die ersten review - Werte werden verworfen. (51 Werte, abh. von inputgröße der Struktur!)
%   danach speichern in rückgabewert als cell

    review.trigger_not_hit(i) = get_false_trigger(trigger_index, simple_output_index);
    
    review_part(1:cut_first_values) = 0;    
    review_cell(i) = num2cell(review_part, [1 2]);
    review.average_trigger_ratio(i) = (length(simple_output_index)/length(trigger_index));
    review.average_distance(i) = (sum(review_part)/length(simple_output_index));
     end
end
review.distances = review_cell;
%review_part
end