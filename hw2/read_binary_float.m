function [ data ] = read_binary_float( filename )
    fid = fopen(filename);
    if fid ~= -1
        data = fread(fid, Inf, 'float');
        fclose(fid);
    end
end
