function varargout = PROSES_FREKUENSI(varargin)
% PROSES_FREKUENSI MATLAB code for PROSES_FREKUENSI.fig
%      PROSES_FREKUENSI, by itself, creates a new PROSES_FREKUENSI or raises the existing
%      singleton*.
%
%      H = PROSES_FREKUENSI returns the handle to a new PROSES_FREKUENSI or the handle to
%      the existing singleton*.
%
%      PROSES_FREKUENSI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROSES_FREKUENSI.M with the given input arguments.
%
%      PROSES_FREKUENSI('Property','Value',...) creates a new PROSES_FREKUENSI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PROSES_FREKUENSI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PROSES_FREKUENSI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PROSES_FREKUENSI

% Last Modified by GUIDE v2.5 27-Oct-2021 22:44:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PROSES_FREKUENSI_OpeningFcn, ...
                   'gui_OutputFcn',  @PROSES_FREKUENSI_OutputFcn, ...
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


% --- Executes just before PROSES_FREKUENSI is made visible.
function PROSES_FREKUENSI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PROSES_FREKUENSI (see VARARGIN)

% Posisi GUI
movegui('center');

% Initial data
handles.image_gray = getappdata(0,"Citra_Gray");
handles.image_noise = getappdata(0,"Citra_Noise");

handles.image_frekFilter = getappdata(0,"Citra_frekFilter");

handles.filt_frekFilter = getappdata(0,"Filter_Spektrum");
handles.hasils_frekFilter = getappdata(0,"Hasil_Spek");
handles.u_frekFilter = getappdata(0,"Nilai_U");
handles.v_frekFilter = getappdata(0,"Nilai_V");

axes(handles.gambarabu);
imshow(handles.image_gray);

axes(handles.gambarnoise);
imshow(handles.image_noise);

axes(handles.gambarhasil);
imshow(handles.image_frekFilter);

axes(handles.spektrumfilter);
imshow(fftshift(log(1+abs(handles.filt_frekFilter))),[ ]);

axes(handles.spektrumabu);
imshow(fftshift(log(1+abs(fft2(double(handles.image_gray))))),[ ]);

axes(handles.spektrumnoise);
imshow(fftshift(log(1+abs(fft2(double(handles.image_noise))))),[ ]);

axes(handles.spektrumhasil);
imshow(fftshift(log(1+abs(handles.hasils_frekFilter))),[ ]);

axes(handles.meshgrid);
mesh(handles.u_frekFilter,handles.v_frekFilter,handles.filt_frekFilter);

% Choose default command line output for PROSES_FREKUENSI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
bg = axes('units', 'normalized', 'position', [0 0 1 1]);
wr = imread('Assets/bggrad.jpg');
imagesc(wr);
set(bg, 'handlevisibility', 'off', 'visible', 'off');
% UIWAIT makes PROSES_FREKUENSI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PROSES_FREKUENSI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
