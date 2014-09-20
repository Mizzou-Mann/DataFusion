data = importdata('DataA1.txt');
for i = 1:size(data)
    result(i) = mean(data(1:i));
end
plot(result);