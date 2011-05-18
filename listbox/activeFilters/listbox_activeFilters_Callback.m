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
    uicontrol(  'Style', 'slider', 'Parent', handles.filter_config, ...
                'Max',10000,'Value', 5000, 'Position', [20 5+(i - 1)*40 120 20],...
                'Callback', {@setFilterParam,theFilter, props(i)});   
    % Uses cell array function handle callback
    % Implemented as a subfunction with an argument
end