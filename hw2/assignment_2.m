fieldium_ground_truth = 31.006277;
fieldium_measurements = read_binary_float('A2-CalibrationData.bin');
cerrolodium_measurements = read_binary_float('A2-MeasurementData.bin');

bias = fieldium_ground_truth - mean(fieldium_measurements);
% SD should be the combined standard deviation to process optimal estimate
fieldium_var = var(fieldium_measurements);
fieldium_size = length(fieldium_measurements);
cerrolodium_var = var(cerrolodium_measurements);
cerrolodium_size = length(cerrolodium_measurements);

total_variances = fieldium_var*(fieldium_size-1) + cerrolodium_var*(cerrolodium_size-1);
sd = sqrt(total_variances/(fieldium_size+cerrolodium_size-1));

unbiased_mean = mean(cerrolodium_measurements) + bias;

% Output
fprintf('Bias = %0.6f\n', bias);
fprintf('Standard deviation = %0.6f\n', sd);
fprintf('Estimate melting point of cerrolodium = (%0.6f, %0.6f)\n', unbiased_mean, sd);