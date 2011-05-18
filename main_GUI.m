function varargout = main_GUI(varargin)
% MAIN_GUI MATLAB code for main_GUI.fig
%      MAIN_GUI, by itself, creates a new MAIN_GUI or raises the existing
%      singleton*.
%
%      H = MAIN_GUI returns the handle to a new MAIN_GUI or the handle to
%      the existing singleton*.
%
%      MAIN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_GUI.M with the given input arguments.
%
%      MAIN_GUI('Property','Value',...) creates a new MAIN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_GUI

% Last Modified by GUIDE v2.5 18-May-2011 19:52:34

% Begin initialization code - DO NOT EDIT
addpath(genpath('graph'));
addpath('helpers');
addpath(genpath('listbox'));
addpath(genpath('pushbutton'));
addpath(genpath('AudioSourceSelection'));
addpath(genpath('FilterConfig'));

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @main_GUI_OutputFcn, ...
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


% --- Executes just before main_GUI is made visible.
function main_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to main_GUI (see VARARGIN)

    % Choose default command line output for main_GUI
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % Declare some stuff for sampling and the fft
    fs = 22050;
    dT = 0.05;
    Nfft = floor(fs*dT);
    f = (0:Nfft/2-1)*fs/Nfft;
    % Setup stem plot for unfiltered fft plot
    stemHandle = stem(handles.graph_input,f,zeros(1,length(f)));
    stemHandle2 = stem(handles.graph_output,f,zeros(1,length(f)));
    set(handles.graph_input,'ALimMode','manual');
    set(handles.graph_input,'YLim',[0 0.5]);
    set(handles.graph_input,'XLim',[0 f(end)]);

    handles.stemHandles.input = stemHandle;
    handles.stemHandles.output = stemHandle2;

    % Setup audio object

    % Create empty place to store audio recorder or player (needed for
    % closeFcn)
    handles.audioObj = [];

    % Bör lyftas ut någonstans...
    handles.audioObj = CustomAudioRecorder(fs,16,1,Nfft,stemHandle);
    set(handles.audioObj,'TimerPeriod', dT);
    %%%%%%

    
    dummy = Filters.DummyFilter;
    firstDummy = Filters.DummyFilter;
    addlistener(firstDummy,'FilteringComplete',@audioTimerFcn);
    firstDummy.Next = dummy;
    dummy.Prev = firstDummy;
    set(dummy,'userData',stemHandle2);
    set(firstDummy,'userData',stemHandle);
    set(dummy,'Fs',fs);
    handles.audioObj.listener = addlistener(handles.audioObj,'NewAudioData',@firstDummy.eventHandler);
    addlistener(dummy,'FilteringComplete',@audioTimerFcn);
    handles.dummy = dummy;
    handles.firstDummy = firstDummy;

%     addlistener(dummy,'FilteringComplete',@saveFilteredAudio);
    % Start recording
%     record(handles.audioObj);

    % Add some filters to listbox
    handles.availableFilters = cell(3,1);
    handles.availableFilters{3} = Filters.HighpassFilter;
    handles.availableFilters{2} = Filters.BandpassFilter;
    handles.availableFilters{1} = Filters.LowpassFilter;
    update_listbox(hObject, handles)

    set(handles.listbox_availableFilters,'Value',1)
    set(handles.listbox_activeFilters,'Value',1)

    % closeFcn must stop the recording
    set(handles.figure1,'CloseRequestFcn',@closeFcn);
    % UIWAIT makes main_GUI wait for user response (see UIRESUME)
    % uiwait(handles.figure1);

    % Update handles structure
    guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = main_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_activeFilters contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_activeFilters


