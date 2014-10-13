function [ z, R, H ] = getObservation( fid )
% function [ d ] = getObservation( fid )
%getObservation - read observation from data file
%   Read a single observation from file
%       - dimension: {1 or 2}
%       - mean: floats
%       - covariance: floats
%       - transformation: floats

    d = fscanf(fid, '%d', 1);
    if (d == 1)
        observation = fscanf(fid, '%f', 5);
        z = observation(1);
        R = observation(2);
        H = observation(3:5)';
    elseif (d == 2)
        observation = fscanf(fid, '%f', 11);
        z = observation(1:2);
        R = [observation(3:4)'; observation(4:5)'];
        H = [observation(6:8)'; observation(9:11)'];
    end
end

