close all;
clear all;

%% �趨�龯���ʺ�����Ȳ���
pfa = 1e-9;
snr = 14;

%% ���Q������Ҫ�Ĳ���a��b
b = sqrt(-2.0 * log(pfa));
a = sqrt(2.0 * 10 ^ (.1 * snr));

%% ����Q���������̽�����
index = 0;
for snr = 0: .1 : 20
    index = index + 1;
    a = sqrt(2.0 * 10 ^ (.1 * snr));
    pro(index) = marcumsq(a, b);
end

%% ����ͼ��
x = 0 : .1 : 20;
plot(x, pro);
axis([0 20 0 1]);
xlabel('SNR - dB');
ylabel('Probility of detection');
grid on
