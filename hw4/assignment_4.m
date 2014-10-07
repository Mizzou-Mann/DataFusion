data_size = 100000;

% read data file
fid = fopen('A3-MeasurementData.bin');
measurement_data = fread(fid, [3, data_size], 'float');
fclose(fid);

ground_truth = [12.9; 130.4; 23.5];
% first observation (z, R)
z = measurement_data(:, 1);
R = [1 1 1; 1 2 2; 1 2 3];
fprintf('First observation mean z =\n%14f %14f %14f\n', z);
fprintf('The square root of covariance matrix R =\n');
fprintf('%14f %14f %14f\n', sqrtm(R));

% initialize filter
x = z;
P = R;
plot_size = 100;
innovation = zeros(plot_size, 9);
distance = zeros(plot_size, 2);
for i=2:data_size
    S = R + P;
    W = P / S;
    P = P - W * S * W';
    deviation = measurement_data(:, i) - x;
    x = x + W * (deviation);
    if i - 1 <= plot_size
        % innovation
        variance = sqrt(diag(S));
        innovation(i - 1, :) = [deviation' variance' (variance * -1)'];
        % distance
        distance(i - 1, 1) = sqrt(sum((x - ground_truth).^2)); % euclidean distance
        distance(i - 1, 2) = sum(eig(P)); % sum of eiganvalues of P
    end
end

% final estimate (x, P)
fprintf('Final mean x =\n%14f %14f %14f\n', x);
fprintf('The square root of final covariance P =\n');
fprintf('%14f %14f %14f\n', sqrtm(P));

figure
plot(innovation(:, [1 4 7]))
title('Innovation in x (blue) vs. +/- square roots of their innovation variances')

figure
plot(innovation(:, [2 5 8]))
title('Innovation in y (blue) vs. +/- square roots of their innovation variances')

figure
plot(innovation(:, [3 6 9]))
title('Innovation in z (blue) vs. +/- square roots of their innovation variances')

figure
plot(distance)
title('Distance between estimated position and ground truth (blue) vs. expected distance (green)')