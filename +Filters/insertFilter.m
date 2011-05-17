function insertFilter(filter,after)
% Adjust Next and Prev
before = after.Prev;
if ~isempty(before)
    before.Next = filter;
end
filter.Prev = before;
filter.Next = after;
after.Prev = filter;