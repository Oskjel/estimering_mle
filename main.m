%% Main function
x = complex(zeros(N, length(SNR_dB)));
w = complex(zeros(N, length(SNR_dB)));

% Generating FFT
fft_list = cell(length(M), 1);

% Generating X 
for j = 1:length(SNR) % Number of different Signal-to-Noise ratios
    w(:,j) = mu_w + sigma_w(j) * (randn(1, N)+ 1i*randn(N,1)) / sqrt(2);
    x(:,j) = A * exp(1i * (w0*n*T + phi)) + w(:, j);
 
end
% FFT for each all signals and FFT-lengths
for j = 1:length(SNR)
    for k = 1:length(M)
        fft_list{j,k} = fft(x(:,j), M(k));% fft in matlab takes care of zero padding
    end
end


