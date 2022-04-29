%%基本雷达方程，距离随发射功率变化曲线图
clear all;


%% 雷达方程参数
snr = 20;
pt = linspace(0.5e6, 10.5e6, 1000);
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
plot(pt ./ 1000000, range ./ 1000);
grid on;
ylabel('Detection range - Km');
xlabel('Pt - Mw');