close all;
clear all;

%% 设定虚警概率和信噪比参数
pfa = 1e-9;
snr = 14;

%% 求出Q函数需要的参数a和b
b = sqrt(-2.0 * log(pfa));
a = sqrt(2.0 * 10 ^ (.1 * snr));

%% 带入Q函数，求出探测概率
index = 0;
for snr = 0: .1 : 20
    index = index + 1;
    a = sqrt(2.0 * 10 ^ (.1 * snr));
    pro(index) = marcumsq(a, b);
end

%% 画出图形
x = 0 : .1 : 20;
plot(x, pro);
axis([0 20 0 1]);
xlabel('SNR - dB');
ylabel('Probility of detection');
grid on
