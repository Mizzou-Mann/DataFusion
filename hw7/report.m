classdef report

    properties
        normalized_unit_innovations;
        running_percentage;
        t;
        x;
        P;
    end
    
    methods
        function obj = report()
            obj.normalized_unit_innovations = [];
            obj.running_percentage = [];
        end
        
        function obj = add_data(obj, vx, vs)
        % vx - normalized unit innovation vector
        % vs - innovation size
            obj.normalized_unit_innovations(:, end + 1) = vx;
            obj.running_percentage(:, end + 1) = sum(obj.normalized_unit_innovations < 0, 2) / length(obj.normalized_unit_innovations);
%             obj.innovation_sizes(end + 1) = vs;
%             obj.innovation_sizes_running_percentage(end + 1) = sum(obj.innovation_sizes <= 1) / length(obj.innovation_sizes);
        end
        
        function obj = update_estimate(obj, t, x, P)
            obj.t = t;
            obj.x = x;
            obj.P = P;
        end
        
        function print_prediction(obj, t, q)
            [~, x_new, P_new] = predict(obj.t, obj.x, obj.P, t, q);
            fprintf('x(%f) = \n', t);
            fprintf('%14f \n', x_new);
            fprintf('P(%f) = \n', t);
            fprintf('%14.8f %14.8f %14.8f %14.8f \n', P_new);
        end
        
        function print_final_estimate(obj)
            % print final position
            template = 'The final position of the target =\n%14f, %14f\n%14f, %14f\n%14f, %14f\n%14f, %14f\n';
            standard_deviation = sqrt(diag(obj.P));

            fprintf(template, obj.x(1), standard_deviation(1), obj.x(2), standard_deviation(2), obj.x(3), standard_deviation(3), obj.x(4), standard_deviation(4));
            disp('x_final = '); fprintf('%14f \n', obj.x);
            disp('P_final = '); fprintf('%14.8f %14.8f %14.8f %14.8f \n', obj.P);
        end
        
        function plot(obj)
            % plot x innovations
            figure;
            plot(obj.normalized_unit_innovations(1,:));
            ylim([-3, 3]);
            title('Normalized x innovations');

            figure;
            plot(obj.running_percentage(1, :));
            title('Running percentage of the x innovation that are less than or equal to 0');

            % plot y innovations
            figure;
            plot(obj.normalized_unit_innovations(2,:));
            ylim([-3, 3]);
            title('Normalized y innovations');

            figure;
            plot(obj.running_percentage(2, :));
            title('Running percentage of the y innovation that are less than or equal to 0');
        end
        
        function print_innovation_sizes_percentage(obj)
            template = 'Percentage of the innovations that are less than 0 = [ %.2f%%, %.2f%% ]\n';
            percent = sum(obj.normalized_unit_innovations < 0, 2) / length(obj.normalized_unit_innovations);
            fprintf(template, percent * 100);
        end
    end
end
