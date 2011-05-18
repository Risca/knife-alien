classdef (Hidden=true) FilterClass < handle
    properties
        Fs
        Nfft
        userData
    end
    properties (Hidden=true)
        Next
        Prev
    end
    properties (SetAccess = protected)
        Data
        Name
    end
    methods (Abstract=true)
        filteredData = filter(obj,data)
    end
    methods
        function eventHandler(obj,src,eventData)
            % Pass on Nfft to next filter
            obj.Nfft = src.Nfft;
            obj.filter(src.Data);
        end
    end
    events
        FilteringComplete
    end
end
