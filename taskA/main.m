%% Main function
% Allocating space for the signal
x = zeros(N, length(SNR));

% Allocating space for estimation errors
e_w_list   = zeros(N_realizations, length(SNR_dB), length(M));
e_phi_list = zeros(N_realizations, length(SNR_dB), length(M));

for r = 1:N_realizations
    % Generating signal 
    for j = 1:length(SNR) % Number of different Signal-to-Noise ratios
        w = mu_w + sigma_w(j) * (randn(N,1) + 1i*randn(N,1));
        x(:,j) = A * exp(1i * (w_0*n*T + phi)) + w;
    end
    
    % FFT for all signals and FFT-lengths
    for j = 1:length(SNR_dB)
        for k = 1:length(M)
            FFT_X = fft(x(:,j), M(k));% fft in matlab takes care of zero padding
    
            % FFT-based frequency estimate
            [~, m_star] = max(abs(FFT_X));
            m_star = m_star-1; %index correction
            w_hat = (2*pi*m_star)/(M(k)*T);
            
            % FFT-based phase estimate
            F_w_hat = 1/N * sum(x(:,j) .* exp(-1i*w_hat *n_loc*T));
            phi_hat = angle(exp(-1i*w_hat*n_0*T) * F_w_hat);

            % Finding estimator error
            e_w_list(r, j, k)   = w_0 - w_hat;
            e_phi_list(r, j, k) = angle(exp(1i * (phi - phi_hat)));
        end
    end
end

% Finding estimator error variance and bias
bias_e_w = squeeze(mean(e_w_list, 1));
var_e_w  = squeeze(var(e_w_list, 0, 1));
mse_e_w  = squeeze(mean(e_w_list.^2, 1));

bias_e_phi = squeeze(mean(e_phi_list, 1));
var_e_phi  = squeeze(var(e_phi_list, 0, 1));
mse_e_phi  = squeeze(mean(e_phi_list.^2, 1));
