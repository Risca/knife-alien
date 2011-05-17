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
set(handles.listbox_activeFilters,'String', contents);
set(handles.listbox_activeFilters,'Value', numel(contents));
set(handles.pushbutton_removeFilter, 'Enable', 'on');
updateMoveFilterButtons(handles);