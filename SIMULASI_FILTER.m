function varargout = SIMULASI_FILTER(varargin)
% SIMULASI_FILTER MATLAB code for SIMULASI_FILTER.fig
%      SIMULASI_FILTER, by itself, creates a new SIMULASI_FILTER or raises the existing
%      singleton*.
%
%      H = SIMULASI_FILTER returns the handle to a new SIMULASI_FILTER or the handle to
%      the existing singleton*.
%
%      SIMULASI_FILTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMULASI_FILTER.M with the given input arguments.
%
%      SIMULASI_FILTER('Property','Value',...) creates a new SIMULASI_FILTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SIMULASI_FILTER_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SIMULASI_FILTER_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SIMULASI_FILTER

% Last Modified by GUIDE v2.5 07-Apr-2022 14:19:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SIMULASI_FILTER_OpeningFcn, ...
                   'gui_OutputFcn',  @SIMULASI_FILTER_OutputFcn, ...
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


% --- Executes just before SIMULASI_FILTER is made visible.
function SIMULASI_FILTER_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SIMULASI_FILTER (see VARARGIN)

% Posisi GUI
movegui('center');

% Initial data
handles.image_warna = getappdata(0,"Citra_Warna");
handles.image_gray = getappdata(0,"Citra_Gray");
handles.image_noise = getappdata(0,"Citra_Noise");

handles.image_spaFilter = zeros(512,512);
handles.matriks_spaFilter = zeros(3);
handles.time_spaFilter = 0;
handles.psnr_spaFilter = 0;

handles.image_frekFilter = zeros(512,512);

axes(handles.axesCitraAsli);
imshow(handles.image_gray);

axes(handles.axesCitraNoise);
imshow(handles.image_noise);

axes(handles.axesSpaFilter);
imshow(handles.image_spaFilter);

axes(handles.axesFrekFilter);
imshow(handles.image_frekFilter);

% Choose default command line output for SIMULASI_FILTER
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
bg = axes('units', 'normalized', 'position', [0 0 1 1]);
wr = imread('Assets/bgsim.jpg');
imagesc(wr);
set(bg, 'handlevisibility', 'off', 'visible', 'off');

% UIWAIT makes SIMULASI_FILTER wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SIMULASI_FILTER_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
        
% --- Executes on button press in SpaProses_Button.
function SpaProses_Button_Callback(hObject, eventdata, handles)
% hObject    handle to SpaProses_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,"Citra_spaFilter", handles.image_spaFilter);
setappdata(0,"spaFilter", handles.matriks_spaFilter);
set(PROSES_SPASIAL,'visible','on');
PROSES_SPASIAL


% --- Executes on selection change in Spasial_Popup.
function Spasial_Popup_Callback(hObject, eventdata, handles)
% hObject    handle to Spasial_Popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Spasial_Popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Spasial_Popup
val_popup = get(hObject, 'Value');

switch val_popup
    case 1
        [matriks_filter, image_filter, filter_time, psnr_filter] = spaLowpass(handles.image_gray, handles.image_noise);
    case 2
        [matriks_filter, image_filter, filter_time, psnr_filter] = spaHighpass(handles.image_gray, handles.image_noise);
    case 3
        [matriks_filter, image_filter, filter_time, psnr_filter] = spaMedian(handles.image_gray, handles.image_noise);
    case 4
        [matriks_filter, image_filter, filter_time, psnr_filter] = spaDirectional(handles.image_gray, handles.image_noise);
    case 5
        [matriks_filter, image_filter, filter_time, psnr_filter] = spaLaplacian(handles.image_gray, handles.image_noise);
    case 6
        [matriks_filter, image_filter, filter_time, psnr_filter] = spaRoberts(handles.image_gray, handles.image_noise);
    case 7
        [matriks_filter, image_filter, filter_time, psnr_filter] = spaSobel(handles.image_gray, handles.image_noise);
    case 8
        [matriks_filter, image_filter, filter_time, psnr_filter] = spaPrewitt(handles.image_gray, handles.image_noise);
    case 9
        [matriks_filter, image_filter, filter_time, psnr_filter] = spaGaussian(handles.image_gray, handles.image_noise);
end

axes(handles.axesSpaFilter);
imshow(image_filter);
set(handles.spaPsnr_text, 'String', psnr_filter);
set(handles.spaTime_text, 'String', filter_time);

handles.matriks_spaFilter = matriks_filter;
handles.image_spaFilter = image_filter;
handles.time_spaFilter = filter_time;
handles.psnr_spaFilter = psnr_filter;

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Spasial_Popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Spasial_Popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in FrekuensiPopup.
function FrekuensiPopup_Callback(hObject, eventdata, handles)
% hObject    handle to FrekuensiPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FrekuensiPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FrekuensiPopup
val_popup = get(hObject, 'Value');
% 
switch val_popup
    case 1
        [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekIdeal_lp(handles.image_gray, handles.image_noise);
    case 2
        [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekButter_lp(handles.image_gray, handles.image_noise);
    case 3
        [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekGaussian_lp(handles.image_gray, handles.image_noise);
    case 4
        [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekIdeal_hp(handles.image_gray, handles.image_noise);
    case 5
        [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekButter_hp(handles.image_gray, handles.image_noise);
    case 6
        [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekGaussian_hp(handles.image_gray, handles.image_noise);
    case 7
        [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekSobel(handles.image_gray, handles.image_noise);
    case 8
        [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekLaplacian(handles.image_gray, handles.image_noise);
    case 9
        [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekPrewitt(handles.image_gray, handles.image_noise);
end
axes(handles.axesFrekFilter);
imshow(image_filter);
set(handles.frekPsnr_text, 'String', psnr_filter);
set(handles.frekTime_text, 'String', filter_time);
% 
handles.image_frekFilter = image_filter;
handles.time_frekFilter = filter_time;
handles.psnr_frekFilter = psnr_filter;
handles.filt_frekFilter = filt_spek;
handles.hasils_frekFilter = hasil_spek;
handles.u_frekFilter = U_frek;
handles.v_frekFilter = V_frek;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function FrekuensiPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FrekuensiPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in FrekProses_Button.
function FrekProses_Button_Callback(hObject, eventdata, handles)
% hObject    handle to FrekProses_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,"Citra_frekFilter", handles.image_frekFilter);
setappdata(0,"Filter_Spektrum", handles.filt_frekFilter);
setappdata(0,"Hasil_Spek", handles.hasils_frekFilter);
setappdata(0,"Nilai_U", handles.u_frekFilter);
setappdata(0,"Nilai_V", handles.v_frekFilter);
set(PROSES_FREKUENSI,'visible','on');
PROSES_FREKUENSI


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
main
