function update_listbox(handles)
vars = evalin('base','who');
set(handles.listbox_availableFilters,'String',vars);
