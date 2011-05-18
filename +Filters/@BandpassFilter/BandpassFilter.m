classdef BandpassFilter < Filters.FilterClass & handle & hgsetget
    properties
        lowFreq = 1000;
        highFreq = 5000;
    end
    
    methods
        function obj = BandpassFilter(obj)
            obj.Name = 'Bandpass';
        end
        
        function setLowFreq(obj, frequency)
            obj.lowFreq = frequency;
        end
        
        function SetHighFreq(obj, frequency)
            obj.highFreq = frequency;
        end
    end
end
