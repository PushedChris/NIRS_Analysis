function y = DeBaseline_Wavelet(X)

% size_x = length(x);
% size_rx = 2^(nextpow2(size_x)-1);
% 
% % resampling X
% Xo = resample(x, size_rx, size_x, 0);

maxlev=11;                       %分解6尺度
[C,L] = wavedec(X,maxlev,'coif3');
A7=appcoef(C,L,'coif3',maxlev);%最后一个参数为7

D1=detcoef(C,L,1);
D2=detcoef(C,L,2);
D3=detcoef(C,L,3);
D4=detcoef(C,L,4);
D5=detcoef(C,L,5);
D6=detcoef(C,L,6);
D7=detcoef(C,L,7);
D8=detcoef(C,L,8);
D9=detcoef(C,L,9);
D10=detcoef(C,L,10);
D11=detcoef(C,L,11);
 
 %将第一尺度置零
%  D1= zeros(1,length(D1));
%  D2= zeros(1,length(D2));
 A7=zeros(1,length(A7));
 C2 = [A7,D11',D10',D9',D8',D7',D6',D5',D4',D3',D2',D1'];  %
 s2 = waverec(C2,L,'coif3');
%  subplot(312);
%  title('the denosed signal');
%  subplot(311);
%  plot(s,'k');
%  title('the original signal');
y = s2;
