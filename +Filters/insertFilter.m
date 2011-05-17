function insertFilter(filter,before,after)
% Adjust Next and Prev
if ~isempty(before)
    before.Next = filter;
end
filter.Prev = before;
filter.Next = after;
after.Prev = filter;