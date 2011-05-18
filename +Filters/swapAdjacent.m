function swapAdjacent(first,second)
% NOTE: This function is quite bad. first and second have to be in that
% order in linked list for this to work.
first.Prev.Next = second;
second.Next.Prev = first;
first.Next = second.Next;
second.Prev = first.Prev;
first.Prev = second;
second.Next = first;