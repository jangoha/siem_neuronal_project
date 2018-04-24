cd I:\1_MR\1_HQMR\R&D\SYS_APPL\TeamMitglieder\Werkstudenten\Ruben\GroundTruthCopy\1
parentfolder = 'I:\1_MR\1_HQMR\R&D\SYS_APPL\TeamMitglieder\Werkstudenten\Ruben\GroundTruthCopy';
mkdir (parentfolder, 'testfolder')

nfolders = length(dir);
a = cell(1,nfolders-3);

for j=3:nfolders-1
   
    aid = sprintf('%d',j-2);
    aid2 = [parentfolder,'\' ,aid,'\actualCurve.mat'];
    movefile(aid2,[parentfolder,'\' ,aid,'\actualCurve',aid,'.mat']);
    
    
end

