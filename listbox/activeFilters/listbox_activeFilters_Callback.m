% --- Executes on selection change in listbox_activeFilters.
function listbox_activeFilters_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_activeFilters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
updateMoveFilterButtons(handles);
index_selected = get(hObject,'Value');
theFilter = handles.firstDummy.Next;
k = 1;
while k < index_selected
     theFilter = theFilter.Next;
     k=k+1;
end
%Delete old sliders
old_sliders = get(handles.filter_config, 'Children');
for i = 1:length(old_sliders)
    delete(old_sliders(i));
end
props = properties(theFilter);
for i = 1:length(props)
    %Display the property name.
    uicontrol(  'Style', 'text', 'Parent', handles.filter_config, ...
                'String', props(i), 'Position', [10 5+(i - 1)*40 80 20]);
    %Display the slider.
    uicontrol(  'Style', 'slider', 'Parent', handles.filter_config, ...
                'Max',10000,'Value', eval(['theFilter.' props{i}]), ...
                'Position', [100 5+(i - 1)*40 200 20], ...
                'Callback', {@setFilterParam,theFilter, props(i)});
    %Display the current value for the property
    uicontrol(  'Style', 'text', 'Parent', handles.filter_config, ...
                'String', num2str(eval(['theFilter.' props{i}])), ...
                'Position', [310 5+(i - 1)*40 80 20]);
    % Uses cell array function handle callback
    % Implemented as a subfunction with an argument
end