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

% 均值
mean_val = mean(oxyData)
% 标准差
std_val = std(oxyData)
% 偏度 , >0 右偏态
skewness_val = skewness(oxyData)
% 峭度 ,>0 尖峰态 正态分布峰度 = 0
kurtosis_val = kurtosis(oxyData)
