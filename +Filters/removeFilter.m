function removeFilter(filter,after)
before = filter.listener.Source{1};
delete(filter.listener);
delete(after.listener);
after.listener = addlistener(before,'FilteringComplete',@after.eventHandler);
% filter
% before
% after