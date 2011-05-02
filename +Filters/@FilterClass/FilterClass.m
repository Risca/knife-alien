classdef (Hidden=true) FilterClass < handle
    properties
        Data
    end
    methods (Abstract)
        filteredData = filter(obj,data)
    end
    events
        FilteringComplete
    end
end
