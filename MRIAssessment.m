function varargout = MRIAssessment(varargin)
% MRIASSESSMENT MATLAB code for MRIAssessment.fig
% This GUI is mainly for MRI Assessment

% Last Modified by GUIDE v2.5 30-Nov-2016 09:25:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MRIAssessment_OpeningFcn, ...
                   'gui_OutputFcn',  @MRIAssessment_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MRIAssessment is made visible.
function MRIAssessment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MRIAssessment (see VARARGIN)

% Choose default command line output for MRIAssessment
handles.output = hObject;
set(handles.axes1,'XTick',[])
set(handles.axes1,'YTick',[])
set(handles.op_deformed_button,'Enable','off');
set(handles.op_lowR_button,'Enable','off');
set(handles.op_unifomity_button,'Enable','off');
set(handles.op_highr_button,'Enable','off');
%ax=handles.axes1;
%set(ax,'ButtonDownFcn',@(h,e)(disp(get(h,'currentpoint'))))
% Update handles structure
guidata(hObject, handles);


% UIWAIT makes MRIAssessment wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MRIAssessment_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Save_uniformity_button.
function Save_uniformity_button_Callback(hObject, eventdata, handles)
% hObject    handle to Save_uniformity_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
save2mat(handles,'uniformity_slice.mat')





% --- Executes on button press in Save_LowR_button.
function Save_LowR_button_Callback(hObject, eventdata, handles)
% hObject    handle to Save_LowR_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
save2mat(handles,'low_contrast_slice.mat');

% --- Executes on button press in Save_highR_button.
function Save_highR_button_Callback(hObject, eventdata, handles)
% hObject    handle to Save_highR_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
save2mat(handles,'high_contrast_slice.mat');

% --- Executes on button press in Save_deformed_button.
function Save_deformed_button_Callback(hObject, eventdata, handles)
% hObject    handle to Save_deformed_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
save2mat(handles,'deformed_slice.mat');

% --- Executes on slider movement.
function Change_slice_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Change_slice_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
H_Im=get(handles.Change_slice_slider,'UserData');
Max_num=size(handles.axes1.UserData.Image,3);
Image_Num=round(handles.Change_slice_slider.Value);
text=[num2str(Image_Num) '/' num2str(Max_num)];
set(handles.slice_num_text,'String',text)
set(H_Im,'CData',handles.axes1.UserData.Image(:,:,Image_Num));
set(H_Im,'UserData',handles.axes1.UserData.Image(:,:,Image_Num));
drawnow;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Change_slice_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Change_slice_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);    
end

% add a continuous value change listener



% --------------------------------------------------------------------
% This function is to load single or series DICOM
function LoadDICOM_Callback(hObject, eventdata, handles)
% hObject    handle to LoadDICOM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 1.First we need to load DICOM files.

[DICOM_Image,ImagePaths]=CT_DICOMread('on');
if(DICOM_Image==false)
    % In case that the user open the dialog but choose no file.
    return;
end

% 2. To distinguish 2 cases (single DICOM and multiple DICOMs)
if (ismatrix(DICOM_Image))
    show_Image=DICOM_Image;
    % set the image slice change slider
    set(handles.Change_slice_slider,'Value',1);
    set(handles.Change_slice_slider,'Enable','off')
    set(handles.slice_num_text,'String','1/1')
    
else
    show_Image=DICOM_Image(:,:,1);
    num_im=size(DICOM_Image,3);
    % make sure the slider is enabled.
    set(handles.Change_slice_slider,'Enable','on')
    set(handles.Change_slice_slider,'Value',1);
    set(handles.Change_slice_slider,'Min',1);
    set(handles.Change_slice_slider,'Max',num_im);
    set(handles.Change_slice_slider,'SliderStep',[1/(num_im-1) 10/(num_im-1)])
    Max_num=size(DICOM_Image,3);
    text=['1/' num2str(Max_num)];
    set(handles.slice_num_text,'String',text)
    
end

axes(handles.axes1);
info=dicominfo(ImagePaths{1});
% set the window level and center min and max
Im_min=min(DICOM_Image(:));
Im_max=max(DICOM_Image(:));

wc=info.WindowCenter;
ww=info.WindowWidth;
if (Im_max<ww)
    Im_max=ww;
end
set(handles.Window_Width_slider,'Value',1);
set(handles.Window_Width_slider,'Min',1);
set(handles.Window_Width_slider,'Max',Im_max);
set(handles.Window_Width_slider,'SliderStep',[1/Im_max 10/Im_max]);

set(handles.Window_level_slider,'Min',Im_min);
set(handles.Window_level_slider,'Max',Im_max);
set(handles.Window_level_slider,'SliderStep',[1/Im_max 10/Im_max]);


text1=['´°¿í£º' num2str(ww)];
text2=['´°Î»£º' num2str(wc)];
set(handles.Window_Width_slider,'Value',ww);
set(handles.Window_level_slider,'Value',wc);
set(handles.window_width_text,'String',text1);
set(handles.window_level_text,'String',text2);


% display in a default window and center

axes(handles.axes1);
h_IM=imshow(show_Image,[wc-ww/2 wc+ww/2]);
set(handles.Change_slice_slider,'UserData',h_IM);
Imagedata.Image=DICOM_Image;
Imagedata.filepaths=ImagePaths;
set(handles.axes1,'UserData',Imagedata);


%====



% set callback for imshow 
set(h_IM,'ButtonDownFcn',@ImageClick_Callback);





   


% --------------------------------------------------------------------
function Operation_Callback(hObject, eventdata, handles)
% hObject    handle to Operation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName]=uigetfile({'*.mat'},'Pick DICOM files','MultiSelect','off');
if isequal(PathName,0)
    return;
end

load([PathName FileName]);

if(~isempty(strfind(FileName,'deformed')))
    set(handles.op_deformed_button,'Enable','on');
    set(handles.op_lowR_button,'Enable','off');
    set(handles.op_unifomity_button,'Enable','off');
    set(handles.op_highr_button,'Enable','off');
end
if(~isempty(strfind(FileName,'high')))
    set(handles.op_deformed_button,'Enable','off');
    set(handles.op_lowR_button,'Enable','off');
    set(handles.op_unifomity_button,'Enable','off');
    set(handles.op_highr_button,'Enable','on');
end
if(~isempty(strfind(FileName,'low')))
    set(handles.op_deformed_button,'Enable','off');
    set(handles.op_lowR_button,'Enable','on');
    set(handles.op_unifomity_button,'Enable','off');
    set(handles.op_highr_button,'Enable','off');
end
if(~isempty(strfind(FileName,'uniformity')))
    set(handles.op_deformed_button,'Enable','off');
    set(handles.op_lowR_button,'Enable','off');
    set(handles.op_unifomity_button,'Enable','on');
    set(handles.op_highr_button,'Enable','off');
end




% here we load the information that was saved before. to make it clear, I made 
% a list;
% 'rotate_image','rotate_corner','info','wc','ww' ,'ww_max','wc_max'
set(handles.Change_slice_slider,'Value',1);
set(handles.Change_slice_slider,'Enable','off')
set(handles.slice_num_text,'String','1/1')

set(handles.Window_Width_slider,'Value',1);
set(handles.Window_Width_slider,'Min',1);
set(handles.Window_Width_slider,'Max',ww_max);
set(handles.Window_Width_slider,'SliderStep',[1/ww_max 10/ww_max]);

set(handles.Window_level_slider,'Min',0);
set(handles.Window_level_slider,'Max',wc_max);
set(handles.Window_level_slider,'SliderStep',[1/wc_max 10/wc_max]);


text1=['´°¿í£º' num2str(ww)];
text2=['´°Î»£º' num2str(wc)];
set(handles.Window_Width_slider,'Value',ww);
set(handles.Window_level_slider,'Value',wc);
set(handles.window_width_text,'String',text1);
set(handles.window_level_text,'String',text2);

axes(handles.axes1);
h_IM=imshow(rotate_image,[wc-ww/2 wc+ww/2]);
set(handles.Change_slice_slider,'UserData',h_IM);

op_data.Image=rotate_image;
op_data.corner=rotate_corner;
op_data.Ps=info.PixelSpacing(1);
op_data.path=PathName;

set(handles.axes1,'UserData',op_data);

% set callback for imshow 
set(h_IM,'ButtonDownFcn',@ImageClick_Callback);

% call back funciton for imshow
function ImageClick_Callback ( objectHandle , eventData )
   axesHandle  = get(objectHandle,'Parent'); 
   coordinates = get(axesHandle,'CurrentPoint'); 
   Coor = round(coordinates(1,1:2));
   mrivalue=objectHandle.CData(Coor(2),Coor(1));
   text=['(x' num2str(Coor(1)) ' ,y' num2str(Coor(2)) ' ,' num2str(mrivalue) ')'];
   title(text);
   %set(handles.MRIvalue_text,'String',text)
   %// then here you can use coordinates as you want ...


% --- Executes on slider movement.
function Window_Width_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Window_Width_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ww_value=handles.Window_Width_slider.Value;
wc_value=handles.Window_level_slider.Value;
low=wc_value-ww_value/2;
high=wc_value+ww_value/2;

text2=['´°Î»£º' num2str(round(ww_value))];
set(handles.window_width_text,'String',text2);
set(handles.axes1,'CLim',[low high]);
set(handles.axes1,'CLim',[low high]);
drawnow;

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Window_Width_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Window_Width_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Window_level_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Window_level_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ww_value=handles.Window_Width_slider.Value;
wc_value=handles.Window_level_slider.Value;
low=wc_value-ww_value/2;
high=wc_value+ww_value/2;


text2=['´°Î»£º' num2str(round(wc_value))];
set(handles.window_level_text,'String',text2);
set(handles.axes1,'CLim',[low high]);
drawnow;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Window_level_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Window_level_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in reset_button.
function reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h_s=handles.reset_button.UserData;
if(isempty(h_s))
    return;
else
    delete(h_s);
    drawnow
end


% --- Executes on button press in op_unifomity_button.
function op_unifomity_button_Callback(hObject, eventdata, handles)
% hObject    handle to op_unifomity_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

rotate_image=handles.axes1.UserData.Image;
rotate_corner=handles.axes1.UserData.corner;
Ps=handles.axes1.UserData.Ps;
op_uniformity(handles,rotate_corner,rotate_image,Ps);

% --- Executes on button press in op_lowR_button.
function op_lowR_button_Callback(hObject, eventdata, handles)
% hObject    handle to op_lowR_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rotate_image=handles.axes1.UserData.Image;
rotate_corner=handles.axes1.UserData.corner;
Ps=handles.axes1.UserData.Ps;
op_low_contrast(handles,rotate_corner,rotate_image,Ps);

% --- Executes on button press in op_highr_button.
function op_highr_button_Callback(hObject, eventdata, handles)
% hObject    handle to op_highr_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rotate_image=handles.axes1.UserData.Image;
rotate_corner=handles.axes1.UserData.corner;
Ps=handles.axes1.UserData.Ps;
op_high_contrast(handles,rotate_corner,rotate_image,Ps);


% --- Executes on button press in op_deformed_button.
function op_deformed_button_Callback(hObject, eventdata, handles)
% hObject    handle to op_deformed_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rotate_image=handles.axes1.UserData.Image;
rotate_corner=handles.axes1.UserData.corner;
Ps=handles.axes1.UserData.Ps;
op_deformed(handles,rotate_corner,rotate_image,Ps);



function threshhod_edit_Callback(hObject, eventdata, handles)
% hObject    handle to threshhod_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of threshhod_edit as text
%        str2double(get(hObject,'String')) returns contents of threshhod_edit as a double


% --- Executes during object creation, after setting all properties.
function threshhod_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threshhod_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
