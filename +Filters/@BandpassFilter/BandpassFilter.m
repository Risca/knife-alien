classdef BandpassFilter < Filters.FilterClass & handle & hgsetget
    properties
        lowFreq = 1000;
        highFreq = 5000;
    end
    
    methods
        function obj = BandpassFilter(obj)
            obj.Name = 'Bandpass';
        end
        
        function SetLowFreq(obj, frequency)
            obj.lowFreq = frequency;
        end
        
        function SetHighFreq(obj, frequency)
            obj.lighFreq = frequency;
        end
    end
end
