clear;
clc;

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

Data = oxyData;

n=3;
wpname='db3';
Data=Data-mean(Data);
Data=detrend(Data);
wpt1=wpdec(Data,n,wpname); %对数据进行小波包分解
for i=1:2^n %wpcoef(wpt1,[n,i-1])是求第n层第i个节点的系数
E(i)=norm(wpcoef(wpt1,[n,i-1]),2);%求第i个节点的范数平方，其实也就是平方和
end
% disp('每个节点的能量E(i)');
% E
% disp('小波包分解总能量E_total');
E_total=sum(E); %求总能量
for i=1:2^n
pfir(i)= E(i)/E_total;%求每个节点的概率
end
pfir