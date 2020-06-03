fs=2^6;    %����Ƶ��
dt=1/fs;    %ʱ�侫��
timestart=-8;
timeend=8;
t=(0:(timeend-timestart)/dt-1)*dt+timestart;
L=length(t);
z=4*sin(2*pi*linspace(6,12,L).*t);

%������㷶Χ�;���
fmin=2;
fmax=20;
df=0.1;
totalscal=(fmax-fmin)/df;
f=fmin:df:fmax-df;%Ԥ�ڵ�Ƶ��
wcf=centfrq(wavename); %С��������Ƶ��
scal=fs*wcf./f;

%�Լ�ʵ�ֵ�С������
coefs2=cwt_cmor(z,1,3,f,fs);
figure(3)
pcolor(t,f,abs(coefs2));shading interp


%�����Ǻ���
function coefs=cwt_cmor(z,Fb,Fc,f,fs)
%1 С���Ĺ�һ�ź�׼��
z=z(:)';%ǿ�б��y����������ǰ�����
L=length(z);
%2 ����߶�
scal=fs*Fc./f;

%3����С��
shuaijian=0.001;%ȡС��˥������Ϊ1%
tlow2low=sqrt(Fb*log(1/shuaijian));%����cmor˥����1%ʱ��ʱ�䳤�ȣ��ҽ�cmor�ı��ʽ

%3С���Ļ��ֺ���
iter=10;%С�����������仮�־���
xWAV=linspace(-tlow2low,tlow2low,2^iter);
stepWAV = xWAV(2)-xWAV(1);
val_WAV=cumsum(cmorwavf(-tlow2low,tlow2low,2^iter,Fb,Fc))*stepWAV;
%���ǰ׼��
xWAV = xWAV-xWAV(1);
xMaxWAV = xWAV(end);
coefs     = zeros(length(scal),L);%Ԥ����coefs

%4С�����źŵľ��
for k = 1:length(scal)    %һ��scalһ��
    a_SIG = scal(k); %a����һ�еĳ߶Ⱥ���

    j = 1+floor((0:a_SIG*xMaxWAV)/(a_SIG*stepWAV));
        %j�����ֵΪ��ȷ���ģ��߶�Խ�󣬻��ֵ�Խ�ܡ��൱�ڰ�һ��С�������Խ����
    if length(j)==1 , j = [1 1]; end
    
    waveinscal = fliplr(val_WAV(j));%�ѻ���ֵ��չ��j���䣬Ȼ�����ҵߵ���fΪ���³߶ȵĻ���С������
    
    %5 ����Ҫ��һ�� wkeep1ȡdiff(wconv1(ySIG,f))�ﳤ��ΪlenSIG���м�һ��
    %conv(ySIG,f)�����
    coefs(k,:) = -sqrt(a_SIG)*wkeep1(diff(conv2(z,waveinscal, 'full')),L);
    %
end
end
