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

oldFilter = handles.firstDummy.Next;
k = 1;
while k < index_selected
    oldFilter = oldFilter.Next;
    k=k+1;
end

wasRunning = handles.audioObj.isrecording();
if wasRunning
    % Stop recorder
    pause(handles.audioObj);
end
% Remove filter
Filters.removeFilter(oldFilter);
if wasRunning
    % Resume recording
    resume(handles.audioObj);
end

set(handles.listbox_activeFilters,'String', contents);
updateMoveFilterButtons(handles);