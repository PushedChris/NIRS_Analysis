clear;
% Fs=1000;
% n=0:1/Fs:1;
% xn=cos(2*pi*40*n)+3*cos(2*pi*100*n)+randn(size(n));

clear;
data = load('convert.mat');
nirs_data = data.nirs_data;
ch = 2;
%读取数据
oxyData = nirs_data.oxyData(:,ch);
dxyData = nirs_data.dxyData(:,ch);
tHbData = nirs_data.tHbData(:,ch);

oxyData=resample(oxyData,100,167);
dxyData=resample(dxyData,100,167);
tHbData=resample(tHbData,100,167);

Fs = 10;
xn = oxyData;
nfft=1024;

window=boxcar(100); %矩形窗
window1=hamming(100); %海明窗
window2=blackman(100); %blackman窗
noverlap=20; %数据无重叠
range='half'; %频率间隔为[0 Fs/2]，只计算一半的频率
[Pxx,f]=pwelch(xn,window,noverlap,nfft,Fs,range);
[Pxx1,f1]=pwelch(xn,window1,noverlap,nfft,Fs,range);
[Pxx2,f2]=pwelch(xn,window2,noverlap,nfft,Fs,range);
plot_Pxx=10*log10(Pxx);
plot_Pxx1=10*log10(Pxx1);
plot_Pxx2=10*log10(Pxx2);

subplot(311);
plot(f,plot_Pxx);
title('矩形窗');
subplot(312);
plot(f1,plot_Pxx1);
title('海明窗');
subplot(313);
plot(f2,plot_Pxx2);
title('blackman窗');
