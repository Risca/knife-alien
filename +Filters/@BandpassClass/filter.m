function filteredData = filter (obj, data)
    % Make filtering
    Data = data.*2;
    % Notify world
    notify(obj,'FilteringComplete');
end
