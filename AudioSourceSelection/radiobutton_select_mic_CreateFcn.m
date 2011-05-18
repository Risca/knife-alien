% --- Executes during object creation, after setting all properties.
function radiobutton_select_mic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton_select_mic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Value', 1.0);