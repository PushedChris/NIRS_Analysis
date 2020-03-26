% Version 1.0, Feb.19 2020
% clear;
data = load('convert.mat');
nirs_data = data.nirs_data;
%% 下列处理均以脱氧血红蛋白为例
%% 数据预处理 横向版
ch = 57;
%创建下采样后的数据阵
oxyData = zeros(length(resample(nirs_data.oxyData(:,1),100,167)),ch);
for i = 1 : ch
    oxyData(:,i) = resample(nirs_data.oxyData(:,i),100,167);
end
%低通滤波
hd = lowpass5;
for i = 1 : ch
    oxyData(:,i) = filter(hd,oxyData(:,i));
end
%基本方法去基线漂移
for i = 1 : ch
    oxyData(:,i) = detrend(oxyData(:,i));
end
%小波方法去基线漂移
for i = 1 : ch
    oxyData(:,i) = DeBaseline_Wavelet(oxyData(:,i));
end
%% 数据预处理 纵向版
% %读取数据
% oxyData = nirs_data.oxyData(:,2);
% dxyData = nirs_data.dxyData(:,2);
% tHbData = nirs_data.tHbData(:,2);
% figure(1),title('原始数据');
% plot(oxyData,'r'),hold on,
% plot(dxyData,'b'),hold on,
% plot(tHbData,'g'),hold on,
% %下采样
% oxyData=resample(oxyData,100,167);
% dxyData=resample(dxyData,100,167);
% tHbData=resample(tHbData,100,167);
% oxyData = filter(hd,oxyData);
% dxyData = filter(hd,dxyData);
% tHbData = filter(hd,tHbData);
% 
% figure(2),
% subplot(311);
% plot(oxyData,'r'),hold on,
% plot(dxyData,'b'),hold on,
% plot(tHbData,'g');
% title('低通滤波后的数据');
% axis([0,length(oxyData),-0.02,0.02]);
% 
% oxyData1 = detrend(oxyData);
% dxyData1 = detrend(dxyData);
% tHbData1 = detrend(tHbData);
% subplot(312);
% axis([0,length(oxyData),-0.02,0.02]);
% plot(oxyData1,'r'),hold on,
% plot(dxyData1,'b'),hold on,
% plot(tHbData1,'g');
% title('基本方法去基线漂移'),
% axis([0,length(oxyData),-0.02,0.02]);
% 
% oxyData = DeBaseline_Wavelet(oxyData);
% dxyData = DeBaseline_Wavelet(dxyData);
% tHbData = DeBaseline_Wavelet(tHbData);
% subplot(313);
% plot(oxyData,'r'),hold on,
% plot(dxyData,'b'),hold on,
% plot(tHbData,'g');
% title('小波方法去基线漂移');
% axis([0,length(oxyData),-0.02,0.02]);
%% 脑电地形图实验 + ICA 激活功能分析
% display = nirs_data.oxyData(:,1);
% for i = 2 : 57
%         display  = [display ; nirs_data.oxyData(:,i)];
% end
% topoplotEEG(display,'bp1.txt','electrodes','labels','maplimits',[0,0.1]);%yy是输入的数据，yy是行向量
% % ICA
% level = 57; %ICA分层数，最高设为通道数
% fs = 10;
% % [Zica,A,W] = fastica(nirs_data.oxyData,'numOfIC', level);
%  figure(1),plot_ICAs(W,fs);
% display = W(:,1);
% for i = 2 : 57
%         display  = [display ; W(:,i)];
% end
% figure(2),topoplotEEG(display,'bp1.txt','electrodes','labels','maplimits',[0,0.1]);%yy是输入的数据，yy是行向量
%% 特征分析 单通道
oxyData2 = oxyData(:,2);
% %小波分析
% fs = 10;
% len = length(oxyData2);
% t = 1:len;
% [cfs,f] = cwt(oxyData2,'bump',fs);
% cwt(oxyData2);
% % pcolor(t,f,abs(cfs));shading interp

% %功率谱分析
% Fs = 10;
% xn = oxyData2;
% nfft=1024;
% 
% window=boxcar(100); %矩形窗
% window1=hamming(100); %海明窗
% window2=blackman(100); %blackman窗
% noverlap=20; %数据无重叠
% range='half'; %频率间隔为[0 Fs/2]，只计算一半的频率
% [Pxx,f]=pwelch(xn,window,noverlap,nfft,Fs,range);
% [Pxx1,f1]=pwelch(xn,window1,noverlap,nfft,Fs,range);
% [Pxx2,f2]=pwelch(xn,window2,noverlap,nfft,Fs,range);
% plot_Pxx=10*log10(Pxx);
% plot_Pxx1=10*log10(Pxx1);
% plot_Pxx2=10*log10(Pxx2);
% 
% subplot(311);
% plot(f,plot_Pxx);
% title('矩形窗');
% subplot(312);
% plot(f1,plot_Pxx1);
% title('海明窗');
% subplot(313);
% plot(f2,plot_Pxx2);
% title('blackman窗');

% %短时傅里叶分析
% win_sz = 128;
% % han_win = hanning(win_sz);      % 选择海明窗
% kaiser_win = kaiser(win_sz);
% nfft = win_sz;
% % nooverlap = win_sz - 1;
% nooverlap = 20;
% [S, F, T] = spectrogram(oxyData2, window, nooverlap, nfft, fs);
% figure(),
% imagesc(T, F, log10(abs(S)))
% set(gca, 'YDir', 'normal')
% xlabel('Time (secs)')
% ylabel('Freq (Hz)')
% title('short time fourier transform spectrum')
%% 特征提取 纵向
%% 非线性特征提取
% % 近似熵算法测试代码
% m = 2;           % 模式维数
% r_factor = 0.2; % 相似容限系数

% % 周期信号的信号近似熵值
% signal = oxyData;
% ApEn_value_x = ApEn(signal(100:200),m,r_factor) % 信号近似熵值
% % 周期信号叠加白噪声的信号近似熵值
% signal = f;
% ApEn_value_f = ApEn(signal(100:200),m,r_factor) % 信号近似熵值

% %样本熵算法测试代码
% r_factor = 0.2 * std(oxyData); % 阈值大小
% signal = oxyData;
% SampEn_value_x = SampEn(signal(100:200),m,r_factor) % 信号样本熵值
% % 周期信号叠加白噪声的信号近似熵值
% signal = f;
% SampEn_value_f = SampEn(signal(100:200),m,r_factor) % 信号样本熵值

%多尺度熵运算
% mse - multi-scale entropy
% sf  - scale factor corresponding to mse
% signal = oxyData;
% [mse,sf] = MSE_Costa2005(signal,20,m,std(signal)*0.15);
% signal = f;
% [mse,sf] = MSE_Costa2005(signal,20,m,std(signal)*0.15);
% % Plot mse
% figure, set(gcf,'Color',[1 1 1]), hold on, pp = []; labfull = {};
% set(gca,'FontSize',12)
% pp = plot(sf,mse,'-','Color',[0,0,0],'LineWidth',2);
% labfull = ['White' ' noise (1/f^{' num2str(0) '})'];
% ylim([0 3])
% xlabel('Scale')
% ylabel('SampEn')
% title('Multi-scale entropy')
% legend(pp,labfull)
% legend('boxoff')
%% 统计特征提取
% % 均值
% mean_val = mean(oxyData);
% % 标准差
% std_val = std(oxyData);
% % 偏度 , >0 右偏态
% skewness_val = skewness(oxyData);
% % 峭度 ,>0 尖峰态 正态分布峰度 = 0
% kurtosis_val = kurtosis(oxyData);