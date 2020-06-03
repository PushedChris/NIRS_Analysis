function plot_ICAs(Zica,fs)
    level = length(Zica(:,1));
    L = length(Zica(1,:));
    t=(0:(L-1))/fs;
    figure;
    offs= 1:1:level;
    for ics = 1:level
        plot(t,Zica(ics,:) + offs(ics),'k');hold on;
    end
end