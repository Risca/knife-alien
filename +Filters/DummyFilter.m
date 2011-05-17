classdef (Hidden=true) DummyFilter < Filters.FilterClass & handle & hgsetget    
    methods
        function obj = DummyFilter(obj)
            obj.Name = 'Dummy';
        end
        function filteredData = filter(obj,data)
            obj.Data = data;
            filteredData = obj.Data;
            notify(obj,'FilteringComplete');
            if ~isempty(obj.Next)
                obj.Next.filter(obj.Data);
            end    
        end
    end
end
