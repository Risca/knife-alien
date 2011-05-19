function audioTimerFcn(obj,eventData)
Fs = obj.Fs;
Nfft = numel(obj.Data);
% Clip ghost signals
Y = obj.Data(1:Nfft/2);
% Adjust magnitude
Y = abs(Y)*2/Nfft;
%Make dynamic x-axis
handle_graph = get(obj.userData, 'Parent');
% stemHandle = get(handle_graph,'Children')
% stemHandle = stemHandle(1);
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
max_f = Fs/2;
f = 1:max_f/numel(Y):max_f;
if newendindex ~= 0
    set(handle_graph, 'XLim', [0 newendindex*(Fs/Nfft)]);
end
set(handle_graph, 'YLim', [0 ymax]);
set(obj.userData,'XData',f);
set(obj.userData,'YData',Y);
drawnow;
