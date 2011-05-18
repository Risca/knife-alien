function saveFilteredAudio(obj,eventData)
audioData = ifft(obj.Data)*obj.Nfft/2;
Y = 0;
if exist('recorded_audio.wav','file')
    Y = wavread('recorded_audio.wav');
end
Y = [Y; audioData];
wavwrite(Y,obj.Fs,'recorded_audio.wav');