classdef LowpassFilter < Filters.FilterClass & handle & hgsetget
    properties 
        CutOffFreq = 1200;
    end
    
    methods
        function obj = LowpassFilter(obj)
            obj.Name = 'Lowpass';
        end
    end
end
