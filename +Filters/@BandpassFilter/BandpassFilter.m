classdef BandpassFilter < Filters.FilterClass & handle & hgsetget
    methods
        function obj = BandpassFilter(obj)
            obj.Name = 'Bandpass';
        end
    end
end
