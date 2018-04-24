function setPath(folder,varargin)

% Fügt den in folder hinterlegten Pfad zu Path hinzu. Zusätzlich können
% alle weiteren Subfolder von folder ebenfalls hinzugefügt werden.
% setze -->> varargin = true

addpath(folder);

subFolderFlag = varargin{1};

% Wenn if-Schleife durchgeführt wird, werden alle subfolder und subsubFolder in folder zu path hinzugefügt 
if subFolderFlag
    d = dir(folder);
    isub = [d(:).isdir]; % gibt einen boolean-Vektor zu alle Verzeichnissen in d die Ordner sind
    subFolderNames = {d(isub).name}; % wähle alle Ordnernamen aus
    subFolderNames(ismember(subFolderNames,{'.','..'})) = []; % entferne . und .. Ordner aus der Liste falls diese vorhanden sind
    
    for k=length(subFolderNames):-1:1
       addingFolders{k}=[folder,'\',subFolderNames{k}]; % erzeuge Pfade zum hinzufügen, kein sprintf verwendet da \R in Pfaden zu Fehlern führt
       setPath(addingFolders{k},true); % kaskadiere Prozedere für jeden Subordner und füge diesen gleichzeitig zu Path hinzu
    end
    
    
end

