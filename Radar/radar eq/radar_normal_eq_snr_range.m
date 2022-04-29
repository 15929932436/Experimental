%%基本雷达方程，距离随snr变化曲线图
clear all;

%% 雷达方程参数
snr = linspace(-5, 45, 1000);
pt = 1.5e6;
freq = 5.6e9;
g = 45;
loss = 6;
nf = 3;
b = 5e6;
sigma = 0.1;

%% 调用雷达方程求出最大探测距离
range = radar_normal_eq(pt, freq, g, sigma, b, nf, loss, snr);

%% 绘制波形
figure(1)
plot(snr, range ./ 1000);
grid on;
ylabel('Detection range - Km');
xlabel('SNR - dB');