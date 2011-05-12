classdef CustomAudioRecorder < audiorecorder & handle
    properties (SetAccess = protected)
        Data
        fftData
    end
    methods
        function obj = CustomAudioRecorder(Fs,nBits,nChannels,Nfft)
            obj = obj@audiorecorder(Fs,nBits,nChannels);
            obj.fftData.fs = Fs;
            obj.fftData.Nfft = Nfft;
%             set(obj, ...
%                 'TimerFcn',@audioTimerFcn, ...
%                 'TimerPeriod', 0.1, ...
%                 'UserData', fftData);
            obj.TimerFcn = @timerFcn;
        end
    end
    events
        NewAudioData
    end
end
