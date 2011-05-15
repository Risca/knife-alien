function removeFilter(filter,before,after)
delete(filter.listener);
delete(before.listener);
before.listener = addlistener(before,'FilteringComplete',after.eventHandler);