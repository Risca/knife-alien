function audioTimerFcn(obj,eventData)
obj.TotalSamples;
data = obj.UserData;
Nfft = data.Nfft;
audioData = getaudiodata(obj);
% Only process last Nfft samples
audioData = audioData(end-Nfft:end);
Y = fft(audioData,Nfft);
Y = Y(1:Nfft/2);
Y = abs(Y)*2/Nfft;
set(data.stemHandle,'YData',Y);
drawnow;
