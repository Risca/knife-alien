%Stop the audio recorder when closing main_GUI
function closeFcn(hObject, eventData)
handles = guidata(hObject);
stop(handles.audioObj);
delete(gcf)
