function filteredData = filter (obj, data)
    % Make filtering
    obj.Data = data.*2;
    filteredData = obj.Data;
    % Notify world
    notify(obj,'FilteringComplete');
end
