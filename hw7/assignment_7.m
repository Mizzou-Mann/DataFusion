% initialize filter
t = 0;
x = zeros(4,1);
P = diag(ones(1,4) * 10^8); % large covariance P
normalized_innovations = [];

% open data file
fid = fopen('Target1.txt');
% [t, x, P] = get_observation(sscanf(fgetl(fid), '%f'));
% x = [1 0; 0 1; 0 0; 0 0] * x;
% P = [P(1:2) 0 0; P(3:4) 0 0; 0 0 10^8 10^8; 0 0 10^8 10^8];
while ~feof(fid)
    tline = fgetl(fid);
    data = sscanf(tline, '%f');
    
    if ~isempty(data)
        [tz, z, R] = get_observation(data);
        [t, x, P] = transform(t, x, P, tz);
        [x, P, v] = update(x, P, z, R);
        normalized_innovations(end) = 0;
    end
end
% close file
fclose(fid);

% print final position
template = 'The final position of the target =\n%14f, %14f\n%14f, %14f\n';
standard_deviation = sqrt(diag(P));
fprintf(template, x(1), standard_deviation(1), x(2), standard_deviation(2));

disp('x_final = '); fprintf('%14f \n', x);
disp('P_final = '); fprintf('%14.8f %14.8f %14.8f %14.8f \n', P);

% prediction of the state
fprintf('\nThe prediction of the state of the target one hour after the final observation:\n');
[t_new, x_new, P_new] = transform(t, x, P, t + 3600);
disp('x_new = '); fprintf('%14f \n', x_new);
disp('P_new = '); fprintf('%14.8f %14.8f %14.8f %14.8f \n', P_new);
