function update_listbox(handles)
%vars = evalin('base','who');
% Add some filters to listbox
handles.availableFilters = cell(3,1);
handles.availableFilters{3} = Filters.HighpassFilter;
handles.availableFilters{2} = Filters.BandpassFilter;
handles.availableFilters{1} = Filters.LowpassFilter;

filterNames = cellstr(['foo';'bar';'baz']);
for k = 1:1:numel(handles.availableFilters)
    filterNames{k} = handles.availableFilters{k}.Name;
end

set(handles.listbox_availableFilters,'String',filterNames);
