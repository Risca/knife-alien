classdef CustomAudioRecorder < audiorecorder & handle
    properties
        userData
        listener
    end
    properties (SetAccess = protected)
        Data
        Fs
        Nfft
    end
    methods
        function obj = CustomAudioRecorder(Fs,nBits,nChannels,Nfft,stemHandle)
            obj = obj@audiorecorder(Fs,nBits,nChannels);
            obj.Fs = Fs;
            obj.Nfft = Nfft;
            obj.userData = stemHandle;
            obj.TimerFcn = @obj.customTimerFcn;
        end
        function customTimerFcn(obj,src,eventData)
            % Nfft = obj.Nfft;
            audioData = getaudiodata(src);
            % Only process last Nfft samples
            audioData = audioData(end-obj.Nfft:end);
            audioData = fft(audioData,obj.Nfft);
            audioData = audioData(1:obj.Nfft/2);
            % Adjust magnitude
            obj.Data = abs(audioData)*2/obj.Nfft;
            notify(obj,'NewAudioData');
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
