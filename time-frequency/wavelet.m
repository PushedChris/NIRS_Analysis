clear;
data = load('convert.mat');
nirs_data = data.nirs_data;
ch = 2;
%¶ÁÈ¡Êý¾Ý
oxyData = nirs_data.oxyData(:,ch);
dxyData = nirs_data.dxyData(:,ch);
tHbData = nirs_data.tHbData(:,ch);

oxyData=resample(oxyData,100,167);
dxyData=resample(dxyData,100,167);
tHbData=resample(tHbData,100,167);

fs = 10;
len = length(oxyData);
t = 1:len;
[cfs,f] = cwt(oxyData,'bump',fs);
% cwt(oxyData);
pcolor(t,f,abs(cfs));shading interp

% https://blog.csdn.net/weixin_42943114/article/details/89603208