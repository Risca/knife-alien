classdef CustomAudioRecorder < audiorecorder & handle
    properties (SetAccess = protected)
        Data
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
            Nfft = obj.fftData.Nfft;
            audioData = getaudiodata(src);
            % Only process last Nfft samples
            obj.Data = audioData(end-Nfft:end);
            obj.Data = fft(audioData,Nfft);
            obj.Data = obj.Data(1:Nfft/2);
            % Adjust magnitude
            obj.Data = abs(obj.Data)*2/Nfft;
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
