classdef CustomAudioRecorder < audiorecorder & handle
    properties
        userData
        listener
        Fs
    end
    properties (SetAccess = protected)
        Data
        fftData
    end
    methods
        function obj = CustomAudioRecorder(Fs,nBits,nChannels,Nfft,stemHandle)
            obj = obj@audiorecorder(Fs,nBits,nChannels);
            obj.fftData.fs = Fs;
            obj.fftData.Nfft = Nfft;
            obj.userData = stemHandle;
            obj.TimerFcn = @obj.customTimerFcn;
        end
        function customTimerFcn(obj,src,eventData)
            Nfft = obj.fftData.Nfft;
            audioData = getaudiodata(src);
            % Only process last Nfft samples
            audioData = audioData(end-Nfft:end);
            audioData = fft(audioData,Nfft);
            audioData = audioData(1:Nfft/2);
            % Adjust magnitude
            obj.Data = abs(audioData)*2/Nfft;
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
