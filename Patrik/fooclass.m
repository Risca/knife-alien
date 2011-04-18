classdef fooclass < handle
    properties (Hidden)
        fooStatus = 'bar';
    end
    % Private properties of filter
    properties (SetAccess = private)
        fooNumber = 0;
        fooBar
    end
    % Events of filter
    events
        BufferUnderrun
    end
    % Methods of filter
    methods
        function FC = fooclass()
            FC = 0;
        end
        function res = doFiltering(data)
            res=data;
        end
        function tryOutEvents(FC)
            notify(FC,'BufferUnderrun')
        end
    end % methods
end % classdef
