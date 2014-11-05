classdef report

    properties
        normalized_unit_innovations;
        running_percentages;
        t;
        x;
        P;
    end
    
    methods
        function obj = report()
            obj.normalized_unit_innovations = [];
            obj.running_percentages = [];
        end
        
        function obj = add_data(obj, vx)
        % vx - normalized unit innovation vector
        % vs - innovation size
            obj.normalized_unit_innovations(:, end + 1) = vx;
            obj.running_percentages(:, end + 1) = ...
                sum(obj.normalized_unit_innovations < 0, 2) / length(obj.normalized_unit_innovations);
        end
        
        function obj = update_estimate(obj, t, x, P)
            obj.t = t;
            obj.x = x;
            obj.P = P;
        end
        
        function print_prediction(obj, t, q)
            [~, x_new, P_new] = predict(obj.t, obj.x, obj.P, t, q);
            fprintf('x(%f) = \n\n', t);
            fprintf('%14f \n', x_new);
            fprintf('\n');

            fprintf('P(%f) = \n\n', t);
            fprintf('%14.8f %14.8f %14.8f %14.8f \n', P_new);
            fprintf('\n');
        end
        
        function print_final_estimate(obj)
            % print final position
            standard_deviation = sqrt(diag(obj.P));
            fprintf('The final position of the target with standard deviation =\n');
            fprintf('\n%14f, %14f\n%14f, %14f\n%14f, %14f\n%14f, %14f\n', ...
                obj.x(1), standard_deviation(1), ...
                obj.x(2), standard_deviation(2), ...
                obj.x(3), standard_deviation(3), ...
                obj.x(4), standard_deviation(4));
            fprintf('\n');

            fprintf('x_final = \n\n');
            fprintf('%14f \n', obj.x);
            fprintf('\n');

            fprintf('P_final = \n\n');
            fprintf('%14.8f %14.8f %14.8f %14.8f \n', obj.P);
            fprintf('\n');
        end
        
        function plot(obj)
            % plot x innovations
            figure;
            plot(obj.normalized_unit_innovations(1,:));
            ylim([-3, 3]);
            title('Normalized x innovations');

            figure;
            plot(obj.running_percentages(1, :));
            ylim([.3, .7]);
            title('Running percentage of the x innovations that are less than or equal to 0');

            % plot y innovations
            figure;
            plot(obj.normalized_unit_innovations(2,:));
            ylim([-3, 3]);
            title('Normalized y innovations');

            figure;
            plot(obj.running_percentages(2, :));
            ylim([.3, .7]);
            title('Running percentage of the y innovations that are less than or equal to 0');
        end
        
        function print_innovations_percentage(obj)
            template = 'Percentage of the innovations that are less than 0 = [ %.2f%%, %.2f%% ]\n';
            percent = ...
                sum(obj.normalized_unit_innovations < 0, 2) / length(obj.normalized_unit_innovations);
            fprintf(template, percent * 100);
        end
    end
end
