% Version 1.0, Feb.19 2020
% clear;
data = load('convert.mat');
nirs_data = data.nirs_data;
%% ���д����������Ѫ�쵰��Ϊ��
%% ����Ԥ���� �����
ch = 57;
%�����²������������
oxyData = zeros(length(resample(nirs_data.oxyData(:,1),100,167)),ch);
for i = 1 : ch
    oxyData(:,i) = resample(nirs_data.oxyData(:,i),100,167);
end
%��ͨ�˲�
hd = lowpass5;
for i = 1 : ch
    oxyData(:,i) = filter(hd,oxyData(:,i));
end
%��������ȥ����Ư��
for i = 1 : ch
    oxyData(:,i) = detrend(oxyData(:,i));
end
%С������ȥ����Ư��
for i = 1 : ch
    oxyData(:,i) = DeBaseline_Wavelet(oxyData(:,i));
end
%% ����Ԥ���� �����
% %��ȡ����
% oxyData = nirs_data.oxyData(:,2);
% dxyData = nirs_data.dxyData(:,2);
% tHbData = nirs_data.tHbData(:,2);
% figure(1),title('ԭʼ����');
% plot(oxyData,'r'),hold on,
% plot(dxyData,'b'),hold on,
% plot(tHbData,'g'),hold on,
% %�²���
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
% title('��ͨ�˲��������');
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
% title('��������ȥ����Ư��'),
% axis([0,length(oxyData),-0.02,0.02]);
% 
% oxyData = DeBaseline_Wavelet(oxyData);
% dxyData = DeBaseline_Wavelet(dxyData);
% tHbData = DeBaseline_Wavelet(tHbData);
% subplot(313);
% plot(oxyData,'r'),hold on,
% plot(dxyData,'b'),hold on,
% plot(tHbData,'g');
% title('С������ȥ����Ư��');
% axis([0,length(oxyData),-0.02,0.02]);
%% �Ե����ͼʵ�� + ICA ����ܷ���
% display = nirs_data.oxyData(:,1);
% for i = 2 : 57
%         display  = [display ; nirs_data.oxyData(:,i)];
% end
% topoplotEEG(display,'bp1.txt','electrodes','labels','maplimits',[0,0.1]);%yy����������ݣ�yy��������
% % ICA
% level = 57; %ICA�ֲ����������Ϊͨ����
% fs = 10;
% % [Zica,A,W] = fastica(nirs_data.oxyData,'numOfIC', level);
%  figure(1),plot_ICAs(W,fs);
% display = W(:,1);
% for i = 2 : 57
%         display  = [display ; W(:,i)];
% end
% figure(2),topoplotEEG(display,'bp1.txt','electrodes','labels','maplimits',[0,0.1]);%yy����������ݣ�yy��������
%% �������� ��ͨ��
oxyData2 = oxyData(:,2);
% %С������
% fs = 10;
% len = length(oxyData2);
% t = 1:len;
% [cfs,f] = cwt(oxyData2,'bump',fs);
% cwt(oxyData2);
% % pcolor(t,f,abs(cfs));shading interp

% %�����׷���
% Fs = 10;
% xn = oxyData2;
% nfft=1024;
% 
% window=boxcar(100); %���δ�
% window1=hamming(100); %������
% window2=blackman(100); %blackman��
% noverlap=20; %�������ص�
% range='half'; %Ƶ�ʼ��Ϊ[0 Fs/2]��ֻ����һ���Ƶ��
% [Pxx,f]=pwelch(xn,window,noverlap,nfft,Fs,range);
% [Pxx1,f1]=pwelch(xn,window1,noverlap,nfft,Fs,range);
% [Pxx2,f2]=pwelch(xn,window2,noverlap,nfft,Fs,range);
% plot_Pxx=10*log10(Pxx);
% plot_Pxx1=10*log10(Pxx1);
% plot_Pxx2=10*log10(Pxx2);
% 
% subplot(311);
% plot(f,plot_Pxx);
% title('���δ�');
% subplot(312);
% plot(f1,plot_Pxx1);
% title('������');
% subplot(313);
% plot(f2,plot_Pxx2);
% title('blackman��');

% %��ʱ����Ҷ����
% win_sz = 128;
% % han_win = hanning(win_sz);      % ѡ������
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
%% ������ȡ ����
%% ������������ȡ
% % �������㷨���Դ���
% m = 2;           % ģʽά��
% r_factor = 0.2; % ��������ϵ��

% % �����źŵ��źŽ�����ֵ
% signal = oxyData;
% ApEn_value_x = ApEn(signal(100:200),m,r_factor) % �źŽ�����ֵ
% % �����źŵ��Ӱ��������źŽ�����ֵ
% signal = f;
% ApEn_value_f = ApEn(signal(100:200),m,r_factor) % �źŽ�����ֵ

% %�������㷨���Դ���
% r_factor = 0.2 * std(oxyData); % ��ֵ��С
% signal = oxyData;
% SampEn_value_x = SampEn(signal(100:200),m,r_factor) % �ź�������ֵ
% % �����źŵ��Ӱ��������źŽ�����ֵ
% signal = f;
% SampEn_value_f = SampEn(signal(100:200),m,r_factor) % �ź�������ֵ

%��߶�������
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
%% ͳ��������ȡ
% % ��ֵ
% mean_val = mean(oxyData);
% % ��׼��
% std_val = std(oxyData);
% % ƫ�� , >0 ��ƫ̬
% skewness_val = skewness(oxyData);
% % �Ͷ� ,>0 ���̬ ��̬�ֲ���� = 0
% kurtosis_val = kurtosis(oxyData);