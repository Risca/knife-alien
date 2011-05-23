%Stop the audio recorder when closing main_GUI
function closeFcn(hObject, eventData)
handles = guidata(hObject);

if isempty(handles.audioObj) == 0
    stop(handles.audioObj);
end

% destroyPulseaudio(handles.pa_ptr);

delete(gcf)
