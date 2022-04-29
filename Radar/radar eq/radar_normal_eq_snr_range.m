%%�����״﷽�̣�������snr�仯����ͼ
clear all;

%% �״﷽�̲���
snr = linspace(-5, 45, 1000);
pt = 1.5e6;
freq = 5.6e9;
g = 45;
loss = 6;
nf = 3;
b = 5e6;
sigma = 0.1;

%% �����״﷽��������̽�����
range = radar_normal_eq(pt, freq, g, sigma, b, nf, loss, snr);

%% ���Ʋ���
figure(1)
plot(snr, range ./ 1000);
grid on;
ylabel('Detection range - Km');
xlabel('SNR - dB');