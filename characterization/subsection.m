clear;
clc;

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

Data = oxyData;

n=3;
wpname='db3';
Data=Data-mean(Data);
Data=detrend(Data);
wpt1=wpdec(Data,n,wpname); %�����ݽ���С�����ֽ�
for i=1:2^n %wpcoef(wpt1,[n,i-1])�����n���i���ڵ��ϵ��
E(i)=norm(wpcoef(wpt1,[n,i-1]),2);%���i���ڵ�ķ���ƽ������ʵҲ����ƽ����
end
% disp('ÿ���ڵ������E(i)');
% E
% disp('С�����ֽ�������E_total');
E_total=sum(E); %��������
for i=1:2^n
pfir(i)= E(i)/E_total;%��ÿ���ڵ�ĸ���
end
pfir