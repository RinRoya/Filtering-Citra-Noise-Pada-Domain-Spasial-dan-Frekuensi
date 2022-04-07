function varargout = main(varargin)
% main MATLAB code for main.fig
%      main, by itself, creates a new main or raises the existing
%      singleton*.
%
%      H = main returns the handle to a new main or the handle to
%      the existing singleton*.
%
%      main('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in main.M with the given input arguments.
%
%      main('Property','Value',...) creates a new main or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 07-Apr-2022 14:10:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Posisi GUI
movegui('center');

% Initial data
handles.image_warna = uint8(zeros(512,512,3));
handles.image_gray = uint8(zeros(512,512));
handles.image_noise = uint8(zeros(512,512));

axes(handles.axesCitraAsli);
imshow(handles.image_warna);
axes(handles.axesCitraNoise);
imshow(handles.image_noise);

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
bg = axes('units', 'normalized', 'position', [0 0 1 1]);
wr = imread('Assets/bgpcd2.jpg');
imagesc(wr);
set(bg, 'handlevisibility', 'off', 'visible', 'off');

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in AmbilGambar_PushButton.
function AmbilGambar_PushButton_Callback(hObject, eventdata, handles)
% hObject    handle to AmbilGambar_PushButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file_name, path_name] = uigetfile({'*.png';'*.jpg'},'Ambil Gambar');
if ~isequal (file_name,0)
    image_data = imread(fullfile(path_name, file_name));
    image_data_gray = rgb2gray(image_data);
    handles.image_warna = image_data;
    handles.image_gray = image_data_gray;
    handles.image_noise = imnoise(image_data_gray,'gaussian');
    guidata(hObject, handles);
    
    axes(handles.axesCitraAsli);
    imshow(handles.image_gray);
    
    axes(handles.axesCitraNoise);
    imshow(handles.image_noise);
else
    return
end


% --- Executes on selection change in Noise_PopUp.
function Noise_PopUp_Callback(hObject, eventdata, handles)
% hObject    handle to Noise_PopUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Noise_PopUp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Noise_PopUp

val_popup = get(hObject, 'Value');

switch val_popup
    case 1
        im_noise = imnoise(handles.image_gray,'gaussian');
    case 2
        im_noise = imnoise(handles.image_gray,'poisson');
    case 3
        im_noise = imnoise(handles.image_gray,'salt & pepper');
    case 4
        im_noise = imnoise(handles.image_gray,'speckle');
end
axes(handles.axesCitraNoise);
imshow(im_noise);

handles.image_noise = im_noise;
guidata(hObject, handles);    
        
% --- Executes during object creation, after setting all properties.
function Noise_PopUp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Noise_PopUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Warna_CheckBox.
function Warna_CheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to Warna_CheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Warna_CheckBox

val_checkbox = get(hObject,'Value');
axes(handles.axesCitraAsli);
imshow(handles.image_gray);
if val_checkbox==1    
    imshow(handles.image_warna);
end


% --- Executes on button press in Simulasi_Button.
function Simulasi_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Simulasi_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'Citra_Warna', handles.image_warna);
setappdata(0,'Citra_Gray', handles.image_gray);
setappdata(0,'Citra_Noise', handles.image_noise);
if handles.image_warna == zeros(size(handles.image_warna))
    warndlg('Belum memilih gambar','Error')
else
    SIMULASI_FILTER
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.image_warna == zeros(size(handles.image_warna))
    warndlg('Belum memilih gambar','Error')
else
    KOMPARASI_FILTER
end
