function audioTimerFcn(obj,eventData)
Nfft = obj.fftData.Nfft;
audioData = getaudiodata(obj);
% Only process last Nfft samples
audioData = audioData(end-Nfft:end);
Y = fft(audioData,Nfft);

%Make dynamic x-axis
%Get the frequency axis values to be able to truncate
userdata = get(obj.stemHandle, 'UserData');
f = userdata.f;
handle_graph_input = userdata.graph_input;
% f = get(obj.g);
%Find the last intresting index
Y = Y(1:Nfft/2);
maxindex = find(Y > 0.3, 1, 'last');
Y = abs(Y)*2/Nfft;
%get(obj.stemHandle)
xlim = get(obj.stemHandle, 'XData');
newendindex = 1;
if(f(maxindex) < xlim(end))
    newendindex = length(xlim) - floor(0.02*(length(xlim) - maxindex));
else
    newendindex = floor(maxindex/(1 - 0.05));
    if(newendindex > length(f))
        newendindex = length(f);
    end
end
set(obj.stemHandle,'XData', f(1:newendindex));
set(handle_graph_input, 'XLim', [0 f(newendindex)]);
Y = Y(1:newendindex);
set(obj.stemHandle,'YData',Y);
drawnow;
