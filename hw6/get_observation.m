function [ z, R, H ] = get_observation( data )
%GET_OBSERVATION get observation from data
%   data - column vector containing observation data

    dimension = data(1);
    if dimension == 1
        z = data(2);
        R = data(3);
        H = data(4:5)';
    elseif dimension == 2
        z = data(2:3);
        R = [data(4:5)'; data(5:6)'];
        H = [data(7:8)'; data(9:10)'];
    end
end

