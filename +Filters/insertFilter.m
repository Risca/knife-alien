function insertFilter(filter,before,after)
% Adjust Next and Prev
before.Next = filter;
filter.Prev = before;
filter.Next = after;
after.Prev = filter;
% Delete listener from filter before
delete(before.listener);
before.listener = addlistener(before,'FilteringComplete',@filter.eventHandler);
filter.listener = addlistener(filter,'FilteringComplete',@after.eventHandler);