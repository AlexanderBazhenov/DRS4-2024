% 2024-08-28
% bin =1 ch =1 calibration example
##ii = 1
##bin=1
##ch =1
function [yarray] = DRSCalibrationDataExt2 (X, fnX, ch, bin)
binind = findstr(fnX, '.bin');
ii = 1;
fn = fnX(1:binind(ii)+3);
%tic
[CH18] = readDRS2024bin (fn);
%toc %- 0.45 s
chcount = 8 ;% DRS4
sizeCH18 = size(CH18);
runs = sizeCH18(2) / chcount;
yarray = [];

Ch1 =[];
for ii=1:runs
    Chnow = CH18(:, ch+(ii-1)*chcount);
    Ch1 =[Ch1 Chnow] ;
 end
ynow = Ch1(bin, :);
ynowint = infsup(min(ynow), max(ynow));
yarray = [yarray ynowint];


for ii =2:length(X)
  fn = fnX(binind(ii-1)+4:binind(ii)+3);
  [CH18] = readDRS2024bin (fn);
Ch1 =[];
for ii=1:runs
    Chnow = CH18(:, ch+(ii-1)*chcount);
    Ch1 =[Ch1 Chnow] ;
 end
ynow = Ch1(bin, :);
%
ynowsort = sort(ynow);
ynowint = infsup(ynowsort(2), ynowsort(end-1));
yarray = [yarray ynowint];
end
end

