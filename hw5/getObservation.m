function [ z, R, H ] = getObservation( fid, d )
%getObservation - read observation from data file
%   fid - file pointer
%   d   - dimension of the observation

    if (d == 1)
        observation = fscanf(fid, '%f', 5);
        z = observation(1);
        R = observation(2);
        H = observation(3:5)'; % 1 * 3
    elseif (d == 2)
        observation = fscanf(fid, '%f', 11);
        z = observation(1:2);
        R = [observation(3:4)'; observation(4:5)']; % 2 * 2
        H = [observation(6:8)'; observation(9:11)']; % 2 * 3
    end
end

