clear;clc;
% �ϳ�����
t = 0:0.001:0.1;
x = sin(2*pi*50*t)+sin(2*pi*300*t);
f = x + 3.5*randn(1,length(t));
subplot(2,1,1);plot(x);
xlabel('(a)�����ź� ');
subplot(2,1,2);plot(f);
xlabel('(b)�����źŵ��Ӱ����� ');
% �������㷨���Դ���
m = 2;           % ģʽά��
r_factor = 0.2; % ��������ϵ��
% �����źŵ��źŽ�����ֵ
signal = x;
ApEn_value_x = ApEn(signal,m,r_factor) % �źŽ�����ֵ
% �����źŵ��Ӱ��������źŽ�����ֵ
signal = f;
ApEn_value_f = ApEn(signal,m,r_factor) % �źŽ�����ֵ