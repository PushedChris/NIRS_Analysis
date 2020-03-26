fs=2^6;    %采样频率
dt=1/fs;    %时间精度
timestart=-8;
timeend=8;
t=(0:(timeend-timestart)/dt-1)*dt+timestart;
L=length(t);
z=4*sin(2*pi*linspace(6,12,L).*t);

%定义计算范围和精度
fmin=2;
fmax=20;
df=0.1;
totalscal=(fmax-fmin)/df;
f=fmin:df:fmax-df;%预期的频率
wcf=centfrq(wavename); %小波的中心频率
scal=fs*wcf./f;

%自己实现的小波函数
coefs2=cwt_cmor(z,1,3,f,fs);
figure(3)
pcolor(t,f,abs(coefs2));shading interp


%后面是函数
function coefs=cwt_cmor(z,Fb,Fc,f,fs)
%1 小波的归一信号准备
z=z(:)';%强行变成y向量，避免前面出错
L=length(z);
%2 计算尺度
scal=fs*Fc./f;

%3计算小波
shuaijian=0.001;%取小波衰减长度为1%
tlow2low=sqrt(Fb*log(1/shuaijian));%单边cmor衰减至1%时的时间长度，惨叫cmor的表达式

%3小波的积分函数
iter=10;%小波函数的区间划分精度
xWAV=linspace(-tlow2low,tlow2low,2^iter);
stepWAV = xWAV(2)-xWAV(1);
val_WAV=cumsum(cmorwavf(-tlow2low,tlow2low,2^iter,Fb,Fc))*stepWAV;
%卷积前准备
xWAV = xWAV-xWAV(1);
xMaxWAV = xWAV(end);
coefs     = zeros(length(scal),L);%预初设coefs

%4小波与信号的卷积
for k = 1:length(scal)    %一个scal一行
    a_SIG = scal(k); %a是这一行的尺度函数

    j = 1+floor((0:a_SIG*xMaxWAV)/(a_SIG*stepWAV));
        %j的最大值为是确定的，尺度越大，划分的越密。相当于把一个小波拉伸的越长。
    if length(j)==1 , j = [1 1]; end
    
    waveinscal = fliplr(val_WAV(j));%把积分值扩展到j区间，然后左右颠倒。f为当下尺度的积分小波函数
    
    %5 最重要的一步 wkeep1取diff(wconv1(ySIG,f))里长度为lenSIG的中间一段
    %conv(ySIG,f)卷积。
    coefs(k,:) = -sqrt(a_SIG)*wkeep1(diff(conv2(z,waveinscal, 'full')),L);
    %
end
end
