function audioTimerFcn(obj,eventData)
Nfft = obj.fftData.Nfft;
audioData = getaudiodata(obj);
% Only process last Nfft samples
audioData = audioData(end-Nfft:end);
Y = fft(audioData,Nfft);
Y = Y(1:Nfft/2);
Y = abs(Y)*2/Nfft;
set(obj.stemHandle,'YData',Y);
drawnow;
