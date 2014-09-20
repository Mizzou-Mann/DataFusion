data_size = 100000;

% read data file
fid = fopen('A3-MeasurementData.bin');
measurement_data = fread(fid, [3, data_size], 'float');
fclose(fid);

% calculate covariance matrix
expected_value = mean(measurement_data, 2);
% % use ones() to generate the consistent dimensions for matrix subtraction
measurement_error = measurement_data - expected_value * ones(1, data_size);
% % the sum of many square matrice M * M' = [M list] * [M list]'
measurement_covariance = measurement_error * measurement_error' / (data_size - 1);

% verify covariance
sensor_covariance = [1 1 1 ; 1 2 2 ; 1 2 3];
eigenvalues = eig(sensor_covariance - measurement_covariance);
fprintf('Expected value = [%f %f %f]\n', expected_value);
fprintf('Eigenvalues = [%f %f %f]\n', eigenvalues);