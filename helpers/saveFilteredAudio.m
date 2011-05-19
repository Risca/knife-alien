function saveFilteredAudio(obj,eventData)
audioData = ifft(obj.Data);
Y = 0;
if exist('recorded_audio.wav','file')
    Y = wavread('recorded_audio.wav');
end
Y = [Y; audioData];
wavwrite(Y,obj.Fs/2,'recorded_audio.wav');