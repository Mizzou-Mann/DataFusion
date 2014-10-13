% open data file
fid = fopen('A5-MeasurementData.txt');
while ~feof(fid)
    [z, R, H] = getObservation(fid);
end
% close file
fclose(fid);