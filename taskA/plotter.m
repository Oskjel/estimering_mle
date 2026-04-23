%% Plotting
var_e_w_plot = var_e_w;
var_e_w_plot(var_e_w_plot <= 0) = eps;

% Plotting FFT based frequency estimator variance against CRLB
figure;
hold on;
grid on;

for k = 1:length(M)
    semilogy(SNR_dB, var_e_w_plot(:,k), 'o-', 'LineWidth', 1.2);
end

semilogy(SNR_dB, CRLB_w, 'k--', 'LineWidth', 2);

set(gca, 'YScale', 'log');
%ylim([1e-2 1e8]);

xlabel('SNR (dB)');
ylabel('Variance of frequency error');
title('FFT-based frequency estimator variance vs CRLB', 'Interpreter', 'latex');
legend([compose('M = 2^{%d}', 10:2:20), "CRLB"], 'Location', 'southwest');
hold off;

% Plotting FFT based phase estimator variance against CRLB
figure;
hold on;
grid on;

for k = 1:length(M)
    semilogy(SNR_dB, var_e_phi(:,k), 'o-', 'LineWidth', 1.2);
end

semilogy(SNR_dB, CRLB_phi, 'k--', 'LineWidth', 2);

set(gca, 'YScale', 'log');
ylim([1e-10 1e-1]);

xlabel('SNR (dB)');
ylabel('Variance of phase error');
title('FFT-based phase estimator variance vs CRLB', 'Interpreter', 'latex');
legend([compose('M = 2^{%d}', 10:2:20), "CRLB"], 'Location', 'southwest');
hold off;

% MSE frequency vs CRLB
figure;
hold on; grid on;

for k = 1:length(M)
    semilogy(SNR_dB, mse_e_w(:,k), 'o-', 'LineWidth', 1.5);
end

semilogy(SNR_dB, CRLB_w, 'k--', 'LineWidth', 2.5);

set(gca, 'YScale', 'log');
ylim([1e-2 1e8]);

xlabel('SNR (dB)', 'Interpreter', 'latex');
ylabel('$\mathrm{MSE}(\hat{\omega})$', 'Interpreter', 'latex');
title('MSE of FFT-based frequency estimator vs CRLB', 'Interpreter', 'latex');

labels = arrayfun(@(m) sprintf('$M = 2^{%d}$', log2(m)), M, 'UniformOutput', false);
legend([labels, {'CRLB'}], 'Interpreter', 'latex', 'Location', 'southwest');

hold off;

% MSE phase vs CRLB
figure;
hold on; grid on;

for k = 1:length(M)
    semilogy(SNR_dB, mse_e_phi(:,k), 'o-', 'LineWidth', 1.5);
end

semilogy(SNR_dB, CRLB_phi, 'k--', 'LineWidth', 2.5);

set(gca, 'YScale', 'log');
ylim([1e-10 1e-1]);

xlabel('SNR (dB)', 'Interpreter', 'latex');
ylabel('$\mathrm{MSE}(\hat{\phi})$', 'Interpreter', 'latex');
title('MSE of FFT-based phase estimator vs CRLB', 'Interpreter', 'latex');

legend([labels, {'CRLB'}], 'Interpreter', 'latex', 'Location', 'southwest');

hold off;