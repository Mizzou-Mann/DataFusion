function filter_7 (data_file, q)
    % initialize filter
    t = 0;
    x = zeros(4,1);
    P = eye(4) * 10^8; % large covariance P
    result = report();

    % open data file
    fid = fopen(data_file);
    while ~feof(fid)
        tline = fgetl(fid);
        data = sscanf(tline, '%f');

        if ~isempty(data)
            [t_new, z, R] = get_observation(data);
            [t, x, P] = predict(t, x, P, t_new, q);
            [x, P, vx] = update(x, P, z, R);
            result = result.add_data(vx);
        end
    end
    % close file
    fclose(fid);

    result = result.update_estimate(t, x, P);

    fprintf('Result for ''%s'' with q = %.3f \n----------------------\n\n', ...
        data_file, q);
    result.print_final_estimate();
    result.print_prediction(t + 3600, q);
    result.plot();
    result.print_innovations_percentage();
end