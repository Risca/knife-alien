function playFilteredAudio(obj,eventData)
if numel(obj.Data) > 512
    audioData = int16(ifft(obj.Data)*32767);
    playAudio(obj.UserData,audioData);
end