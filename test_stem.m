clear;
Y = [0 1 2 3 4 3 2 1 0];
axesHandle = axes();
stemHandle = stem(axesHandle,Y);
Y2 = [4 3 2 1 0 1 2 3 4];
set(stemHandle,'YData',Y2);
import Filters.*;
obj = HighpassFilter();
obj.filter(Y2);
%set(axesHandle,'YLim',[min(obj.Data) max(obj.Data)]);
set(axesHandle,'ALimMode','auto');
for i=1:50
%    obj.filter(obj.Data);
    set(stemHandle,'YData',rand(1,50)*rand());
    pause(0.1);
end
