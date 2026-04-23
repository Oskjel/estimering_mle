%% Plotting
var_e_w_plot = var_e_w;
var_e_w_plot(var_e_w_plot <= 0) = eps;

var_e_phi_plot = var_e_phi;
var_e_phi_plot(var_e_phi_plot <= 0) = eps;

mse_e_w_plot = mse_e_w;
mse_e_w_plot(mse_e_w_plot <= 0) = eps;

mse_e_phi_plot = mse_e_phi;
mse_e_phi_plot(mse_e_phi_plot <= 0) = eps;

% Variance of frequency error vs CRLB
figure;
hold on;
grid on;

semilogy(SNR_dB, var_e_w_plot, 'o-', 'LineWidth', 1.2);
semilogy(SNR_dB, CRLB_w, 'k--', 'LineWidth', 2);

set(gca, 'YScale', 'log');
ylim([1e-2 1e6]);

xlabel('SNR (dB)');
ylabel('Variance of frequency error');
title('FFT-based frequency estimator variance vs CRLB, $M = 2^{10}$', 'Interpreter', 'latex');
legend(sprintf('M = 2^{%d}', log2(M)), 'CRLB', 'Location', 'southwest');
hold off;

% Variance of phase error vs CRLB
figure;
hold on;
grid on;

semilogy(SNR_dB, var_e_phi_plot, 'o-', 'LineWidth', 1.2);
semilogy(SNR_dB, CRLB_phi, 'k--', 'LineWidth', 2);

set(gca, 'YScale', 'log');
ylim([1e-10 1e-1]);

xlabel('SNR (dB)');
ylabel('Variance of phase error');
title('FFT-based phase estimator variance vs CRLB, $M = 2^{10}$', 'Interpreter', 'latex');
legend(sprintf('M = 2^{%d}', log2(M)), 'CRLB', 'Location', 'southwest');
hold off;

% MSE of frequency error vs CRLB
figure;
hold on;
grid on;

semilogy(SNR_dB, mse_e_w_plot, 'o-', 'LineWidth', 1.5);
semilogy(SNR_dB, CRLB_w, 'k--', 'LineWidth', 2.5);

set(gca, 'YScale', 'log');
ylim([1e-2 1e6]);

xlabel('SNR (dB)', 'Interpreter', 'latex');
ylabel('$\mathrm{MSE}(\hat{\omega})$', 'Interpreter', 'latex');
title('MSE of FFT-based frequency estimator vs CRLB, $M = 2^{10}$', 'Interpreter', 'latex');
legend(sprintf('$M = 2^{%d}$', log2(M)), 'CRLB', ...
       'Interpreter', 'latex', 'Location', 'southwest');
hold off;

% MSE of phase error vs CRLB
figure;
hold on;
grid on;

semilogy(SNR_dB, mse_e_phi_plot, 'o-', 'LineWidth', 1.5);
semilogy(SNR_dB, CRLB_phi, 'k--', 'LineWidth', 2.5);

set(gca, 'YScale', 'log');
ylim([1e-10 1e-1]);

xlabel('SNR (dB)', 'Interpreter', 'latex');
ylabel('$\mathrm{MSE}(\hat{\phi})$', 'Interpreter', 'latex');
title('MSE of FFT-based phase estimator vs CRLB, $M = 2^{10}$', 'Interpreter', 'latex');
legend(sprintf('$M = 2^{%d}$', log2(M)), 'CRLB', ...
       'Interpreter', 'latex', 'Location', 'southwest');
hold off;