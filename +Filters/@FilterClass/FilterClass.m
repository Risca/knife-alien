classdef (Hidden=true) FilterClass < handle
    properties (SetAccess = protected)
        Data
    end
    methods (Abstract=true)
        filteredData = filter(obj,data)
    end
    events
        FilteringComplete
    end
end
