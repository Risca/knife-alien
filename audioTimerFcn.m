function audioTimerFcn(obj,eventData)
Nfft = obj.fftData.Nfft;
audioData = getaudiodata(obj);
% Only process last Nfft samples
audioData = audioData(end-Nfft:end);
Y = fft(audioData,Nfft);

%Make dynamic x-axis
%Get the frequency axis values to be able to truncate
f = get(obj.stemHandle, 'UserData');
% f = get(obj.g);
%Find the last intresting index
maxindex = find(Y(1:Nfft/2) > 0.15, 1, 'last');
%get(obj.stemHandle)
xlim = get(obj.stemHandle, 'XData');
newendindex = 1;
if(f(maxindex) < xlim(end))
    newendindex = length(xlim) - floor(0.05*(length(xlim) - maxindex));
else
    newendindex = floor(maxindex/(1 - 0.05));
    if(newendindex > length(f))
        newendindex = length(f);
    end
end
set(obj.stemHandle,'XData', f(1:newendindex));
Y = Y(1:newendindex);
Y = abs(Y)*2/Nfft;
set(obj.stemHandle,'YData',Y);
drawnow;
