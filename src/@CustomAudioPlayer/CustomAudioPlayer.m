classdef CustomAudioPlayer < handle

    properties
        Fs      % Sampling frequency
        UserData %Lite handles och skit
    end
    properties (SetAccess = protected)
        Data    % Audiodata
        fftData
        frame_size  % Number of samples per frame
    end
    
    properties (Access = 'private')
        Audiofile   % All samples of audio file
        Nsamples    % Number of samples in audio file
        timerObj    % Timer
        position    % starting index of next chunk of data to be processed
    end
    
    
    methods
        
        % Constructor
        function obj = CustomAudioPlayer( filename, timerInterval )
            obj.timerObj = timer('ExecutionMode', 'FixedRate',...
                                 'Period', timerInterval);
                            
            set( obj.timerObj, 'TimerFcn', @obj.customTimerFcn );
            
            % Open and convert file, do not handle stereo for now
            [y, obj.Fs] = wavread( filename );
            obj.Audiofile = y(:,1);              
            
            % Calculate frame size
            obj.frame_size = floor( obj.Fs * timerInterval );
            obj.position = 1;
            
        end
        
        function start(obj)
            start( obj.timerObj );
        end
        
        function stop(obj)
            stop( obj.timerObj );
            disp('stop called');
        end
        function reset(obj)
           obj.position = 1;            
        end
        
        function customTimerFcn( obj, src, EventData )
            disp( 'customTimerFcn Executed');
            
        % 1: Plocka ut en lagom bit av filen
            endIndex = obj.position + obj.frame_size;
            if endIndex > length(obj.Audiofile)
                endIndex = length(obj.Audiofile);
                % End of file reached, stop timer
                obj.stop();
            end
            disp(['StartIndex: ' num2str(obj.position) ' EndIndex: ' num2str(endIndex)]);
            tempData = obj.Audiofile(obj.position : endIndex);
            obj.position = endIndex;
            
        % 2: Fouriertransformera
%             obj.Data = tempData;
            obj.Data = fft(tempData);
            obj.Data = obj.Data(1:floor(length(obj.Data)/2));
            
        % 3: Let the world know...
            notify(obj,'NewAudioData');
        end
        
        % Returns true if the player is playing.
        function playing = isrecording( obj )
            if strcmp(obj.timerObj.Running, 'on')
                playing = true;
            else
                playing = false;
            end            
        end
    end
    events
        NewAudioData
    end
    
end

