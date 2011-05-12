classdef CustomAudioRecorder < audiorecorder & handle
    properties (SetAccess = protected)
        fftData
        stemHandle
    end
    methods
        function obj = CustomAudioRecorder(Fs,nBits,nChannels,Nfft,stemHandle)
            obj = obj@audiorecorder(Fs,nBits,nChannels);
            obj.fftData.fs = Fs;
            obj.fftData.Nfft = Nfft;
            obj.stemHandle = stemHandle;
            obj.TimerFcn = @obj.customTimerFcn;
        end
        function customTimerFcn(obj,src,eventData)
            notify(src,'NewAudioData');
        end
    end
    methods (Static,Hidden)
        % Overide audiorecorder's private, hidden validateFcn.
        % Had to make this function static, don't really know why.
        function validateFcn(fcn)
        end
    end
    events
        NewAudioData
    end
end
