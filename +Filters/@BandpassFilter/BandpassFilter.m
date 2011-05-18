classdef BandpassFilter < Filters.FilterClass & handle & hgsetget
    properties
        lowFreq = 1000;
        highFreq = 5000;
    end
    
    methods
        function obj = BandpassFilter(obj)
            obj.Name = 'Bandpass';
        end
    end
end
