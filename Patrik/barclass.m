classdef barclass
    methods (Static)
        function testFiltering(FC)
            if FC.fooNumber == 0
                FC.fooStatus = 'foobar';
            end
        end
        function setupEvents(FC)
            addlistener(FC, 'BufferUnderrun'), ...
                @(src, evnt)barclass.testFiltering(src));
        end
    end % methods
end % classdef
