% --- Executes on selection change in listbox_activeFilters.
function listbox_activeFilters_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_activeFilters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
updateMoveFilterButtons(handles);