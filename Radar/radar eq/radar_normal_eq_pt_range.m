%%�����״﷽�̣������淢�书�ʱ仯����ͼ
clear all;


%% �״﷽�̲���
snr = 20;
pt = linspace(0.5e6, 10.5e6, 1000);
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
plot(pt ./ 1000000, range ./ 1000);
grid on;
ylabel('Detection range - Km');
xlabel('Pt - Mw');