%% Init
clear;
axesHandle = axes();
global stemHandle;
stemHandle = stem(axesHandle,0);
set(axesHandle,'ALimMode','auto');
fs = 22050;
audioHandle = audiorecorder(fs,16,1);
set(audioHandle,'StopFcn',@test_audio_stem_StopFcn);
record(audioHandle,1024/fs);