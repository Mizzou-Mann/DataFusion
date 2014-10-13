% initialize filter
x = [0; 0; 0];
P = diag(ones(1,3) * 10^8); % large covariance P
normalized_innovation = [];

% open data file
fid = fopen('A5-MeasurementData.txt');
row = 0;
while ~feof(fid)
    row = row + 1;
    [z, R, H] = getObservation(fid);
    [x, P, v] = update(x, P, z, R, H);
    normalized_innovation(row) = v(1);
end
% close file
fclose(fid);

% final estimate (x, P)
fprintf('Final mean x =\n%14f %14f %14f\n', x);
fprintf('The final covariance P =\n');
fprintf('%14f %14f %14f\n', P);

% plots
figure
plot(normalized_innovation)
title('Normalized innovation')

figure
plot(randn(row, 1))
title('Randn')