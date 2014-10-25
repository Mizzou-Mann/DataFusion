% initialize filter
x = zeros(2,1);
P = zeros(2,2);
result = report();

% open data file
fid = fopen('RoverData.txt');
while ~feof(fid)
    tline = fgetl(fid);
    data = sscanf(tline, '%f');
    
    if ~isempty(data)
        if (data(1) == 0)
            [x, P] = process_control_input(data, x, P);
            result = result.add_rover_path_data(x);
        else
            [z, R, H] = get_observation(data);
            [x, P, v] = update(x, P, z, R, H);
            result = result.add_data(v, x);
        end
        result = result.add_rover_trace_data(P);
    end
end
% close file
fclose(fid);

result.plot();
result.print_innovation_size_percentage();

% print final position
template = 'The final position of the rover =\n%14f, %14f\n%14f, %14f\n';
standard_deviation = sqrt(diag(P));
fprintf(template, x(1), standard_deviation(1), x(2), standard_deviation(2));