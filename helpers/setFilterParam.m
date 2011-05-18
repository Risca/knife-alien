function setFilterParam( hObj, event, theFilter, propertyname, valuehandle)
%SETFILTERPARAM Summary of this function goes here
%   Detailed explanation goes here
    new_frequency = get(hObj,'Value');
    set(theFilter, propertyname, new_frequency);
    set(valuehandle, 'String', num2str(new_frequency));
end

