%% 设定虚警概率和信噪比参数
pfa = 1e-9;
snr = 10;

%% 求出Q函数需要的参数a和b
b = sqrt(-2.0 * log(pfa));
a = sqrt(2.0 * 10 ^ (.1 * snr));

%% 计算pd
marcumsq(a, b)