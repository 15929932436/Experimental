clc
clear all
close all

pt = 1.5e6;
g = 45;
freq = 5.6e9;
sigma = 0.1;
b = 5e6;
nf = 3;
loss = 6;
snr = 20;

radar_normal_eq(pt, freq, g, sigma, b, nf, loss, snr)