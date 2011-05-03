%% Init
clear
import Filters.*
dataToBeFiltered = [1 2 3 4 5];

%% Do som lowpass filtering
obj = LowpassFilter();
obj.filter(dataToBeFiltered);
obj.Data

%% Do some highpass filtering
obj = HighpassFilter();
obj.filter(dataToBeFiltered);
obj.Data

%% Let's do this with events
clear obj
obj1 = LowpassFilter();
obj2 = HighpassFilter();
addlistener(obj1,'FilteringComplete',@filterEventHandler);
addlistener(obj2,'FilteringComplete',@filterEventHandler);
% addlistener(eventObject,'EventName',@Obj.methodName) % — for a method of Obj.
% addlistener(eventObject,'EventName',@ClassName.methodName) % — for a static method of the class ClassName.

%%
% Do some lowpass filtering
obj1.filter(dataToBeFiltered);

% Do some highpass filtering
obj2.filter(dataToBeFiltered);