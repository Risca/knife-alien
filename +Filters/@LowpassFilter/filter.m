    % Filter function for LowpassFilter

function filteredData = filter (obj, data)
    
    % Data is assumed to be transformed.
    % Sample frequency hard-coded for now
    fs = 22050;
      
    % Calculate which parts of data to set to zero and create filtering mask
    delta_f = fs / length(data);
    n = floor(obj.CutOffFreq / delta_f);
    
    if n > length(data)
        n = length(data);
    end
    filteringMask = [ ones(1,n) zeros(1,(length(data)-n)) ];
    
    % Filter data:
    obj.Data = data .* filteringMask;
    filteredData = obj.Data;
    
    % Notify world
    notify(obj,'FilteringComplete');
end
