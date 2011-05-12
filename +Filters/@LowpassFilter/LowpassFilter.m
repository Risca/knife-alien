classdef LowpassFilter < Filters.FilterClass & handle
    properties (SetAccess = protected)
        CutOffFreq
    end
    
    methods
        function obj = LowpassFilter()
        end
        
        function setCutoffFreq(obj, freq)
            obj.CutOffFreq = freq;
        end
    end
%     methods (Static)
%         function filterEvent(src,eventData)
%             foo = 42
%         end
%     end
end
