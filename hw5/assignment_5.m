% initialize filter
x = zeros(3,1);
P = diag(ones(1,3) * 10^8); % large covariance P
normalized_innovations = [];

% open data file
fid = fopen('A5-MeasurementData.txt');
row = 0;
while ~feof(fid)
    d = fscanf(fid, '%d', 1);
    if ~isempty(d)
        row = row + 1;
        [z, R, H] = getObservation(fid, d);
        [x, P, v] = update(x, P, z, R, H);
        normalized_innovations(row, 1) = v(1);
    end
end
% close file
fclose(fid);

% final estimate (x, P)
fprintf('Final mean x =\n%14f %14f %14f\n', x);
fprintf('The final covariance P =\n');
fprintf('%14f %14f %14f\n', P);

% plots
figure
plot(normalized_innovations)
title('Normalized innovations')

figure
plot(randn(row, 1))
title('Randn')