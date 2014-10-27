function [ x, P ] = process_control_input( data, x, P )
%PROCESS_CONTROL_INPUT process control input command for rover
%   Add the relative change of position to mean x and covariance P

    z = data(2:3);
    R = [data(4:5)'; data(5:6)']; % the square root of the motion covariance matrix
    R = R * R'; % convert to covariance format
    P = P + R;
    x = x + z;
end

