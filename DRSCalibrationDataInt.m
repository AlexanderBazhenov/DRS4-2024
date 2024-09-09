% 2024-08-28
% bin =1 ch =1 calibration example
##ii = 1
##cells =1
##ch =1
function [yarray] = DRSCalibrationDataInt (X, fnX, ch, cells)
% 2024-08-29
% X - array of calibration levels
% fnX - list of files with data for calibration levels (.bin)
% ch - DRS4 channel number 1..8
% cells - DRS4 cell number 1..1024
% find binary files
binind = findstr(fnX, '.bin');
% 1st file in fnX
ii = 1;
% file name of 1st file in fnX
fn = fnX(1:binind(ii)+3);
% CH18 1..8 channel data per 1024 cell times runs
[CH18] = readDRS2024bin (fn); % 0.45s
chcount = 8 ;% DRS4
sizeCH18 = size(CH18);
runs = sizeCH18(2) / chcount; % number of data taken for calibration level (100)
%
yarray = [];
% Ch - channel data
Ch =[];
for ii=1:runs
    Chnow = CH18(:, ch+(ii-1)*chcount);
    Ch =[Ch Chnow] ;
 end
ynow = Ch(cells, :);
% Sort data
ynows = sort(ynow);
% Q1-Q3
ynowint = infsup(ynows(runs/4), ynows(3*runs/4));
% q1-q9
ynowint = infsup(ynows(runs/10), ynows(9*runs/10));
yarray = [yarray ynowint];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  tic
% 2nd:last
for ii =2:length(X)
  fn = fnX(binind(ii-1)+4:binind(ii)+3);
  [CH18] = readDRS2024bin (fn);
Ch =[];
for ii=1:runs
    Chnow = CH18(:, ch+(ii-1)*chcount);
    Ch =[Ch Chnow] ;
 end
ynow = Ch(cells, :);
% Sort data
ynows = sort(ynow);
% Q1-Q3
ynowint = infsup(ynows(runs/4), ynows(3*runs/4));
% 2024-08-30
% q1-q9
%ynowint = infsup(ynows(runs/10), ynows(9*runs/10));
yarray = [yarray ynowint];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% toc 3.6 s
end
