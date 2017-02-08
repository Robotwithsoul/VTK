function [ flag ] = save2mat( handles,name )

current_slice=handles.Change_slice_slider.Value;
path=handles.axes1.UserData.filepaths{current_slice};
% First to create the directory to save the selected DICOMs
[~,save_dir]=Create_dir(path);

if (exist([save_dir '\' name],'file')==0)

    handles.axes1;
    cc=round(ginput(4));
    info=dicominfo(path);
    ps=info.PixelSpacing(1);
    fine_corner=Corner_extraction(cc,handles.Change_slice_slider.UserData.CData,ps);
    [rotate_image,rotate_corner]=Rotate_Im(handles.Change_slice_slider.UserData.CData,fine_corner);
    %first we show the rotate results
    h_im=handles.Change_slice_slider.UserData;
    set(h_im,'CData',rotate_image);
    drawnow; hold on;
    h_s=scatter(rotate_corner(:,1),rotate_corner(:,2),'r');
    set(handles.reset_button,'UserData',h_s);
    %then we save the the dicom and corner
    %dicomwrite(uint16(rotate_image),[save_dir '\' save_file],info);
    %WriteCorner([save_dir '\' name '.txt'],fine_corner);   
    
    %we save the inforamtion in mat format
    % it's better to save the window level and  window width information
   wc=info.WindowCenter;
   ww=info.WindowWidth;
   ww_max=handles.Window_Width_slider.Max;
   wc_max=handles.Window_level_slider.Max;
    
    
    save([save_dir '\' name], 'rotate_image','rotate_corner','info','wc','ww'...
        ,'ww_max','wc_max');
    
    msgbox('文件已经保存')
else
    msgbox('文件存在，不要重复保存')
end

flag=1;


end

