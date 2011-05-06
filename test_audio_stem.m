%% Init
clear;
axesHandle = axes();
global stemHandle;
global fs;
global Nfft;
fs = 44100;
Nfft = 256;
f = (0:Nfft/2-1)*fs/Nfft;
stemHandle = stem(axesHandle,f,zeros(1,length(f)));
%set(axesHandle,'ALimMode','auto');
set(axesHandle,'ALimMode','manual');
set(axesHandle,'YLim',[0 0.5]);
set(axesHandle,'XLim',[0 f(end)]);
axis manual;
audioHandle = audiorecorder(fs,16,1);
set(audioHandle,'StopFcn',@test_audio_stem_StopFcn);
%% Start
record(audioHandle,Nfft/fs);