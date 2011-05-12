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