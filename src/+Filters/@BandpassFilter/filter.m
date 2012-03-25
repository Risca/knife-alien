    % Filter function for BandpassFilter

function filteredData = filter (obj, data)
    % Data is assumed to be transformed.
    % Sample frequency hard-coded for now
    fs = 22050;
      
    % Calculate which parts of data to set to zero and create filtering mask
    delta_f = fs / length(data);
    
    
    n_low = floor(obj.lowFreq / delta_f);
    n_high = floor(obj.highFreq / delta_f);

    FilteringMask = [zeros(1, n_low-1) ones(1, n_high-n_low+1) zeros(1, length(data)-n_high) ]'; 

    % Perform filtering
    obj.Data = data .* FilteringMask;
    filteredData = obj.Data;
    % Notify world
    notify(obj,'FilteringComplete');
    if ~isempty(obj.Next)
        obj.Next.filter(obj.Data);
    end
end
