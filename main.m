%% Main function
x = complex(zeros(N, length(SNR_dB)));
w = complex(zeros(N, length(SNR_dB)));

% Allocating space for FFTs
fft_list = cell(length(SNR_dB), length(M));

% Allocating space for estimators
w_hat   = zeros(length(SNR_dB), length(M));
phi_hat = zeros(length(SNR_dB), length(M));

% Allocating space for estimation errors
e_w_list   = zeros(N_realizations, length(SNR_dB), length(M));
e_phi_list = zeros(N_realizations, length(SNR_dB), length(M));

for r = 1:N_realizations
    % Generating signal 
    for j = 1:length(SNR) % Number of different Signal-to-Noise ratios
        w(:,j) = mu_w + sigma_w(j) * (randn(N,1) + 1i*randn(N,1));
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
            w_hat(j, k) = (2*pi*m_star)/(M(k)*T);
            
            % FFT-based phase estimate
            F_w_hat = 1/N * sum(x(:,j) .* exp(-1i*w_hat(j,k) *n*T));
            phi_hat(j,k) = angle(exp(-1i*w_hat(j,k)*n_0*T) * F_w_hat);

            % Finding estimator error
            e_w_list(r, j, k)   = w_0 - w_hat(j,k);
            e_phi_list(r, j, k) = angle(exp(1i * (phi - phi_hat(j,k))));
        end
    end
end

% Finding estimator error variance
var_e_w   = squeeze(var(e_w_list, 0, 1));
var_e_phi = squeeze(var(e_phi_list, 0, 1));

% Plotting FFT based estimator variance against CRLB
figure;
hold on;
grid on;

for k = 1:length(M)
    semilogy(SNR_dB, var_e_w(:,k), 'o-', 'LineWidth', 1.2);
end

semilogy(SNR_dB, CRLB_w, 'k--', 'LineWidth', 2);

xlabel('SNR (dB)');
ylabel('Variance of frequency error');
title('FFT-based frequency estimator variance vs CRLB');
legend([compose('M = 2^{%d}', 10:2:20), "CRLB"], 'Location', 'southwest');
hold off;

