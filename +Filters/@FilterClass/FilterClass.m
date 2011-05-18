classdef (Hidden=true) FilterClass < handle
    properties
        
    end
    properties (Hidden=true)
        Fs
        Nfft
        userData
        Next
        Prev
    end
    properties (SetAccess = protected, Hidden = true)
        Data
        Name
    end
    methods (Abstract=true)
        filteredData = filter(obj,data)
    end
    methods
        function eventHandler(obj,src,eventData)
            obj.filter(src.Data);
        end
    end
    events
        FilteringComplete
    end
end
