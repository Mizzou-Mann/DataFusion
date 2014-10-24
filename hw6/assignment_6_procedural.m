% initialize filter
x = zeros(2,1);
P = zeros(2,2);
normalized_innovations = [];
traces = [];
rover_path = [];
innovation_size = 0;

% open data file
fid = fopen('RoverData.txt');
observation_counter = 0;
row = 0;
while ~feof(fid)
    tline = fgetl(fid);
    data = sscanf(tline, '%f');
    
    if ~isempty(data)
        row = row + 1;
        if (data(1) == 0)
            [x, P] = process_control_input(data, x, P);
        else
            observation_counter = observation_counter + 1;
            [z, R, H] = get_observation(data);
            [x, P, v] = update(x, P, z, R, H);
            normalized_innovations(observation_counter, 1) = v(1);
            rover_path(:, observation_counter) = x;
            if v'*v/2 < 1
                innovation_size = innovation_size + 1;
            end
        end
        traces(row, 1) = sqrt(sum(diag(P)));
    end
end
% close file
fclose(fid);

% 1 - plots
figure
plot(normalized_innovations)
title('Normalized innovations')

% 2 - traces
figure
plot(traces)
title('Square root of the trace of rover covariance')

% 3 - rover path
figure
plot(rover_path(1,:), rover_path(2,:), '-o')
title('Rover''s path')
% xlim([495.6 496.4])
% ylim([627.6 628.6])

% 4 - percentage
fprintf('Innovation sizes that are less than 1 = %.2f%%\n', innovation_size/observation_counter * 100);

% 5 - x and std
disp(x)
disp(sqrt(diag(P)))