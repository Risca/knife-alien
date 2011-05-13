function audioTimerFcn(obj,eventData)
fs = obj.fftData.fs;
Nfft = obj.fftData.Nfft;
Y = obj.Data;
%Make dynamic x-axis
handle_graph_input = get(obj.stemHandle, 'Parent');
xlim = get(handle_graph_input, 'XLim');
%Find the last intresting index
maxindex = find(Y > 0.05, 1, 'last');
if isempty(maxindex)
    maxindex = xlim(end)*(Nfft/fs)/2;
end
if maxindex < xlim(end)*(Nfft/fs)
    newendindex = floor(xlim(end)*Nfft/fs - floor(0.02*(xlim(end)*Nfft/fs - maxindex)));
else
    newendindex = floor(maxindex/(1 - 0.15));
end
%Sätt ut nya gränser och rita upp ny data.
set(handle_graph_input, 'XLim', [0 newendindex*(fs/Nfft)]);
set(handle_graph_input, 'YLim', [0 ceil(max(Y))]);
set(obj.stemHandle,'YData',Y);
drawnow;
