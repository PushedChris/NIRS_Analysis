clear;clc;
% 合成数据
t = 0:0.001:0.1;
x = sin(2*pi*50*t)+sin(2*pi*300*t);
f = x + 3.5*randn(1,length(t));
subplot(2,1,1);plot(x);
xlabel('(a)周期信号 ');
subplot(2,1,2);plot(f);
xlabel('(b)周期信号叠加白噪声 ');
% 近似熵算法测试代码
m = 2;           % 模式维数
r_factor = 0.2; % 相似容限系数
% 周期信号的信号近似熵值
signal = x;
ApEn_value_x = ApEn(signal,m,r_factor) % 信号近似熵值
% 周期信号叠加白噪声的信号近似熵值
signal = f;
ApEn_value_f = ApEn(signal,m,r_factor) % 信号近似熵值