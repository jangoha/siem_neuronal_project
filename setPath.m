function setPath(folder,varargin)

% F�gt den in folder hinterlegten Pfad zu Path hinzu. Zus�tzlich k�nnen
% alle weiteren Subfolder von folder ebenfalls hinzugef�gt werden.
% setze -->> varargin = true

addpath(folder);

subFolderFlag = varargin{1};

% Wenn if-Schleife durchgef�hrt wird, werden alle subfolder und subsubFolder in folder zu path hinzugef�gt 
if subFolderFlag
    d = dir(folder);
    isub = [d(:).isdir]; % gibt einen boolean-Vektor zu alle Verzeichnissen in d die Ordner sind
    subFolderNames = {d(isub).name}; % w�hle alle Ordnernamen aus
    subFolderNames(ismember(subFolderNames,{'.','..'})) = []; % entferne . und .. Ordner aus der Liste falls diese vorhanden sind
    
    for k=length(subFolderNames):-1:1
       addingFolders{k}=[folder,'\',subFolderNames{k}]; % erzeuge Pfade zum hinzuf�gen, kein sprintf verwendet da \R in Pfaden zu Fehlern f�hrt
       setPath(addingFolders{k},true); % kaskadiere Prozedere f�r jeden Subordner und f�ge diesen gleichzeitig zu Path hinzu
    end
    
    
end

