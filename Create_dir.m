function [ flag,savedir] = Create_dir( path )
%  This function is to examine the DICOM file dir and find if
%  selectedDICOM dir is created;
%  if the selectedDICOM is created , flag = 0;
%  if there is no  selectedDICOM, flag =1; and it will be created
% 1. first we have to find the directory contain dicom files
temp=strfind(path,'\');
Num=max(temp);
dirname=path(1:Num-1);
savedir=[dirname '\selectedDICOM']; 
if (exist(savedir,'dir')==7)
    flag=0;
    
else
    flag=1;
    mkdir(savedir);
end

end

