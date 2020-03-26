clear;
data = load('convert.mat');
nirs_data = data.nirs_data;
ch = 2;
%读取数据
oxyData = nirs_data.oxyData(:,ch);
dxyData = nirs_data.dxyData(:,ch);
tHbData = nirs_data.tHbData(:,ch);
% figure(1),title('原始数据');

fs = 10;

oxyData=resample(oxyData,100,167);
dxyData=resample(dxyData,100,167);
tHbData=resample(tHbData,100,167);

win_sz = 128;
% han_win = hanning(win_sz);      % 选择海明窗
kaiser_win = kaiser(win_sz);
nfft = win_sz;
% nooverlap = win_sz - 1;
nooverlap = 20;
[S, F, T] = spectrogram(oxyData, window, nooverlap, nfft, fs);

imagesc(T, F, log10(abs(S)))
set(gca, 'YDir', 'normal')
xlabel('Time (secs)')
ylabel('Freq (Hz)')
title('short time fourier transform spectrum')

% fs = 1000;
% t = 0:1/fs:2;
% y = sin(128*pi*t) + sin(256*pi*t);      
% 
% figure;
% win_sz = 128;
% han_win = hanning(win_sz);      % 选择海明窗
% 
% nfft = win_sz;
% nooverlap = win_sz - 1;
% [S, F, T] = spectrogram(y, window, nooverlap, nfft, fs);
% 
% imagesc(T, F, log10(abs(S)))
% set(gca, 'YDir', 'normal')
% xlabel('Time (secs)')
% ylabel('Freq (Hz)')
% title('short time fourier transform spectrum')