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
    
    
    % Find filter before affected filter in linked list
    filterObj = handles.firstDummy.Next;
    k = 1;
    while k < index_selected-1
        filterObj = filterObj.Next;
        k=k+1;
    end
    % Stop recorder
    stop(handles.audioObj);
    % Make the swap
    Filters.swapAdjacent(filterObj,filterObj.Next);
    % Start recorder
    record(handles.audioObj);
end
updateMoveFilterButtons(handles);