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

% Last Modified by GUIDE v2.5 03-May-2011 16:47:53

% Begin initialization code - DO NOT EDIT
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

update_listbox(handles)
set(handles.listbox_availableFilters,'Value',1)
set(handles.listbox_activeFilters,'Value',1)

% UIWAIT makes main_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_addFilter.
function pushbutton_addFilter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_addFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
list_entries = get(handles.listbox_availableFilters,'String');
index_selected = get(handles.listbox_availableFilters,'Value');
contents = cellstr(get(handles.listbox_activeFilters,'String'));
if contents{1}
    contents = [contents; list_entries{index_selected}];
else
    contents = list_entries{index_selected};
end
set(handles.listbox_activeFilters,'String', contents);
set(handles.listbox_activeFilters,'Value', length(contents));
set(handles.pushbutton_removeFilter, 'Enable', 'on');
updateMoveFilterButtons(handles);

% --- Executes on button press in pushbutton_removeFilter.
function pushbutton_removeFilter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_removeFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_activeFilters,'String'));
index_selected = get(handles.listbox_activeFilters,'Value');
if length(contents) ~= 1
    if index_selected == length(contents)
        set(handles.listbox_activeFilters, 'Value', index_selected - 1);
    end
    contents(index_selected) = [];  
else
    contents(index_selected) = {''};
    set(handles.pushbutton_removeFilter, 'Enable', 'off');
end
set(handles.listbox_activeFilters,'String', contents);
updateMoveFilterButtons(handles);

% --- Executes on button press in pushbutton_moveUp.
function pushbutton_moveUp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_moveUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_activeFilters,'String'));
index_selected = get(handles.listbox_activeFilters,'Value');
if index_selected ~= 1
    temp = contents(index_selected - 1);
    contents(index_selected - 1) = contents(index_selected);
    contents(index_selected) = temp;
    set(handles.listbox_activeFilters,'String', contents);
    set(handles.listbox_activeFilters,'Value', index_selected - 1)
end
updateMoveFilterButtons(handles);

% --- Executes on selection change in listbox_availableFilters.
function listbox_availableFilters_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_availableFilters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_availableFilters contents as cell array
        %contents{get(hObject,'Value')} %returns selected item from listbox_availableFilters
        %'Callback: available filters'


% --- Executes during object creation, after setting all properties.
function listbox_availableFilters_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_availableFilters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_addFilter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_addFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on selection change in listbox_activeFilters.
function listbox_activeFilters_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_activeFilters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
updateMoveFilterButtons(handles);

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_activeFilters contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_activeFilters


% --- Executes during object creation, after setting all properties.
function listbox_activeFilters_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_activeFilters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function update_listbox(handles)
vars = evalin('base','who');
set(handles.listbox_availableFilters,'String',vars);

% --- Executes on key press with focus on pushbutton_addFilter and none of its controls.
function pushbutton_addFilter_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_addFilter (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_moveDown.
function pushbutton_moveDown_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_moveDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_activeFilters,'String'));
index_selected = get(handles.listbox_activeFilters,'Value');
if index_selected < length(contents);
    temp = contents(index_selected + 1);
    contents(index_selected + 1) = contents(index_selected);
    contents(index_selected) = temp;
    set(handles.listbox_activeFilters,'String', contents);
    set(handles.listbox_activeFilters,'Value', index_selected + 1);
end
updateMoveFilterButtons(handles);

% --- Executes during object creation, after setting all properties.
function pushbutton_removeFilter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_removeFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%Disable from start since there is no added filters
set(hObject, 'Enable', 'off');


% --- Executes during object creation, after setting all properties.
function pushbutton_moveUp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_moveUp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%Disable from start since there is no added filters
set(hObject, 'Enable', 'off');


% --- Executes during object creation, after setting all properties.
function pushbutton_moveDown_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_moveDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%Disable from start since there is no added filters
set(hObject, 'Enable', 'off');

function updateMoveFilterButtons(handles)
%This function controlls the logic of the Filter buttons

contents = cellstr(get(handles.listbox_activeFilters,'String'));
index_selected = get(handles.listbox_activeFilters,'Value');
len = length(contents);

%Check if it is impossible to move filter up
if length(contents) == 1 || index_selected == 1
    set(handles.pushbutton_moveUp, 'Enable', 'off');
else
    set(handles.pushbutton_moveUp, 'Enable', 'on');
end

%Check if it is impossible to move filter down
if length(contents) == 1 || index_selected == len
    set(handles.pushbutton_moveDown, 'Enable', 'off');
else
    set(handles.pushbutton_moveDown, 'Enable', 'on');
end
%index_selected = get(handles.listbox_activeFilters,'Value')

function updateGraphInput(hObject)
limits = get(hObject, 'ALim')
%contents = cellstr(get(handles.graph_input,'String'));
    %contents2 = cellstr(get(handles.graph_output, 'String'))
    %'Yes it will print'


% --- Executes during object creation, after setting all properties.
function graph_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to graph_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate graph_input
updateGraphInput(hObject);

function graph_input_OpeningFcn(hObject, eventdata, handles)
updateGraphInput(handles)%handles);