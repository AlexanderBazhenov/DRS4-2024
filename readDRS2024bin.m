% 2024-08-22
% Save to BIN.pdf - format
% fn='side_a_fast_data.bin'
% fn='0_lvl_side_a_fast_data.bin'
% fn = '0_lvl_side_a_fast_data_last.bin'
function [CH18] = readDRS2024bin (fn)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fid = fopen(fn, 'r');
% read header 256 bytes
[side, mode, frame_count] = DRSfileheader (fid);

%
CH18 = [];

for ii=1:frame_count

%  read frame
% frame header
stoppoint = fread(fid, 1, 'uint16');
timestamp = fread(fid, 1, 'uint32');
reserved = fread(fid, 5, 'uint16');
% rawdata

  [rawdata] = DRSframe (fid);
ch18=zeros(1024, 8);
## for ch =1:8
##    ch18(:,ch) = rawdata(:,ch);
## end
% circ shift by stoppoint
%tic
 for ch =1:8
%   chnow = rawdata(:,ch);
 %  chnow = ch18(:,ch);
%   chnow = circshift(rawdata(:,ch),stoppoint);
 ch18(:,ch)= circshift(rawdata(:,ch),stoppoint);
%     ch18(:,ch)= rawdata(:,ch);
 %   ch18(:,ch) = chnow;
end
%ch18 = circshift(ch18, stoppoint, 1);
% toc
CH18 = [CH18, ch18];

end
%

fclose(fid);

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
##% [rawdata] = DRSframe (fid);
##ch18=zeros(1024, 8);
## for ch =1:8
##%   chnow = rawdata(:,ch);
## %  chnow = ch18(:,ch);
##%   chnow = circshift(rawdata(:,ch),stoppoint);
##  ch18(:,ch)= circshift(rawdata(:,ch),stoppoint);
## %     ch18(:,ch)= rawdata(:,ch);
## %   ch18(:,ch) = chnow;
##end
##figure
##plot(ch18(:,2))
##% ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8
