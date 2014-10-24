classdef report

    properties
        normalized_innovations;
        traces;
        rover_path;
        innovation_sizes;
    end
    
    methods
        function obj = report()
            obj.normalized_innovations = [];
            obj.traces = [];
            obj.rover_path = [];
            obj.innovation_sizes = [];
        end
        
        function obj = add_data(obj, v, x)
        % v - normalized innovation vector
        % x - mean
            obj.normalized_innovations(end + 1) = v(1);
            obj.rover_path(:,end + 1) = x;
            obj.innovation_sizes(end + 1) = v'*v / length(x);
        end
        
        function obj = add_rover_trace(obj, P)
        % P - covariance
            obj.traces(end + 1) = sqrt(sum(diag(P)));
        end
        
        function plot(obj)
            % plot: normalized innovations
            figure
            plot(obj.normalized_innovations)
            title('Normalized innovations')
            
            % plot: traces
            figure
            plot(obj.traces)
            title('Square root of the trace of rover covariance')
            
            % plot: rover path
            figure
            plot(obj.rover_path(1,:), obj.rover_path(2,:), '-o')
            title('Rover''s path')
        end
        
        function print_innovation_size_percentage(obj)
            template = 'Innovation sizes that are less than 1 = %.2f%%\n';
            average = sum(obj.innovation_sizes < 1) / length(obj.innovation_sizes);
            fprintf(template, average * 100);
        end
    end
end