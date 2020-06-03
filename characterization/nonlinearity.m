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

f = oxyData + 0.01 * randn(1,length(oxyData))';

% 近似熵算法测试代码
m = 2;           % 模式维数
r_factor = 0.2; % 相似容限系数
% 周期信号的信号近似熵值
signal = oxyData;
ApEn_value_x = ApEn(signal(100:200),m,r_factor) % 信号近似熵值
% 周期信号叠加白噪声的信号近似熵值
signal = f;
ApEn_value_f = ApEn(signal(100:200),m,r_factor) % 信号近似熵值


%样本熵算法测试代码
r_factor = 0.2 * std(oxyData); % 阈值大小
signal = oxyData;
SampEn_value_x = SampEn(signal(100:200),m,r_factor) % 信号样本熵值
% 周期信号叠加白噪声的信号近似熵值
signal = f;
SampEn_value_f = SampEn(signal(100:200),m,r_factor) % 信号样本熵值


%多尺度熵运算
% mse - multi-scale entropy
% sf  - scale factor corresponding to mse
signal = oxyData;
[mse,sf] = MSE_Costa2005(signal,20,m,std(signal)*0.15);
signal = f;
[mse,sf] = MSE_Costa2005(signal,20,m,std(signal)*0.15);

% Plot mse
figure, set(gcf,'Color',[1 1 1]), hold on, pp = []; labfull = {};
set(gca,'FontSize',12)
pp = plot(sf,mse,'-','Color',[0,0,0],'LineWidth',2);
labfull = ['White' ' noise (1/f^{' num2str(0) '})'];
ylim([0 3])
xlabel('Scale')
ylabel('SampEn')
title('Multi-scale entropy')
legend(pp,labfull)
legend('boxoff')