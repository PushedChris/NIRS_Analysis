clear;
data = load('convert.mat');
nirs_data = data.nirs_data;
ch = 2;
%��ȡ����
oxyData = nirs_data.oxyData(:,ch);
dxyData = nirs_data.dxyData(:,ch);
tHbData = nirs_data.tHbData(:,ch);

oxyData=resample(oxyData,100,167);
dxyData=resample(dxyData,100,167);
tHbData=resample(tHbData,100,167);

% ��ֵ
mean_val = mean(oxyData)
% ��׼��
std_val = std(oxyData)
% ƫ�� , >0 ��ƫ̬
skewness_val = skewness(oxyData)
% �Ͷ� ,>0 ���̬ ��̬�ֲ���� = 0
kurtosis_val = kurtosis(oxyData)
