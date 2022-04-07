function varargout = KOMPARASI_FILTER(varargin)
% KOMPARASI_FILTER MATLAB code for KOMPARASI_FILTER.fig
%      KOMPARASI_FILTER, by itself, creates a new KOMPARASI_FILTER or raises the existing
%      singleton*.
%
%      H = KOMPARASI_FILTER returns the handle to a new KOMPARASI_FILTER or the handle to
%      the existing singleton*.
%
%      KOMPARASI_FILTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KOMPARASI_FILTER.M with the given input arguments.
%
%      KOMPARASI_FILTER('Property','Value',...) creates a new KOMPARASI_FILTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before KOMPARASI_FILTER_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to KOMPARASI_FILTER_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help KOMPARASI_FILTER

% Last Modified by GUIDE v2.5 26-Dec-2021 14:36:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @KOMPARASI_FILTER_OpeningFcn, ...
                   'gui_OutputFcn',  @KOMPARASI_FILTER_OutputFcn, ...
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


% --- Executes just before KOMPARASI_FILTER is made visible.
function KOMPARASI_FILTER_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to KOMPARASI_FILTER (see VARARGIN)

% Posisi GUI
movegui('center');

% Initial data
handles.image_warna = getappdata(0,"Citra_Warna");
handles.image_gray = getappdata(0,"Citra_Gray");
handles.image_noise = getappdata(0,"Citra_Noise");

spa_filName = categorical(["Low-pass" "High-pass" "Median" "Directional",...
                            "Laplacian" "Roberts" "Sobel" "Prewitt" "Gaussian"]);
handles.name_spaFilter = reordercats(spa_filName, cellstr(spa_filName));

frek_filName = categorical(["Ideal LP" "Buterworth LP" "Gaussian LP",...
                            "Ideal HP" "Buterworth HP" "Gaussian HP",...
                            "Sobel" "Prewitt" "Laplacian"]);
handles.name_frekFilter = reordercats(frek_filName, cellstr(frek_filName));

handles.psnr_spaFilter = zeros(1,9);
handles.time_spaFilter = zeros(1,9);
handles.psnr_frekFilter = zeros(1,6);
handles.time_frekFilter = zeros(1,6);

set(handles.spa_button,'Value', 1);
set(handles.frek_button,'Value', 0);

set(handles.spa_panel, 'Visible', 'on');
set(handles.frek_panel, 'Visible', 'off');

% Choose default command line output for KOMPARASI_FILTER
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
bg = axes('units', 'normalized', 'position', [0 0 1 1]);
wr = imread('Assets/bggrad.jpg');
imagesc(wr);
set(bg, 'handlevisibility', 'off', 'visible', 'off');
% UIWAIT makes KOMPARASI_FILTER wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = KOMPARASI_FILTER_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in spa_button.
function spa_button_Callback(hObject, eventdata, handles)
% hObject    handle to spa_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spa_button
spa_val = get(hObject, 'Value');
if spa_val==1
    set(handles.frek_button, 'Value', 0);
    set(handles.spa_panel, 'Visible', 'on');
    set(handles.frek_panel, 'Visible', 'off');
    
    ResetSpasial_Callback(hObject, eventdata, handles)
end

guidata(hObject, handles);

% --- Executes on button press in frek_button.
function frek_button_Callback(hObject, eventdata, handles)
% hObject    handle to frek_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of frek_button
frek_val = get(hObject, 'Value');
if frek_val==1
    set(handles.spa_button, 'Value', 0);
    set(handles.spa_panel, 'Visible', 'off');
    set(handles.frek_panel, 'Visible', 'on');
    
    ResetFrekuensi_Callback(hObject, eventdata, handles)
end

guidata(hObject, handles);

% --- Executes on button press in TampilkanSpasial.
function TampilkanSpasial_Callback(hObject, eventdata, handles)
% hObject    handle to TampilkanSpasial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cb1 = get(handles.spa_cb1, 'Value');
cb2 = get(handles.spa_cb2, 'Value');
cb3 = get(handles.spa_cb3, 'Value');
cb4 = get(handles.spa_cb4, 'Value');
cb5 = get(handles.spa_cb5, 'Value');
cb6 = get(handles.spa_cb6, 'Value');
cb7 = get(handles.spa_cb7, 'Value');
cb8 = get(handles.spa_cb8, 'Value');
cb9 = get(handles.spa_cb9, 'Value');

arr_time = handles.time_spaFilter;
arr_psnr = handles.psnr_spaFilter;
arr_time_text = ["" "" "" "" "" "" "" "" ""];
arr_psnr_text = ["" "" "" "" "" "" "" "" ""];

switch cb1
    case 0
        arr_time(1) = 0;
        arr_psnr(1) = 0;
        arr_time_text(1) = "";
        arr_psnr_text(1) = "";
    case 1
        [matriks_filter, image_filter, filter_time, psnr_filter] = spaLowpass(handles.image_gray, handles.image_noise);
        arr_time(1) = filter_time;
        arr_psnr(1) = psnr_filter;
        arr_time_text(1) = string(round(arr_time(1),4));
        arr_psnr_text(1) = string(round(arr_psnr(1),2));
end

switch cb2
    case 0
        arr_time(2) = 0;
        arr_psnr(2) = 0;
        arr_time_text(2) = "";
        arr_psnr_text(2) = "";
    case 1
        [matriks_filter, image_filter, filter_time, psnr_filter] = spaHighpass(handles.image_gray, handles.image_noise);
        arr_time(2) = filter_time;
        arr_psnr(2) = psnr_filter;
        arr_time_text(2) = string(round(arr_time(2),4));
        arr_psnr_text(2) = string(round(arr_psnr(2),2));
end

switch cb3
    case 0
        arr_time(3) = 0;
        arr_psnr(3) = 0;
        arr_time_text(3) = "";
        arr_psnr_text(3) = "";
    case 1
        [matriks_filter, image_filter, filter_time, psnr_filter] = spaMedian(handles.image_gray, handles.image_noise);
        arr_time(3) = filter_time;
        arr_psnr(3) = psnr_filter;
        arr_time_text(3) = string(round(arr_time(3),4));
        arr_psnr_text(3) = string(round(arr_psnr(3),2));
end

switch cb4
    case 0
        arr_time(4) = 0;
        arr_psnr(4) = 0;
        arr_time_text(4) = "";
        arr_psnr_text(4) = "";
    case 1
        [matriks_filter, image_filter, filter_time, psnr_filter] = spaDirectional(handles.image_gray, handles.image_noise);
        arr_time(4) = filter_time;
        arr_psnr(4) = psnr_filter;
        arr_time_text(4) = string(round(arr_time(4),4));
        arr_psnr_text(4) = string(round(arr_psnr(4),2));
end

switch cb5
    case 0
        arr_time(5) = 0;
        arr_psnr(5) = 0;
        arr_time_text(5) = "";
        arr_psnr_text(5) = "";
    case 1
        [matriks_filter, image_filter, filter_time, psnr_filter] = spaLaplacian(handles.image_gray, handles.image_noise);
        arr_time(5) = filter_time;
        arr_psnr(5) = psnr_filter;
        arr_time_text(5) = string(round(arr_time(5),4));
        arr_psnr_text(5) = string(round(arr_psnr(5),2));
end

switch cb6
    case 0
        arr_time(6) = 0;
        arr_psnr(6) = 0;
        arr_time_text(6) = "";
        arr_psnr_text(6) = "";
    case 1
        [matriks_filter, image_filter, filter_time, psnr_filter] = spaRoberts(handles.image_gray, handles.image_noise);
        arr_time(6) = filter_time;
        arr_psnr(6) = psnr_filter;
        arr_time_text(6) = string(round(arr_time(6),4));
        arr_psnr_text(6) = string(round(arr_psnr(6),2));
end

switch cb7
    case 0
        arr_time(7) = 0;
        arr_psnr(7) = 0;
        arr_time_text(7) = "";
        arr_psnr_text(7) = "";
    case 1
        [matriks_filter, image_filter, filter_time, psnr_filter] = spaSobel(handles.image_gray, handles.image_noise);
        arr_time(7) = filter_time;
        arr_psnr(7) = psnr_filter;
        arr_time_text(7) = string(round(arr_time(7),4));
        arr_psnr_text(7) = string(round(arr_psnr(7),2));
end

switch cb8
    case 0
        arr_time(8) = 0;
        arr_psnr(8) = 0;
        arr_time_text(8) = "";
        arr_psnr_text(8) = "";
    case 1
        [matriks_filter, image_filter, filter_time, psnr_filter] = spaPrewitt(handles.image_gray, handles.image_noise);
        arr_time(8) = filter_time;
        arr_psnr(8) = psnr_filter;
        arr_time_text(8) = string(round(arr_time(8),4));
        arr_psnr_text(8) = string(round(arr_psnr(8),2));
end

switch cb9
    case 0
        arr_time(9) = 0;
        arr_psnr(9) = 0;
        arr_time_text(9) = "";
        arr_psnr_text(9) = "";
    case 1
        [matriks_filter, image_filter, filter_time, psnr_filter] = spaGaussian(handles.image_gray, handles.image_noise);
        arr_time(9) = filter_time;
        arr_psnr(9) = psnr_filter;
        arr_time_text(9) = string(round(arr_time(9),4));
        arr_psnr_text(9) = string(round(arr_psnr(9),2));
end

handles.psnr_spaFilter = arr_psnr;
handles.time_spaFilter = arr_time;
guidata(hObject, handles);

axes(handles.axes1);
bar(handles.name_spaFilter, handles.psnr_spaFilter);
ylim([0, max(arr_psnr+8)]);
text((1:length(arr_psnr)),arr_psnr, arr_psnr_text,'vert','bottom','horiz','center'); 
set(handles.axes1, 'XColor', 'white');
set(handles.axes1, 'YColor', 'none');
grid on;

axes(handles.axes2);
bar(handles.name_spaFilter, handles.time_spaFilter);
ylim([0, max(arr_time+0.005)]);
text((1:length(arr_time)),arr_time, arr_time_text,'vert','bottom','horiz','center'); 
set(handles.axes2, 'XColor', 'white');
set(handles.axes2, 'YColor', 'none');
grid on;

global komspa_psnr komspa_time;
komspa_psnr = handles.psnr_spaFilter;
komspa_time = handles.time_spaFilter;

% --- Executes on button press in ResetSpasial.
function ResetSpasial_Callback(hObject, eventdata, handles)
% hObject    handle to ResetSpasial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.spa_cb1, 'Value', 0);
set(handles.spa_cb2, 'Value', 0);
set(handles.spa_cb3, 'Value', 0);
set(handles.spa_cb4, 'Value', 0);
set(handles.spa_cb5, 'Value', 0);
set(handles.spa_cb6, 'Value', 0);
set(handles.spa_cb7, 'Value', 0);
set(handles.spa_cb8, 'Value', 0);
set(handles.spa_cb9, 'Value', 0);
set(handles.spa_cb10, 'Value', 0);

axes(handles.axes1);
cla(handles.axes1);
set(handles.axes1, 'XColor', 'none');
set(handles.axes1, 'YColor', 'none');
axes(handles.axes2);
cla(handles.axes2);
set(handles.axes2, 'XColor', 'none');
set(handles.axes2, 'YColor', 'none');

guidata(hObject, handles);

% --- Executes on button press in spa_cb1.
function spa_cb1_Callback(hObject, eventdata, handles)
% hObject    handle to spa_cb1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spa_cb1

TampilkanSpasial_Callback(hObject, eventdata, handles)

% --- Executes on button press in spa_cb2.
function spa_cb2_Callback(hObject, eventdata, handles)
% hObject    handle to spa_cb2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spa_cb2

TampilkanSpasial_Callback(hObject, eventdata, handles)

% --- Executes on button press in spa_cb3.
function spa_cb3_Callback(hObject, eventdata, handles)
% hObject    handle to spa_cb3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spa_cb3

TampilkanSpasial_Callback(hObject, eventdata, handles)

% --- Executes on button press in spa_cb4.
function spa_cb4_Callback(hObject, eventdata, handles)
% hObject    handle to spa_cb4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spa_cb4

TampilkanSpasial_Callback(hObject, eventdata, handles)

% --- Executes on button press in spa_cb5.
function spa_cb5_Callback(hObject, eventdata, handles)
% hObject    handle to spa_cb5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spa_cb5

TampilkanSpasial_Callback(hObject, eventdata, handles)

% --- Executes on button press in spa_cb6.
function spa_cb6_Callback(hObject, eventdata, handles)
% hObject    handle to spa_cb6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spa_cb6

TampilkanSpasial_Callback(hObject, eventdata, handles)

% --- Executes on button press in spa_cb7.
function spa_cb7_Callback(hObject, eventdata, handles)
% hObject    handle to spa_cb7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spa_cb7

TampilkanSpasial_Callback(hObject, eventdata, handles)

% --- Executes on button press in spa_cb8.
function spa_cb8_Callback(hObject, eventdata, handles)
% hObject    handle to spa_cb8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spa_cb8

TampilkanSpasial_Callback(hObject, eventdata, handles)

% --- Executes on button press in spa_cb9.
function spa_cb9_Callback(hObject, eventdata, handles)
% hObject    handle to spa_cb9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spa_cb9

TampilkanSpasial_Callback(hObject, eventdata, handles)


% --- Executes on button press in spa_cb10.
function spa_cb10_Callback(hObject, eventdata, handles)
% hObject    handle to spa_cb10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spa_cb10
cb10 = get(handles.spa_cb10, 'Value');
set(handles.spa_cb1, 'Value', cb10);
set(handles.spa_cb2, 'Value', cb10);
set(handles.spa_cb3, 'Value', cb10);
set(handles.spa_cb4, 'Value', cb10);
set(handles.spa_cb5, 'Value', cb10);
set(handles.spa_cb6, 'Value', cb10);
set(handles.spa_cb7, 'Value', cb10);
set(handles.spa_cb8, 'Value', cb10);
set(handles.spa_cb9, 'Value', cb10);

guidata(hObject, handles);

% --- Executes on button press in ResetFrekuensi.
function ResetFrekuensi_Callback(hObject, eventdata, handles)
% hObject    handle to ResetFrekuensi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.frek_cb1, 'Value', 0);
set(handles.frek_cb2, 'Value', 0);
set(handles.frek_cb3, 'Value', 0);
set(handles.frek_cb4, 'Value', 0);
set(handles.frek_cb5, 'Value', 0);
set(handles.frek_cb6, 'Value', 0);
set(handles.frek_cb7, 'Value', 0);
set(handles.frek_cb8, 'Value', 0);
set(handles.frek_cb9, 'Value', 0);
set(handles.frek_cb10, 'Value', 0);

axes(handles.axes1);
cla(handles.axes1);
set(handles.axes1, 'XColor', 'none');
set(handles.axes1, 'YColor', 'none');
axes(handles.axes2);
cla(handles.axes2);
set(handles.axes2, 'XColor', 'none');
set(handles.axes2, 'YColor', 'none');

guidata(hObject, handles);

% --- Executes on button press in TampilkanFrekuensi.
function TampilkanFrekuensi_Callback(hObject, eventdata, handles)
% hObject    handle to TampilkanFrekuensi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cb1 = get(handles.frek_cb1, 'Value');
cb2 = get(handles.frek_cb2, 'Value');
cb3 = get(handles.frek_cb3, 'Value');
cb4 = get(handles.frek_cb4, 'Value');
cb5 = get(handles.frek_cb5, 'Value');
cb6 = get(handles.frek_cb6, 'Value');
cb7 = get(handles.frek_cb7, 'Value');
cb8 = get(handles.frek_cb8, 'Value');
cb9 = get(handles.frek_cb9, 'Value');

arr_time = handles.time_frekFilter;
arr_psnr = handles.psnr_frekFilter;
arr_time_text = ["" "" "" "" "" "" "" "" ""];
arr_psnr_text = ["" "" "" "" "" "" "" "" ""];

switch cb1
    case 0
        arr_time(1) = 0;
        arr_psnr(1) = 0;
        arr_time_text(1) = "";
        arr_psnr_text(1) = "";
    case 1
        [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekIdeal_lp(handles.image_gray, handles.image_noise);
        arr_time(1) = filter_time;
        arr_psnr(1) = psnr_filter;
        arr_time_text(1) = string(round(arr_time(1),4));
        arr_psnr_text(1) = string(round(arr_psnr(1),2));
end

switch cb2
    case 0
        arr_time(2) = 0;
        arr_psnr(2) = 0;
        arr_time_text(2) = "";
        arr_psnr_text(2) = "";
    case 1
        [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekButter_lp(handles.image_gray, handles.image_noise);
        arr_time(2) = filter_time;
        arr_psnr(2) = psnr_filter;
        arr_time_text(2) = string(round(arr_time(2),4));
        arr_psnr_text(2) = string(round(arr_psnr(2),2));
end

switch cb3
    case 0
        arr_time(3) = 0;
        arr_psnr(3) = 0;
        arr_time_text(3) = "";
        arr_psnr_text(3) = "";
    case 1
        [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekGaussian_lp(handles.image_gray, handles.image_noise);
        arr_time(3) = filter_time;
        arr_psnr(3) = psnr_filter;
        arr_time_text(3) = string(round(arr_time(3),4));
        arr_psnr_text(3) = string(round(arr_psnr(3),2));
end

switch cb4
    case 0
        arr_time(4) = 0;
        arr_psnr(4) = 0;
        arr_time_text(4) = "";
        arr_psnr_text(4) = "";
    case 1
        [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekIdeal_hp(handles.image_gray, handles.image_noise);
        arr_time(4) = filter_time;
        arr_psnr(4) = psnr_filter;
        arr_time_text(4) = string(round(arr_time(4),4));
        arr_psnr_text(4) = string(round(arr_psnr(4),2));
end

switch cb5
    case 0
        arr_time(5) = 0;
        arr_psnr(5) = 0;
        arr_time_text(5) = "";
        arr_psnr_text(5) = "";
    case 1
        [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekButter_hp(handles.image_gray, handles.image_noise);
        arr_time(5) = filter_time;
        arr_psnr(5) = psnr_filter;
        arr_time_text(5) = string(round(arr_time(5),4));
        arr_psnr_text(5) = string(round(arr_psnr(5),2));
end

switch cb6
    case 0
        arr_time(6) = 0;
        arr_psnr(6) = 0;
        arr_time_text(6) = "";
        arr_psnr_text(6) = "";
    case 1
        [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekGaussian_hp(handles.image_gray, handles.image_noise);
        arr_time(6) = filter_time;
        arr_psnr(6) = psnr_filter;
        arr_time_text(6) = string(round(arr_time(6),4));
        arr_psnr_text(6) = string(round(arr_psnr(6),2));
end

switch cb7
    case 0
        arr_time(7) = 0;
        arr_psnr(7) = 0;
        arr_time_text(7) = "";
        arr_psnr_text(7) = "";
    case 1
        [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekSobel(handles.image_gray, handles.image_noise);
        arr_time(7) = filter_time;
        arr_psnr(7) = psnr_filter;
        arr_time_text(7) = string(round(arr_time(7),4));
        arr_psnr_text(7) = string(round(arr_psnr(7),2));
end

switch cb8
    case 0
        arr_time(8) = 0;
        arr_psnr(8) = 0;
        arr_time_text(8) = "";
        arr_psnr_text(8) = "";
    case 1
        [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekPrewitt(handles.image_gray, handles.image_noise);
        arr_time(8) = filter_time;
        arr_psnr(8) = psnr_filter;
        arr_time_text(8) = string(round(arr_time(8),4));
        arr_psnr_text(8) = string(round(arr_psnr(8),2));
end

switch cb9
    case 0
        arr_time(9) = 0;
        arr_psnr(9) = 0;
        arr_time_text(9) = "";
        arr_psnr_text(9) = "";
    case 1
        [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekLaplacian(handles.image_gray, handles.image_noise);
        arr_time(9) = filter_time;
        arr_psnr(9) = psnr_filter;
        arr_time_text(9) = string(round(arr_time(9),4));
        arr_psnr_text(9) = string(round(arr_psnr(9),2));
end

handles.psnr_frekFilter = arr_psnr;
handles.time_frekFilter = arr_time;
guidata(hObject, handles);

axes(handles.axes1);
bar(handles.name_frekFilter, handles.psnr_frekFilter);
ylim([0, max(arr_psnr+5)]);
text((1:length(arr_psnr)),arr_psnr, arr_psnr_text,'vert','bottom','horiz','center'); 
set(handles.axes1, 'XColor', 'white');
set(handles.axes1, 'YColor', 'none');
grid on;

axes(handles.axes2);
bar(handles.name_frekFilter, handles.time_frekFilter);
ylim([0, max(arr_time+0.02)]);
text((1:length(arr_time)),arr_time, arr_time_text,'vert','bottom','horiz','center'); 
set(handles.axes2, 'XColor', 'white');
set(handles.axes1, 'YColor', 'none');
grid on;

global komfrek_psnr komfrek_time;
komfrek_psnr = handles.psnr_frekFilter;
komfrek_time = handles.time_frekFilter;

% --- Executes on button press in frek_cb1.
function frek_cb1_Callback(hObject, eventdata, handles)
% hObject    handle to frek_cb1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of frek_cb1

TampilkanFrekuensi_Callback(hObject, eventdata, handles)

% --- Executes on button press in frek_cb2.
function frek_cb2_Callback(hObject, eventdata, handles)
% hObject    handle to frek_cb2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of frek_cb2

TampilkanFrekuensi_Callback(hObject, eventdata, handles)

% --- Executes on button press in frek_cb3.
function frek_cb3_Callback(hObject, eventdata, handles)
% hObject    handle to frek_cb3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of frek_cb3

TampilkanFrekuensi_Callback(hObject, eventdata, handles)

% --- Executes on button press in frek_cb4.
function frek_cb4_Callback(hObject, eventdata, handles)
% hObject    handle to frek_cb4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of frek_cb4

TampilkanFrekuensi_Callback(hObject, eventdata, handles)

% --- Executes on button press in frek_cb5.
function frek_cb5_Callback(hObject, eventdata, handles)
% hObject    handle to frek_cb5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of frek_cb5

TampilkanFrekuensi_Callback(hObject, eventdata, handles)

% --- Executes on button press in frek_cb6.
function frek_cb6_Callback(hObject, eventdata, handles)
% hObject    handle to frek_cb6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of frek_cb6

TampilkanFrekuensi_Callback(hObject, eventdata, handles)

% --- Executes on button press in frek_cb10.
function frek_cb10_Callback(hObject, eventdata, handles)
% hObject    handle to frek_cb10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of frek_cb10

cb10 = get(handles.frek_cb10, 'Value');
set(handles.frek_cb1, 'Value', cb10);
set(handles.frek_cb2, 'Value', cb10);
set(handles.frek_cb3, 'Value', cb10);
set(handles.frek_cb4, 'Value', cb10);
set(handles.frek_cb5, 'Value', cb10);
set(handles.frek_cb6, 'Value', cb10);
set(handles.frek_cb7, 'Value', cb10);
set(handles.frek_cb8, 'Value', cb10);
set(handles.frek_cb9, 'Value', cb10);

guidata(hObject, handles);


% --- Executes on button press in frek_cb9.
function frek_cb9_Callback(hObject, eventdata, handles)
% hObject    handle to frek_cb9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of frek_cb9
TampilkanFrekuensi_Callback(hObject, eventdata, handles)

% --- Executes on button press in frek_cb8.
function frek_cb8_Callback(hObject, eventdata, handles)
% hObject    handle to frek_cb8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of frek_cb8
TampilkanFrekuensi_Callback(hObject, eventdata, handles)


% --- Executes on button press in frek_cb7.
function frek_cb7_Callback(hObject, eventdata, handles)
% hObject    handle to frek_cb7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of frek_cb7
TampilkanFrekuensi_Callback(hObject, eventdata, handles)


% --- Executes on button press in CloseButton.
function CloseButton_Callback(hObject, eventdata, handles)
% hObject    handle to CloseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
main
