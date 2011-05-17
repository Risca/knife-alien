function update_listbox(hObject, handles)
filterNames = cellstr(['foo';'bar';'baz']);
for k = 1:1:numel(handles.availableFilters)
    filterNames{k} = handles.availableFilters{k}.Name;
end

set(handles.listbox_availableFilters,'String',filterNames);
guidata(hObject,handles);