 function [train_samples,varargout] = generate_train_samples(net, x_values,y_values,samples_or_percentage,config_number)

% Generiert aus den eingegebenen x und y Daten eine beliebige oder maximale
% Anzahl an Trainingssätzen, welche auf das zu testende Netz abgestimmt sind.
% Mit 'all' als "Config_number" wird das Maximum an Trainingssätzen
% erzeugt.

x_values = x_values(:)'; % Werte werden als Zeilenvektor festgesetzt
y_values = y_values(:)';

p = net.nOutputUnits;
train_samples = dismantle_signal(net, x_values,y_values,samples_or_percentage,config_number,p); % Zerlege Signal

% Erzeuge zerlegtes Siganl als möglichen Output
varargout = {train_samples};

number_samples = train_samples.number_samples;


% Erzeuge Trainingswerte
train_samples.train_x_values = cell(1,number_samples);
train_samples.train_y_values = cell(1,number_samples);
train_samples.train_indices  = cell(1,number_samples);

for j=1:number_samples
    
    start_index = train_samples.signal_indices{j}(2)+1;
    end_index   = start_index+net.nOutputUnits-1;
    
    train_samples.train_x_values{j} = x_values(start_index:end_index)';
    train_samples.train_y_values{j} = y_values(start_index:end_index)';
    train_samples.train_indices{j}  = [start_index,end_index];
    
end

% Update Netzstruktur für Parameter der Trainingsample
train_samples = renameStructField(train_samples,'sample_length','feed_sample_length');
train_samples = renameStructField(train_samples,'signal_indices','feed_signal_indices');
train_samples = renameStructField(train_samples,'last_Index','feed_last_Index');

train_samples = renameStructField(train_samples,'number_samples','nTrainSamples');

train_samples.train_sample_length = length(train_samples.train_y_values{1});
train_samples.last_train_Index = end_index;
train_samples.percentage = train_samples.last_train_Index/length(y_values);


















% com_x_values=x_values(1:end-net.nOutputUnits)';
% com_y_values=y_values(1:end-net.nOutputUnits)';
% 
% len = length(com_y_values);
% 
% args=varargin;
% number_samples = args{1};
% shift_step = args{2};
% 
% 
% train_samples.Sample_length = net.nInputUnits;
% train_samples.nSamples = number_samples;
% train_samples.ShiftStep = shift_step;
% 
% 
% switch args{1}
%     case 'all'
%         number_samples = 1;
%         while len >= (shift_step)*(number_samples-1)+train_samples.Sample_length
%                
%             number_samples = number_samples + 1;
%            
%         end
%             number_samples = number_samples - 1;
%             
%     otherwise
%             number_samples = args{1};
% end
% 
% total_training_length = (shift_step)*(train_samples.nSamples-1)+train_samples.Sample_length;
% train_samples.AppendixValues = len-total_training_length;
% 
% 
% train_samples.Samples.x_values      = cell(1,number_samples);
% train_samples.Samples.y_values      = cell(1,number_samples);
% train_samples.Samples.train_values  = cell(1,number_samples);
% 
% 
% if len >= (shift_step)*(train_samples.nSamples-1)+train_samples.Sample_length && number_samples > 0
%     
%     for j=1:number_samples
%         
%         para1 = j-1;
%         para2 = para1*shift_step;
%         
%         train_samples.Samples.x_values{j}       = com_x_values(para2+1:para2+train_samples.Sample_length);
%         train_samples.Samples.y_values{j}       = com_y_values(para2+1:para2+train_samples.Sample_length);
%         train_samples.Samples.train_values{j}   = y_values(para2+train_samples.Sample_length+1:para2+train_samples.Sample_length+net.nOutputUnits);
%         
%         
%         
%     end
%     
%     train_samples.Aids.lastSampleIndex = para2+train_samples.Sample_length;
% else
%     
%     error(['Total length of sampels exceed inputs. Choose less Samples or smaller shift_step.', ... 
%         'Or Samplenumber is 0. Number of Samples:', num2str(number_samples)])
%     
% end
