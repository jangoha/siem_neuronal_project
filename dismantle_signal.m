function parts = dismantle_signal(net, x_values,y_values,samples_or_percentage,config_number,shift)


% Initialisierung der Sampleanzahl in Abhängigkeit von der Eingabe, ob
% prozentualer Anteil oder fixe Sampleanzahl gewünscht ist


switch samples_or_percentage
    case 'samples'
        number_samples = config_number;
        com_x = x_values(1:end-net.nOutputUnits)'; % Kürze das Signal um eine letzte potentielle Netzausgabe und erzeuge einen Zeilenvektor
        com_y = y_values(1:end-net.nOutputUnits)';
        
    case 'percentage'
        number_samples = 'all';
        l = floor(length(x_values)*config_number); % Küsze das Siganl auf den gewünschten Anteil und setze die Option 'all' für eine komplette Zerlegung
        com_x = x_values(1:l-net.nOutputUnits)';
        com_y = y_values(1:l-net.nOutputUnits)';
    otherwise
        error('Wrong samples or percentage typing.......')
end
       
l = length(com_y);
sample_length = net.nInputUnits; % setze die Länge der Stücke auf die Anzahl der Inputneuronen


%Berechnung der Sampleanzahl und die totale Länge der zusammengesetzten
%Sample
switch number_samples
    case 'all'
        
        number_samples = 0;
        total_length = 0;
        
        while l >= total_length && l >= sample_length
            number_samples = number_samples + 1;
            total_length = sample_length + (number_samples-1)*shift;
        end
        number_samples = number_samples-1;
        total_length = sample_length + (number_samples-1)*shift;
        
    otherwise
        
        total_length = sample_length + (number_samples-1)*shift;
  
end


% Fehlerfänger 
if (l < total_length || number_samples<=0)
            error('Total length exceeds siganl length or numbers of samples <= 0');
end


% Zerlegung des Signals
parts.x_values = cell(1,number_samples+1);
parts.y_values = cell(1,number_samples+1);
parts.signal_indices = cell(1,number_samples+1);

for j=1:number_samples
    para1       = j-1;
    para2       = shift*para1;
    start_index = para2+1;
    end_index   = para2+sample_length;
    
    parts.x_values{j} = com_x(start_index:end_index);
    parts.y_values{j} = com_y(start_index:end_index);
    parts.signal_indices{j} = [start_index,end_index];
end


% Generiere weitere Info-Parameter
parts.shift = shift;
parts.sample_length = sample_length;
parts.number_samples = number_samples;
parts.last_Index = end_index;
parts.Appendix_Indices = {[end_index+1:l+net.nOutputUnits]};
parts.x_values{end} = x_values(end_index+1:end_index+shift)';
parts.y_values{end} = y_values(end_index+1:end_index+shift)';
parts.signal_indices{end} = [end_index+1,end_index+shift];
 























% parts.Parts_length = net.nInputUnits;
% com_x_values = x_values(1:end-net.nOutputUnits)';
% com_y_values = y_values(1:end-net.nOutputUnits)';
% 
% len = length(com_x_values);
% 
% total_length = 0;
% number_parts = 0;

% while len >= total_length
%                
%             number_parts  = number_parts + 1;
%             total_length  = (shift)*(number_parts-1)+parts.Parts_length;
% end
% 
% number_parts = number_parts - 1;
% total_length  = (shift)*(number_parts-1)+parts.Parts_length;
% 
% parts.nParts = number_parts;
% parts.Shift  = shift;
% parts.AppendixValues = len-total_length;
% 
% 
% parts.x_values = cell(1,number_parts); 
% parts.y_values = cell(1,number_parts); 
% for j=1:number_parts
%         
%         para1 = j-1;
%         para2 = para1*shift;
%         
%         parts.x_values{j}       = com_x_values(para2+1:para2+parts.Parts_length);
%         parts.y_values{j}       = com_y_values(para2+1:para2+parts.Parts_length);
% %         parts.Samples.train_values{j}   = y_values(para2+parts.Sample_length+1:para2+parts.Sample_length+net.nOutputUnits);
%         
%         
%         
%     end
% 
% parts.lastSampleIndex = para2+parts.Parts_length;