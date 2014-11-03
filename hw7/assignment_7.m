% initialize filter
t = 0;
x = zeros(4,1);
P = diag(ones(1,4) * 10^8); % large covariance P
result = report();

% open data file
fid = fopen('Target1.txt');
% [t, x, P] = get_observation(sscanf(fgetl(fid), '%f'));
% x = [1 0; 0 1; 0 0; 0 0] * x;
% P = [P(1:2) 0 0; P(3:4) 0 0; 0 0 10^8 10^8; 0 0 10^8 10^8];
while ~feof(fid)
    tline = fgetl(fid);
    data = sscanf(tline, '%f');
    
    if ~isempty(data)
        [t_new, z, R] = get_observation(data);
        [t, x, P] = predict(t, x, P, t_new);
        [x, P, vx, vs] = update(x, P, z, R);
        result = result.add_data(vx, vs);
    end
end
% close file
fclose(fid);

result = result.update_estimate(t, x, P);

result.print_final_estimate();
result.print_prediction(t + 3600);
result.plot();
result.print_innovation_sizes_percentage();
