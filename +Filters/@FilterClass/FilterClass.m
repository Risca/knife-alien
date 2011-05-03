classdef (Hidden=true) FilterClass < handle
    properties (Abstract=true)
        Data
    end
    methods (Abstract=true)
        filteredData = filter(obj,data)
    end
    events
        FilteringComplete
    end
end
