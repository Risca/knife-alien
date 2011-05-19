classdef CustomAudioRecorder < audiorecorder & handle
    properties
        listener
    end
    properties (SetAccess = protected)
        Data
        Fs
        Nfft
        lastSample
    end
    methods
        function obj = CustomAudioRecorder(Fs,nBits,nChannels)
            obj = obj@audiorecorder(Fs,nBits,nChannels);
            obj.Fs = Fs;
            obj.TimerFcn = @obj.customTimerFcn;
        end
        function customTimerFcn(obj,src,eventData)
            audioData = getaudiodata(src);
            % Update number of samples since last time this function ran
            obj.Nfft = obj.TotalSamples - obj.lastSample;
            obj.lastSample = obj.TotalSamples;
            % Only process last Nfft samples
            audioData = audioData(end-obj.Nfft:end);
            audioData = fft(audioData,obj.Nfft);
            obj.Data = audioData;%(1:obj.Nfft/2);
            notify(obj,'NewAudioData');
        end
        function reset(obj)
            obj.lastSample = 0;
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
