function audioTimerFcn(obj,eventData)
fs = obj.fftData.fs;
Nfft = obj.fftData.Nfft;
Y = obj.Data;
%Make dynamic x-axis
handle_graph_input = get(obj.userData, 'Parent');
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
if isempty(Y) || max(Y) == 0;
    ymax = 0.5;
else
    ymax = ceil(max(Y));
end
%Sätt ut nya gränser och rita upp ny data.
set(handle_graph_input, 'XLim', [0 newendindex*(fs/Nfft)]);
set(handle_graph_input, 'YLim', [0 ymax]);
set(obj.userData,'YData',Y);
drawnow;
