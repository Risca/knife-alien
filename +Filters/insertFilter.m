function insertFilter(filter,before,after)
delete(before.listener);
before.listener = addlistener(before,'FilteringComplete',@filter.eventHandler);
filter.listener = addlistener(filter,'FilteringComplete',@after.eventHandler);
filter
before
after
