classdef LowpassFilter < Filters.FilterClass & handle
    properties (SetAccess = protected)
        CutOffFreq
    end
    
    methods
        function obj = LowpassFilter()
        end
        
        function setCutoffFreq(obj, freq)
            obj.CutOffFreq = freq;
        end
        
        
    end
end
