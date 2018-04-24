% Skript um daten automatisch umzubenennen und in Zielordner zu kopieren... Musste nur einmal angewandt werden 


file = 'I:\1_MR\1_HQMR\R&D\SYS_APPL\TeamMitglieder\Werkstudenten\Ruben\RespatoryFiles\copyTrigger';
 
 listing = dir(file);
 destination = listing(end);
 destinPath = [file,'\',destination.name];
 listing  = listing(3:end-1);
 
 for k=1:length(listing)
    
     source1 = [file,'\',listing(k).name];
     cd(source1);
     newName = sprintf('trigger%03d.mat',str2num(listing(k).name));
     movefile('actualCurve.mat',newName);
     source2 = [source1,'\',newName];
     copyfile(source2,destinPath);
     
 end