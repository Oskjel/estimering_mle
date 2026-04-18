%% Declaration of constants
% Sampling frequency and period
F_s = 10^6;
T = 10^(-6);

% Sampling parameters
N = 513;
n_0 = -256;
n = (n_0:n_0+N-1).';
N_realizations = 10;

% Signal frequency, phase and amplitude
f_0 = 10^5;
w_0 = 2*pi*f_0;
phi = pi/8;
A = 1;

% SNR_dB to snr
SNR_dB = [-10 0 10 20 30 40 50 60];
SNR = 10.^(SNR_dB/10);

% Noise parameters
mu_w = 0;
sigma_w = sqrt((0.5 * A^2) ./ SNR);

% CRLB
P = N * (N-1) / 2;
Q = N * (N-1) * (2*N-1) / 6;
CRLB_w = 12 * sigma_w.^2 / (A^2*T^2*N*(N^2 - 1));
CRLB_phi = 12 * sigma_w.^2 * (n_0^2*N + 2*n_0*P + Q) / (A^2*N^2*(N^2 - 1));

% FFT size
k = [10 12 14 16 18 20];
M = 2.^k;
