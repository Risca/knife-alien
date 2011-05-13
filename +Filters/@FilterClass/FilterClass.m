classdef (Hidden=true) FilterClass < handle
    properties
        userData
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
            obj.filter(src.Data);
        end
    end
    events
        FilteringComplete
    end
end
