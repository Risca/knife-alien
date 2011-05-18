classdef CustomAudioPlayer < timer & handle

    properties
        Fs      % Sampling frequency
        UserData %Lite handles och skit
    end
    properties (SetAccess = protected)
        Data    % Audiodata
        fftData
    end
    
    properties (Access = 'private')
        Audiofile   % All samples of audio file
        Nsamples    % Number of samples in audio file
    end
    
    
    methods
        
        % Constructor
        function obj = CustomAudioPlayer( filename, timerInterval )
            obj = obj@timer('ExecutionMode', 'FixedRate',...
                            'Period', timerInterval)
                            
            obj.TimerFcn = @obj.customTimerFcn
            
            % Open and convert file, do not handle stereo for now
            [y, obj.Fs] = wavread( filename );
            obj.Audiofile = y(:,1);                                           
           
        end
        
        function startAudioPlayer(obj)
            set( obj, 'Running', 'on' );
        end
        
        function customTimerFcn( obj, src, EventData )
            
            
        end
    end
    
end

