function audioTimerFcn(obj,eventData)
Fs = obj.Fs;
Nfft = numel(obj.Data);
% Adjust magnitude
Y = abs(obj.Data)*2/Nfft;
%Make dynamic x-axis
handle_graph = get(obj.userData, 'Parent');
xlim = get(handle_graph, 'XLim');
%Find the last intresting index
maxindex = find(Y > 0.05, 1, 'last');
if isempty(maxindex)
    maxindex = xlim(end)*(Nfft/Fs)/2;
end
if maxindex < xlim(end)*(Nfft/Fs)
    newendindex = floor(xlim(end)*Nfft/Fs - floor(0.02*(xlim(end)*Nfft/Fs - maxindex)));
else
    newendindex = floor(maxindex/(1 - 0.15));
end
if isempty(Y) || max(Y) == 0;
    ymax = 0.5;
else
    ymax = ceil(max(Y));
end
%Send new limits for the graph and draw the new data.
set(handle_graph, 'XLim', [0 newendindex*(Fs/Nfft)]);
set(handle_graph, 'YLim', [0 ymax]);
set(obj.userData,'YData',Y);
drawnow;
