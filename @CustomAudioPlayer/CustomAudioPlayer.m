classdef CustomAudioPlayer

    properties
        Fs      % Sampling frequency
        UserData %Lite handles och skit
    end
    properties (SetAccess = protected)
        Data    % Audiodata
        fftData
        Running    % Indocates if player is running
    end
    
    properties (Access = 'private')
        Audiofile   % All samples of audio file
        Nsamples    % Number of samples in audio file
        timerObj    % Timer
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
           
        end
        
        function start(obj)
            
            start( obj.timerObj );
            get( obj.timerObj, 'Running')
            disp( 'startAudioPlayer executed' ); 
        end
        
        function stop(obj)
            stop( obj.timerObj );
        end
        
        function customTimerFcn( obj, src, EventData )
            disp( 'customTimerFcn Executed');
        end
        
        % Returns true if the player is playing.
        function playing = isrecording( obj )
           if strcmp(obj.running, 'on')
               playing = true;
           else
               playing = false;
           end            
        end
    end
    
end

