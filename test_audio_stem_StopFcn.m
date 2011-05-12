function test_audio_stem_StopFcn(obj,eventData)
Y = getaudiodata(obj);
global Nfft;
Yfft = fft(Y,Nfft);
Yfft = Yfft(1:Nfft/2);
Yfft = abs(Yfft)*2/Nfft;
global stemHandle;
global fs;
set(stemHandle,'YData',Yfft);
drawnow;
record(obj,1024/fs);