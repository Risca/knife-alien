% --- Executes during object creation, after setting all properties.
function graph_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to graph_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate graph_input
updateGraphInput(hObject);
