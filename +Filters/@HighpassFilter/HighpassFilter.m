classdef HighpassFilter < Filters.FilterClass & handle & hgsetget
    
    properties 
        CutOffFreq = 1000
    end
    
    methods
        function obj = HighpassFilter(obj)
            obj.Name = 'Highpass';
        end
        
        function setCutoffFreq(obj, freq)
            obj.CutOffFreq = freq;
        end
    end
end
