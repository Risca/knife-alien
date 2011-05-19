% --- Executes on button press in pushbutton_start.
function pushbutton_start_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check which source is selected
if get( handles.radiobutton_select_mic, 'Value')
    
    % Start microphone audio source
    disp('starting microphone');
%     fs = 22050;
%     dT = 0.05;
%     Nfft = floor(fs*dT);
%    
%     
%     
%     handles.audioObj = CustomAudioRecorder(fs,16,1,Nfft,handles.stemHandles.input);
%     set(handles.audioObj,'TimerPeriod', dT);
%     
%     addlistener(handles.audioObj,'NewAudioData',@audioTimerFcn);
%     handles.audioObj.listener = addlistener(handles.audioObj,'NewAudioData',@handles.firstDummy.eventHandler);

    % Remove pre-existing file
    if exist('recorded_audio.wav','file')
        delete('recorded_audio.wav');
    end
    handles.audioObj.reset();
    record(handles.audioObj);
       
else
    % Start file audio source
    if  strcmp( get(handles.txtbox_filename, 'String'), 'Enter filename' )
        % Do nothing
        disp( 'No filename entered' );
    else
        % Try to find file
        if  2 == exist( get(handles.txtbox_filename, 'String'),'file')
            % File exists, open file
            
            
            
        else
            % File does not exist, do nothing 
            disp( 'File does not exist!' );
        end
    end
end

