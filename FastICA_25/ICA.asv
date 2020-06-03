clear;
% Vr1=xlsread('E:\Data\5\220Vm.xls','d128:d802');
% HDV1=xlsread('E:\Data\5\220Vm.xls','j128:j802');
% u1=180+xlsread('E:\Data\5\220Vm.xls','k128:k802');
% I1=xlsread('E:\Data\5\220Im.xls','j128:j802');
% i1=xlsread('E:\Data\5\220Im.xls','k128:k802');
Z11=1.4868e+003 -5.0373e+004i;
Vr1=xlsread('E:\Data\5\220Vm.xls','d14:d1897');
HDV1=xlsread('E:\Data\5\220Vm.xls','j14:j1897');
u1=180+xlsread('E:\Data\5\220Vm.xls','k14:k1897');
I1=xlsread('E:\Data\5\220Im.xls','j14:j1897');
i1=xlsread('E:\Data\5\220Im.xls','k14:k1897');
for i=1:length(Vr1)
    V1(i)=Vr1(i)*HDV1(i)*10;
end
%去掉U1中的I1成分
for j=1:length(Vr1)
    Vp1(j)=V1(j)*cosd(u1(j))+1i*V1(j)*sind(u1(j));
    Ip1(j)=I1(j)*cosd(i1(j))+1i*I1(j)*sind(i1(j));
    Vg(j)=Vp1(j)-Z11*Ip1(j);
end
    Vgr=abs(Vg);
    ug=rad2deg(angle(Vg))
% 独立成分分析 %
X=[V1;I1'];
[icasig,A,W]=fastica(X);
xlswrite('E:\ICA\ica5.xlsx',icasig','sheet3','j');
%-----归一化——%
% I2=xlsread('E:\ICA\ica5.xlsx','sheet1','b2:b676');
% I3=xlsread('E:\ICA\ica5.xlsx','sheet1','f2:f676');
% icasig1=premnmx(icasig(1,:));
% icasig2=premnmx(icasig(2,:));
% I2g=premnmx(I2);
% I3g=premnmx(I3);
%  xlswrite('E:\ICA\ica5.xlsx',icasig1','sheet4','a');
%  xlswrite('E:\ICA\ica5.xlsx',icasig2','sheet4','b');
%  xlswrite('E:\ICA\ica5.xlsx',I2g,'sheet4','d');
%  xlswrite('E:\ICA\ica5.xlsx',I3g,'sheet4','e');

% 
MaxS1=max(icasig(1,:));
MinS1=min(icasig(1,:));
MaxS2=max(icasig(2,:));
MinS2=min(icasig(2,:));
for j=1:length(icasig)
    icasig1(1,j)=(icasig(1,j)-MinS1)/(MaxS1-MinS1);
    icasig1(2,j)=(icasig(2,j)-MinS2)/(MaxS2-MinS2);
end

xlswrite('E:\ICA\ica5.xlsx',icasig1','sheet3','a');
% xlswrite('E:\Matlab work\ica.xlsx',A,'sheet3');

I2=xlsread('E:\ICA\ica51.xlsx','sheet1','a2:a1885');
    MaxS2=max(I2);
    MinS2=min(I2);
for i=1:length(I2)
    I2g(i)=(I2(i)-MinS2)/(MaxS2-MinS2);
end
% xlswrite('E:\Matlab work\ica.xlsx',I2,'sheet1','g');
xlswrite('E:\ICA\ica5.xlsx',I2g','sheet3','d');

I3=xlsread('E:\ICA\ica51.xlsx','sheet1','e2:e1885');
 MaxS3=max(I3);
 MinS3=min(I3);
for i=1:length(I3)
    I3g(i)=(I3(i)-MinS3)/(MaxS3-MinS3);
end
% xlswrite('E:\Matlab work\ica.xlsx',I3,'sheet1','j');
xlswrite('E:\ICA\ica5.xlsx',I3g','sheet3','e');

