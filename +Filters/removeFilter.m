function removeFilter(filter)
before = filter.Prev;
after = filter.Next;
before.Next = after;
after.Prev = before;