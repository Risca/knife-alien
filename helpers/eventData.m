classdef eventData < event.EventData
   properties
      Data
   end

   methods
      function data = eventData(Data)
         data.Data = Data;
      end
   end
end