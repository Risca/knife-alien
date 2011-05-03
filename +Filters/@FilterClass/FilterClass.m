classdef (Hidden=true) FilterClass < handle
    properties (SetAccess = protected, GetAccess = protected)
        Data
    end
    methods (Abstract=true)
        filteredData = filter(obj,data)
    end
    events
        FilteringComplete
    end
end
