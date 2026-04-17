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





% Plot FFT
j = 4; % pick an SNR index

figure;
hold on;

for k = 1:length(M)
    X = fftshift(fft_list{j,k});
    f = (-M(k)/2:M(k)/2-1)*(Fs/M(k));  % frequency in Hz
    
    plot(f, abs(X));
end

legend("M=" + string(M));
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title(['FFT for SNR = ' num2str(SNR_dB(j)) ' dB']);
grid on;
hold off;

