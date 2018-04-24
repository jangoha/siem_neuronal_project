function sets = generate_sets(folder, type,varargin)

% lädt Groundtruth daten aus dem Folder und speiechert sie einer nx1
% Structur. Mit varargin kann ein bestimmtes Set oder mehrere Sets
% ausgewählt werden (Bsp.: varargin = [1] oder [1,5,88])

datas = dir([folder,'\*.mat']);
nSets = length(datas);

% Switch wird benötigt, da load aus den Daten ein Struc macht. Gewünschter
% Datensatz bei rasp ist Satz2(cha2) (gefilterte Daten aus dem Rasp-Sensor)
switch type
    case 'rasp', g=2;
    case 'normal', g=1;
end

% Spezifizert die genauen Datensätze die geladen werden sollen mit
% inputVektor
if (numel (varargin)==0)
    inputVektor = 1:nSets;
else
    inputVektor = varargin{1};
end


tic
for j = 1:length(inputVektor)  
    
    dummy = load([folder,'\',datas(inputVektor(j)).name]);
    dummynames = fieldnames(dummy);
    
    %inp = (getfield(dummy, dummynames{g}))'; %  wofür getfield? (janko)
%     inp = (dummy.updatedPoints)'; % wa
    A = struct2cell(dummy);
    inp1 = cat(2,A{:});
    [M,N] = size(inp1)
    if (M > N)
        inp = (inp1)';
    else 
        inp = inp1;
    end
    
    sets(j).y_values = inp(2:end); % hier wird der erste Wert verworfen, da dieser Startwert von der Messung verfälscht und zu klein ist.
    sets(j).x_values = linspace(0, length (sets(j).y_values) * 2.5 / 1000, length(sets(j).y_values)); % erzeuge passende Zeitwerte der Groundtruthdaten als x-Werte
    
    
end
toc
% sets = sets(inputVektor); % wähle aus der erzeugten Structur die gewählten Sets aus, da leerstellen gefüllt werden. [2,4] erzeugt erst einmal eine 4x1 Structur..

% if (numel (varargin)==0)
%     inputVektor = 1:nSets;
% else
%     inputVektor = varargin{1};
% end
%     
% for j=inputVektor
%     
%     dummy = load([folder,'\',datas(j).name]);
%     dummynames = fieldnames(dummy);
%     
%     inp = getfield(dummy, dummynames{g});
%     inp = inp(:)';
%     sets(j).y_values = inp(2:end); % hier wird der erste Wert verworfen, da dieser Startwert von der Messung verfälscht und zu klein ist.
%     
%     n = length(sets(j).y_values);
%     
%     sets(j).x_values = linspace(0,n*0.25/1000,n);
%     
%     
% end
% 
% sets = sets(inputVektor);