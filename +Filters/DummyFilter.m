classdef (Hidden=true) DummyFilter < Filters.FilterClass & handle & hgsetget    
    methods
        function obj = DummyFilter(obj)
            obj.Name = 'Dummy';
        end
        function filteredData = filter(obj,data)
            % Pass on previus filters' Nfft
            obj.Nfft = obj.Prev.Nfft;
            obj.Data = data;
            filteredData = obj.Data;
            notify(obj,'FilteringComplete');
            if ~isempty(obj.Next)
                obj.Next.filter(obj.Data);
            end    
        end
    end
end
