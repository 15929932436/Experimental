function [ range ] = radar_normal_eq(pt, freq, g, sigma, b, nf, loss, snr)

c = 3.0e+8;
lambda = c / freq;
lambda_sqdb = 10 * log10(lambda^2);
p_peak = 10 * log10(pt);
sigmadb = 10 * log10(sigma);

four_pi_cub = 10 * log10((4.0 * pi)^3);
k_db = 10 * log10(1.38e-23);
to_db = 10 * log10(290);
b_db = 10 * log10(b);

range_4_db = p_peak + g + g + lambda_sqdb + sigmadb - (four_pi_cub + k_db + to_db + b_db + + nf + loss + snr);
range_4 = 10 .^ (range_4_db / 10);

range = range_4 .^ (1/4);
end
