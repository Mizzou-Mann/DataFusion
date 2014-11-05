function [ tz, z, R ] = get_observation( data )
%GET_OBSERVATION get observation from data
%   data - column vector containing observation data

    tz = data(1);
    z = data(2:3);
    R = [data(4:5)'; data(5:6)']; % sqrtm(R) not R
    R = R * R';
end
