classdef HighpassFilter < Filters.FilterClass & handle & hgsetget    
    properties 
        CutOffFreq = 800*2;
    end
    
    methods
        function obj = HighpassFilter(obj)
            obj.Name = 'Highpass';
        end
    end
end
