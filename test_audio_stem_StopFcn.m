function test_audio_stem_StopFcn(obj,eventData)
Y = getaudiodata(obj);
set(stemHandle,'YData',Y);
record(obj,1024/fs);

