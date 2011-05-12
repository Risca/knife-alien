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