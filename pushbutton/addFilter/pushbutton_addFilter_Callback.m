% --- Executes on button press in pushbutton_addFilter.
function pushbutton_addFilter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_addFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
list_entries = cellstr(get(handles.listbox_availableFilters,'String'));
index_selected = get(handles.listbox_availableFilters,'Value');
contents = cellstr(get(handles.listbox_activeFilters,'String'));
if isempty(contents{1})
    contents = cellstr(list_entries{index_selected});
else
    contents = [contents; list_entries{index_selected}];
end

k = 1;
while ~strcmp(handles.availableFilters{k}.Name, ...
        list_entries{index_selected})
    k = k+1;
end

% Create new filter
eval(['newFilter = ' class(handles.availableFilters{k}) ';']);
% Stop recorder
stop(handles.audioObj);
% Insert filter
Filters.insertFilter(newFilter,handles.dummy);
% Check to see if this was the first filter added ever
if numel(contents) == 1
    delete(handles.audioObj.listener);
    handles.audioObj.listener = addlistener(handles.audioObj,'NewAudioData',@newFilter.eventHandler);
end
% Start recorder
record(handles.audioObj);

set(handles.listbox_activeFilters,'String', contents);
set(handles.listbox_activeFilters,'Value', numel(contents));
set(handles.pushbutton_removeFilter, 'Enable', 'on');
updateMoveFilterButtons(handles);