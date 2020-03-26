clear;
Vr1=xlsread('E:\Data\5\220Vm.xls','d128:d802');
HDV1=xlsread('E:\Data\5\220Vm.xls','j128:j802');
u1=180+xlsread('E:\Data\5\220Vm.xls','k128:k802');
I1=xlsread('E:\Data\5\220Im.xls','j128:j802');
i1=xlsread('E:\Data\5\220Im.xls','k128:k802');
Z11=1.4868e+003 -5.0373e+004i;
for i=1:length(Vr1)
    V1(i)=Vr1(i)*HDV1(i)*10;
end
%去掉U1中的I1成分
for j=1:length(Vr1)
    Vp1(j)=V1(j)*cosd(u1(j))+1i*V1(j)*sind(u1(j));
    Ip1(j)=I1(j)*cosd(i1(j))+1i*I1(j)*sind(i1(j));
%     Vg(j)=Vp1(j)-Z11*Ip1(j);
end
%     VgR=real(Vg);
%     VgI=imag(Vg);
%     I1R=real(Ip1);
%     I1I=imag(Ip1);
%     Vp1R=real(Vp1);
%     Vp1I=imag(Vp1);
% 独立成分分析 %
% X=[Vp1R;Vp1I;I1R;I1I];
X=[V1;I1'];
[icasig,A,W]=fastica(X);
xlswrite('E:\ICA\ica51.xlsx',icasig','sheet5','d');
xlswrite('E:\ICA\ica51.xlsx',A,'sheet6','d');
%-----归一化——%
% I2=xlsread('E:\ICA\ica5.xlsx','sheet1','b2:b676');
% I3=xlsread('E:\ICA\ica5.xlsx','sheet1','f2:f676');
% icasig1=premnmx(icasig(1,:));
% icasig2=premnmx(icasig(2,:));
% I2g=premnmx(I2);
% I3g=premnmx(I3);
%  xlswrite('E:\ICA\ica5.xlsx',icasig1','sheet3','a');
%  xlswrite('E:\ICA\ica5.xlsx',icasig2','sheet3','b');
%  xlswrite('E:\ICA\ica5.xlsx',I2g,'sheet3','d');
%  xlswrite('E:\ICA\ica5.xlsx',I3g,'sheet3','e');

% for i=1:2
% MaxS=max(icasig(i,:));
% MinS=min(icasig(i,:));
% for j=1:length(icasig)
%     icasig1(i,j)=(icasig(i,j)-MinS)/(MaxS-MinS);
% end
% end
% 
% xlswrite('E:\ICA\ica5.xlsx',icasig1','sheet5','a');
% % xlswrite('E:\Matlab work\ica.xlsx',A,'sheet3');
% 
% I2=xlsread('E:\ICA\ica5.xlsx','sheet1','b2:b676');
% i2=xlsread('E:\ICA\ica5.xlsx','sheet1','c2:c676');
% for j=1:length(I2)
%     I2(1,j)=I2(j)*cosd(i2(j));
%     I2(2,j)=I2(j)*sind(i2(j));
% end
% for i=1:2
% MaxS2=max(I2(i,:));
% MinS2=min(I2(i,:));
% for j=1:length(I2)
%     I2g(i,j)=(I2(i,j)-MinS2)/(MaxS2-MinS2);
% end
% end
% % xlswrite('E:\Matlab work\ica.xlsx',I2,'sheet1','g');
% xlswrite('E:\ICA\ica5.xlsx',I2g','sheet5','f');
% 
% I3=xlsread('E:\ICA\ica5.xlsx','sheet1','f2:f676');
% i3=xlsread('E:\ICA\ica5.xlsx','sheet1','g2:g676');
% for j=1:length(I3)
%     I3(1,j)=I3(j)*cosd(i3(j));
%     I3(2,j)=I3(j)*sind(i3(j));
% end
% for i=1:2
% MaxS3=max(I3(i,:));
% MinS3=min(I3(i,:));
% for j=1:length(I3)
%     I3g(i,j)=(I3(i,j)-MinS3)/(MaxS3-MinS3);
% end
% end
% % xlswrite('E:\Matlab work\ica.xlsx',I2,'sheet1','g');
% xlswrite('E:\ICA\ica5.xlsx',I3g','sheet5','i');


