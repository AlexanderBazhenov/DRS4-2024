%Created: 2024-08-22

function [side, mode, frame_count] = DRSfileheader (fid)
fileheader = fread(fid, 256);
side = fileheader(1);
mode = fileheader(2);
frame_count = fileheader(3);
end
