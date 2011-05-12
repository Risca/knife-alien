function closeFcn(hObject, eventData)
handles = guidata(hObject);
stop(handles.audioObj);
delete(gcf)
