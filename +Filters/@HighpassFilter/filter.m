    % Filter function for HighpassFilter

function filteredData = filter (obj, data)
    % Pass on previus filters' Nfft
    obj.Nfft = obj.Prev.Nfft;
        
    % Data is assumed to be transformed.
    % Sample frequency hard-coded for now
    fs = 22050;
      
    % Calculate which parts of data to set to zero and create filtering mask
    delta_f = fs / length(data);
    n = floor(obj.CutOffFreq / delta_f);
    
    % Handle the case that the cutoff frequency is higher than the highest
    % possible signal frequency.
    if n > length(data)
        n = length(data);
    end
    
    filteringMask = [ zeros(1,n) ones(1,(length(data)-n)) ]';
    
    % Filter data:
    obj.Data = data .* filteringMask;
    filteredData = obj.Data;

    % Notify world
    notify(obj,'FilteringComplete');
    if ~isempty(obj.Next)
        obj.Next.filter(obj.Data);
    end
end
