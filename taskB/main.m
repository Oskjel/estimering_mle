%% Main function
x = zeros(N, length(SNR_dB));

% Allocating space for estimation errors
e_w_list   = zeros(N_realizations, length(SNR_dB));
e_phi_list = zeros(N_realizations, length(SNR_dB));

for r = 1:N_realizations
    for j = 1:length(SNR_dB)
        w = mu_w + sigma_w(j) * (randn(N,1) + 1i*randn(N,1));
        x(:,j) = A * exp(1i*(w_0*n*T + phi)) + w;

        % Coarse FFT estimate
        FFT_X = fft(x(:,j), M);
        [~, m_star] = max(abs(FFT_X));
        m_star = m_star - 1;
        w_init_guess = (2*pi*m_star)/(M*T);

        % Refine by maximizing |F(omega)| <=> minimizing -|F(omega)|
        object_func = @(w) -abs((1/N) * sum(x(:,j) .* exp(-1i*w*n_loc*T)));
        options = optimset('Display','off');
        w_hat_curr = fminsearch(object_func, w_init_guess, options);

        % Phase estimate
        F_w_hat = (1/N) * sum(x(:,j) .* exp(-1i*w_hat_curr*n_loc*T));
        phi_hat_curr = angle(exp(-1i*w_hat_curr*n_0*T) * F_w_hat);

        % Finding estimator error
        e_w_list(r, j)   = w_0 - w_hat_curr;
        e_phi_list(r, j) = angle(exp(1i * (phi - phi_hat_curr)));
    end
end

% Finding estimator error variance and bias
bias_e_w = squeeze(mean(e_w_list, 1));
var_e_w  = squeeze(var(e_w_list, 0, 1));
mse_e_w  = squeeze(mean(e_w_list.^2, 1));

bias_e_phi = squeeze(mean(e_phi_list, 1));
var_e_phi  = squeeze(var(e_phi_list, 0, 1));
mse_e_phi  = squeeze(mean(e_phi_list.^2, 1));
