function insertFilter(filter,after)
before = after.listener.Source{1};
% Delete listener from filter before
delete(before.listener);
filter.listener = addlistener(before,'FilteringComplete',@filter.eventHandler);
after.listener = addlistener(filter,'FilteringComplete',@after.eventHandler);
