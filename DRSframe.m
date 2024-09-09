function [ rawdata] = DRSframe (fid)
  % .bin data
framedata = fread(fid, 8192, 'uint16');
%startpointer = 1;
%rawdata = zeros(1024, 8);
%rawdata = reshape(framedata, 1024, 8);
% 2024-08-30
rawdata81024 = reshape(framedata, 8, 1024);
rawdata = rawdata81024';
% rawdata = reshape(framedata, 8, 1024);
##for ii=1:1024
##pointer = (ii-1)*8 + startpointer;
##Point = framedata(pointer:pointer+7);
##  for ch = 1:8
##    rawdata (ii, ch) = Point(ch);
##  end
##end
%fclose(fid);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

##figure
##plot(framedata)
##figure
##plot(rawdata)
##
##rawdata10248 = reshape(framedata, 1024, 8);
##rawdata81024 = reshape(framedata, 8, 1024);
##
##figure
##plot(rawdata81024')
