function removeFilter(filter)
before = filter.Prev;
after = filter.Next;
before.Next = after;
after.Prev = before;
delete(before.listener);
delete(filter.listener);
before.listener = addlistener(before,'FilteringComplete',@after.eventHandler);