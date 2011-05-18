function setFilterParam( hObj, event, theFilter, propertyname, valuehandle)
%SETFILTERPARAM Set filter parameters and update filter_config slider values.
%   event is not used.
%theFilter is the specific filter that is going to be altered.
%propertyname is the property that is going to be altered.
%valuehandle is a handle to the ui that visulizes the property value.
    new_frequency = get(hObj,'Value');
    set(theFilter, propertyname, new_frequency);
    set(valuehandle, 'String', num2str(new_frequency));
end

