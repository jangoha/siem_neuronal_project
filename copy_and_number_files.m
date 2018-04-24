function varargout = copy_and_number_files(folder,searchname, destinationfolder)

% methode zum suchen und kopieren von Matlab-Datein in einen Zielordner

strc = dir(folder);
nsubfolder = length(strc)-2;
subfoldernames = {strc(3:end).name};
mkdir(folder,destinationfolder);
searchname2 = ['\',searchname,'.mat'];

for j=1:nsubfolder
    
    helppath = [folder,'\',subfoldernames{j}];
    
    newfilename = sprintf([searchname,'%03d'],j);
    newfilename = [helppath,'\',newfilename,'.mat'];
    oldfilename = [helppath,searchname2];
    movefile(oldfilename,newfilename);
    
    copyfile(newfilename,[folder,'\',destinationfolder]);
    
    
end