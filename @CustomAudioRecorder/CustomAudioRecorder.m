classdef CustomAudioRecorder < audiorecorder & handle
    properties (SetAccess = protected)
        Data
    end
    methods
        function obj = CustomAudioRecorder(Fs,nBits,nChannels)
            obj = obj@audiorecorder(Fs,nBits,nChannels);
        end
    end
    events
        NewAudioData
    end
end
