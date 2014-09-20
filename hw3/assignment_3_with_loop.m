data_size = 100000;

% read data file
fid = fopen('A3-MeasurementData.bin');
measurement_data = fread(fid, [3, data_size], 'float');
fclose(fid);

% % calculate covariance matrix
square_errors_sum = zeros(3,3);
expected_measurement = mean(measurement_data, 2);

for i=1:data_size
    error = measurement_data(:,i) - expected_measurement;
    square_errors_sum = square_errors_sum + (error * error');
end
measurement_covariance = square_errors_sum / (data_size - 1);

% verify covariance
sensor_covariance = [1 1 1 ; 1 2 2 ; 1 2 3];
eig(sensor_covariance - measurement_covariance)