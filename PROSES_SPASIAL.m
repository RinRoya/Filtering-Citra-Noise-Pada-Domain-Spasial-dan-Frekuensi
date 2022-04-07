function varargout = PROSES_SPASIAL(varargin)
% PROSES_SPASIAL MATLAB code for PROSES_SPASIAL.fig
%      PROSES_SPASIAL, by itself, creates a new PROSES_SPASIAL or raises the existing
%      singleton*.
%
%      H = PROSES_SPASIAL returns the handle to a new PROSES_SPASIAL or the handle to
%      the existing singleton*.
%
%      PROSES_SPASIAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROSES_SPASIAL.M with the given input arguments.
%
%      PROSES_SPASIAL('Property','Value',...) creates a new PROSES_SPASIAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PROSES_SPASIAL_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PROSES_SPASIAL_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PROSES_SPASIAL

% Last Modified by GUIDE v2.5 07-Apr-2022 14:24:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PROSES_SPASIAL_OpeningFcn, ...
                   'gui_OutputFcn',  @PROSES_SPASIAL_OutputFcn, ...
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


% --- Executes just before PROSES_SPASIAL is made visible.
function PROSES_SPASIAL_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PROSES_SPASIAL (see VARARGIN)

% Posisi GUI
movegui('center');

% Initial data
handles.image_warna = getappdata(0,"Citra_Warna");
handles.image_gray = getappdata(0,"Citra_Gray");
handles.image_noise = getappdata(0,"Citra_Noise");

handles.image_filter = getappdata(0,"Citra_spaFilter");
handles.filter = getappdata(0,"spaFilter");

axes(handles.axes1);
imshow(handles.image_gray);
axes(handles.axes2);
imshow(handles.image_noise);
axes(handles.axes3);
filter_heatmap(handles.filter);
axes(handles.axes4);
imshow(handles.image_filter);
axes(handles.axes5);
imhist(handles.image_gray); xticks([]); yticks([]);
axes(handles.axes6);
imhist(handles.image_noise); xticks([]); yticks([]);
axes(handles.axes7);
imhist(handles.image_filter); xticks([]); yticks([]);

% Choose default command line output for PROSES_SPASIAL
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
bg = axes('units', 'normalized', 'position', [0 0 1 1]);
wr = imread('Assets/bgpro.jpg');
imagesc(wr);
set(bg, 'handlevisibility', 'off', 'visible', 'off');
% UIWAIT makes PROSES_SPASIAL wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PROSES_SPASIAL_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
