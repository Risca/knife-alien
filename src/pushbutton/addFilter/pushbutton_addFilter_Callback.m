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
wasRunning = handles.audioObj.isrecording();
if wasRunning
    % Stop recorder
    pause(handles.audioObj);
end
% Insert filter
Filters.insertFilter(newFilter,handles.dummy);
if wasRunning
    % Resume recording
    resume(handles.audioObj);
end

set(handles.listbox_activeFilters,'String', contents);
set(handles.listbox_activeFilters,'Value', numel(contents));
set(handles.pushbutton_removeFilter, 'Enable', 'on');
updateMoveFilterButtons(handles);