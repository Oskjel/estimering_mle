%% Main function
x = complex(zeros(N, length(SNR_dB)));
w = complex(zeros(N, length(SNR_dB)));

% Generating FFT
fft_list = cell(length(SNR_dB), length(M));

% Allocating space for estimators
omega_hat = zeros(length(SNR_dB), length(M));
phi_hat   = zeros(length(SNR_dB), length(M));

% Generating X 
for j = 1:length(SNR) % Number of different Signal-to-Noise ratios
    w(:,j) = mu_w + sigma_w(j) * (randn(N,1) + 1i*randn(N,1)) / sqrt(2);
    x(:,j) = A * exp(1i * (w_0*n*T + phi)) + w(:, j);
end

% FFT for all signals and FFT-lengths
for j = 1:length(SNR_dB)
    for k = 1:length(M)
        FFT_X = fft(x(:,j), M(k));% fft in matlab takes care of zero padding
        fft_list{j,k} = FFT_X;

        % FFT-based frequency estimate
        [~, m_star] = max(abs(FFT_X));
        m_star = m_star-1; %index correction
        omega_hat(j, k) = (2*pi*m_star)/(M(k)*T);
        
        % FFT-based phase estimate
        F_omega_hat = 1/N * sum(x(:,j) .* exp(-1i*omega_hat(j,k) *n*T));
        phi_hat(j,k) = angle(F_omega_hat);

    end
end






% Plot FFT
j = 6; % pick an SNR index

figure;
hold on;

for k = 1:length(M)
    X = fftshift(fft_list{j,k});
    f = (-M(k)/2:M(k)/2-1)*(F_s/M(k));  % frequency in Hz
    
    plot(f, abs(X));
end

legend("M=" + string(M));
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title(['FFT for SNR = ' num2str(SNR_dB(j)) ' dB']);
grid on;
hold off;

