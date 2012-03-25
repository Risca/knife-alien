% --- Executes on button press in pushbutton_moveDown.
function pushbutton_moveDown_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_moveDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_activeFilters,'String'));
index_selected = get(handles.listbox_activeFilters,'Value');
if index_selected < numel(contents);
    temp = contents(index_selected + 1);
    contents(index_selected + 1) = contents(index_selected);
    contents(index_selected) = temp;
    set(handles.listbox_activeFilters,'String', contents);
    set(handles.listbox_activeFilters,'Value', index_selected + 1);

    % Find first affected filter
    filterObj = handles.firstDummy.Next;
    k = 1;
    while k < index_selected
        filterObj = filterObj.Next;
        k=k+1;
    end

    wasRunning = handles.audioObj.isrecording();
    if wasRunning
        % Stop recorder
        pause(handles.audioObj);
    end
    % Make the swap
    Filters.swapAdjacent(filterObj,filterObj.Next);
    if wasRunning
        % Resume recording
        resume(handles.audioObj);
    end
end
updateMoveFilterButtons(handles);
