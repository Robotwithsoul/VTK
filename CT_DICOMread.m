function [Image,Filepaths] = CT_DICOMread(readtype)
% this is a funciton to open one or several Dicom files
% if several DICOM files are opened then they will be sorted according the
% InstanceNumber
% return the Dicom Images and their paths
% if the user didn't choose anything, image will be assigned false(bool)

% Here readtype is to distinguish single or multiple dicom file read 
% single means user can only choose one file.
% read type on-> multiple read; off-> single dicom read

% if multiple Images are choosed, Image will have three dimensions;
% otherwise Image has two dimensions.

% Filpaths are in the format of cell


[FileNames,PathName]=uigetfile({'*.*'},'Pick DICOM files','MultiSelect',readtype);

% to tell whether the user has selected the files
if ~isequal(PathName,0)
    FN_Class=class(FileNames);
    if isequal(FN_Class,'cell')
        
         % We get all the file paths    
         filepaths=cellfun(@(x)fullfile(PathName, x),FileNames,'uni',0);
         % Ensure that they are actually DICOM files and remove the ones that aren't
         notdicom=~cellfun(@isdicom,filepaths);
         filepaths(notdicom)=[];
         % Now sort these by the instance number
         infos=cellfun(@dicominfo,filepaths);
         [~,inds]=sort([infos.InstanceNumber]);
         infos=infos(inds);
         %infos=struct2cell(infos);
         
         % infos(sorted), filepaths.
         File_Num=size(FileNames,2);
         Loaded_Image=zeros(infos(1).Rows,infos(1).Columns,File_Num);
         
         if(isfield(infos(1),'RescaleSlope'))
             a_a=infos(1).RescaleSlope;
             a_b=infos(1).RescaleIntercept;
             for File_x=1:File_Num

                 Loaded_Image(:,:,File_x)=double(dicomread(infos(File_x)))*a_a+a_b;
             end
         else
             
             for File_x=1:File_Num                 
                 Loaded_Image(:,:,File_x)=double(dicomread(infos(File_x)));
             end
                                          
         end
      


        % output the iamge, Path ,Files
        Image=Loaded_Image;
        Filepaths=filepaths;
    else
        
        filepath=[PathName,FileNames];
        info=dicominfo(filepath);
        
        if(isfield(info,'RescaleSlope'))
            a_a=info.RescaleSlope;
            a_b=info.RescaleIntercept;
            
            Image=double(dicomread(info))*a_a+a_b;
        else
            Image=double(dicomread(info));
            
        end
        Filepaths={filepath};
       
    end
    
else
    
    Image=false;
    Filepaths=[];
    
end

end

