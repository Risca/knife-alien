classdef BandstopFilter < Filters.FilterClass & handle & hgsetget
    properties
        lowFreq = 1000;
        highFreq = 5000;
    end
    
    methods
        function obj = BandstopFilter(obj)
            obj.Name = 'Bandstop';
        end
    end
end
