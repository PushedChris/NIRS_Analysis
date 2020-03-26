function [x, y, z] = TimeFreq_Analysis(Signal, TimeScale, Fs, plotnum)
% Signal: Signal to analyze
% TimeScale: Time of signal
% Fs: Sample Freq
% plotnum: empty if you dont want a plot , 1 if you want scalogram plot
% x: time scale meshed
% y: wavelet freqs meshed
% z: Qfs of wavelets (magnitude of scalogram)
% Copyright Biomedical Engineer, Miguel Nu?ez;
% Neurophysiology and neurochemistry laboratory, CUCBA. Guadalajara University, Mexico 
dt = 1/Fs; %period
NumVoices = 32;
a0 = 2^(1/NumVoices);
wavCenterFreq = 5/(2*pi);  %bump center freq
minfreq = 1; %min freq of analysis 
maxfreq = 600; %max freq of analysis
minscale = wavCenterFreq/(maxfreq*dt);
maxscale = wavCenterFreq/(minfreq*dt);
minscale = floor(NumVoices*log2(minscale));
maxscale = ceil(NumVoices*log2(maxscale));
scales = a0.^(minscale:maxscale).*dt;
cwtSignal = cwtft({Signal,dt},'wavelet','bump','scales',scales);
[x,y]=meshgrid(TimeScale,cwtSignal.frequencies);
z=abs(cwtSignal.cfs);
if nargin < 4, plotnum = 0; end
if plotnum==1
    figure
    surf(x,y,z)
    shading interp
    view(0,90)
    hcb=colorbar;
    title(hcb,'Magnitude')
    ylim([0 maxfreq])
    ylabel('Hz') % y-axis label
    xlabel('Secs') % x-axis label
    title('Magnitude Scalogram')
end
end