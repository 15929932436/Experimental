%% �趨�龯���ʺ�����Ȳ���
pfa = 1e-9;
snr = 10;

%% ���Q������Ҫ�Ĳ���a��b
b = sqrt(-2.0 * log(pfa));
a = sqrt(2.0 * 10 ^ (.1 * snr));

%% ����pd
marcumsq(a, b)