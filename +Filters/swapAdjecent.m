function swapAdjecent(first,second)
first.Prev.Next = second;
second.Next.Prev = first;
first.Next = second.Next;
second.Prev = first.Prev;
first.Prev = second;
second.Next = first;