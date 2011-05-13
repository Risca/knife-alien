function filteredData = filter (obj, data)
    % Make filtering... NOT!
    obj.Data = data;
    filteredData = obj.Data;
    % Notify world
    notify(obj,'FilteringComplete');
end
