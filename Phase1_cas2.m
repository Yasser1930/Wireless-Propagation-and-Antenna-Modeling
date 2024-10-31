load('Fichier2.mat');

figure;
plot(x, z, '-');
xlabel('Distance (m)');
ylabel('Power (dBm)');
title('Power Profile');

window_size = 50; %%%%
smoothed_z = movmean(z, window_size);

hold on;
plot(x, smoothed_z, 'r-', 'LineWidth', 1);
legend('Original', 'Smoothed');

% plot fast variations
fast_variations = z - smoothed_z;

figure;
plot(x, fast_variations, '-');
xlabel('Distance (m)');
ylabel('Fast Variations (dB)');
title('Profile of Fast Variations');


frequency = 37.2e9; % 37.2 GHz
speed_of_light = 3e8;
wavelength = speed_of_light / frequency;

lambda_interval = 20 * wavelength;

local_average_z = movmean(z, round(lambda_interval / mean(diff(x))));

degree_of_regression = 1; % Linear regression
p = polyfit(x, local_average_z, degree_of_regression);

figure;
plot(x, z, '-', 'DisplayName', 'Original Power Profile');
hold on;
plot(x, smoothed_z, 'r-', 'LineWidth', 2, 'DisplayName', 'Smoothed Profile');
plot(x, local_average_z, 'g-', 'LineWidth', 2, 'DisplayName', 'Local Averages');
plot(x, polyval(p, x), 'Y-', 'LineWidth', 2, 'DisplayName', 'Linear Regression');
xlabel('Distance (m)');
ylabel('Power (dBm)');
title('Linear Regression on Local Averages');
legend;

gradient_n = p(1);

variance_sigma_squared = var(z - local_average_z);

disp(['Gradient (n): ' num2str(gradient_n)]);
disp(['Variance (σ^2): ' num2str(variance_sigma_squared)]);


figure;
plot(x, (z - local_average_z).^2, '-');  % Squaring the residuals to get variance
xlabel('Distance (m)');
ylabel('Squared Residuals');
title('Variance as a Function of Distance');


%A higher variance suggests greater variability or dispersion of data points around the fitted regression line
%The negative gradient indicates a decreasing trend in the power profile with respect to distance. 