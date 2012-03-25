% --- Executes on button press in radiobutton_select_mic.
function radiobutton_select_mic_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_select_mic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_select_mic

% Check if the other radiobutton is pressed
if get( handles.radiobutton_select_wav, 'Value' )
    set( handles.radiobutton_select_wav, 'Value', 0 )
end

% Check if this button was just toggled to 0
if 0 == get( hObject, 'Value' )
    set( hObject, 'Value', 1 );
end
