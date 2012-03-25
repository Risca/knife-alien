% --- Executes during object creation, after setting all properties.
function pushbutton_moveDown_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_moveDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%Disable from start since there is no added filters
set(hObject, 'Enable', 'off');