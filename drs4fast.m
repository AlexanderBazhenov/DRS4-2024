% 2024-10-28
% 2024-11-23
% fast data
clear all
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2024-08-14
dirroot ='e:\Users\Public\Documents\ST\2024\T\'
dir2023 ='e:\Users\Public\Documents\ST\2023\T\'
dirki ='e:\Users\Public\Documents\ST\2024\T\kinterval-0.0.1\'
dir2D = 'e:\Users\Public\Documents\ST\2024\T\IntLinInc2D\'
% 2024-08-12
dirData = 'e:\Users\Public\Documents\ST\2024\T\'
% 2024-08-22

% 2024-08-23
% HomePC
##dirroot = 'D:\ST\2024\T\'
##dirki = 'D:\ST\2024\T\kinterval-0.0.1'
##dirData = 'D:\ST\2024\T\DRS4\'
##dir2023 =  'd:\ST\2023\T\'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(dirroot)
addpath(dir2023)
addpath(dirki)
addpath(dir2D)

cd(dirData), pwd
% 2024-08-27
##datestr='27_08_2024ADC_rawData\';
##datestrtitle = strrep(datestr, '_', '');
##indADC = findstr(datestrtitle, 'ADC');
##datestrtitle = datestrtitle(1: indADC-1);
##% 2024-10-03
##datestr = '04_10_2024_070_068\'
##datestr = '04_10_2024_074_068\side_a\'
datestr = 'data_folder\28_10_2024\'
datestr = 'data_folder\14_11_2024\no_lamp\'
datestr = 'data_folder\19_11_2024\'
datestr = '\27_08_2024ADC_rawData\'
%%%%%%%%%%%%%%%%%%%%%%%%%%%   RAW DATA   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%  ZERLOLINE  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2024-08-23
##fn='side_a_fast_data.bin'
##%
##find_zero_level_data
##%
##[CH18] = readDRS2024bin (fn);

%%%%%%%%%%%%%%%%%%%%%%%%%% ALL LEVEL PROCESSING  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get levels and filenames
dirDatanow = strcat(dirroot, datestr);
cd(dirDatanow);
pwd;
fns = dir;
fns.name;
fn = 'side_a_fast_data_glass86.bin'
fn = 'side_b_fast_data.bin'
fn = 'ch5_6_side_b_fast_data.bin'
[CH18] = readDRS2024bin (fn);
[CH18, side, mode, frame_count] = readDRS2024binFULL (fn);
save fast_data_glass86
save 2024_11_14_nolamp
% cd no_lamp
% load fast_data_glass86

ch=6
data7 = 0;
for frame=1%:10%frame_count
datanow = CH18(:, 1+  8*(frame-1)+ (ch-1) );
data7 = data7 + datanow;
end
%
data7 = data7 /frame_count;

ch=7
data6 = 0;
for frame=1%:2%frame_count
datanow = CH18(:, 1+  8*(frame-1)+ (ch-1) );
data6 = data6 + datanow;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2024-11-23
ch=6
frame=1
datanow = CH18(:, 1+  8*(frame-1)+ (ch-1) );
fast_ch6 = datanow;

fn = '0_side_b_fast_data.bin'
datanow = CH18(:, 1+  8*(frame-1)+ (ch-1) );
zeroline_ch6 = datanow;

fast_ch6_zero = fast_ch6 - zeroline_ch6;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ch=7
frame=1
fn = 'ch5_6_side_a_fast_data.bin'

datanow = CH18(:, 1+  8*(frame-1)+ (ch-1) );
fast_ch7 = datanow;

datestr = '\DRS4\04_10_2024_070_068\'
dirDatanow = strcat(dirroot, datestr);
cd(dirDatanow);
pwd;
fns = dir;
fns.name;
fn = '0lvl_side_a_fast_data.bin'
datanow = CH18(:, 1+  8*(frame-1)+ (ch-1) );
zeroline_ch7 = datanow;

fast_ch7_zero = fast_ch7 - zeroline_ch7;
%datanow = tmp(:, 1+ 8*(frame-1)+ (ch-1));
% X = getLVL (dirDatanow);
% X = [ -0.027 -0.2050 -0.4710 - 0.4920 0.0061 0.225 0.43 0 0]
% fnX = getLVLfn (dirDatanow, X);
%
% load BETAchannel1
% load BETAch1ext

figure
hold on
p1 = plot(fast_ch7 - 8192, '-r')
p2 = plot(zeroline_ch7-8192, '-b')
p3 = plot(fast_ch7_zero, '-k')
 lgd123 = legend([p1 p2 p3 ], ...
  {'FAST Ch5', 'Zeroline', 'FAST Ch5 - Zeroline'})
set(lgd123, 'location', 'southwest')
set(lgd123, 'fontsize', 14)

grid on
set(gca, 'fontsize', 14)
xlabel('\it DRS$ cell')
ylabel('\it ADC Code')
titlestr = strcat('FAST Ch5 corr by Zeroline')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd


figure
hold on
p1 = plot(fast_ch7 - 8192, '-r')
p2 = plot(zeroline_ch7-8192, '-b')
 lgd12 = legend([p1 p2 ], ...
  {'FAST Ch5', 'Zeroline'})
set(lgd12, 'location', 'southwest')
set(lgd12, 'fontsize', 14)

grid on
set(gca, 'fontsize', 14)
xlabel('\it DRS4 cell')
ylabel('\it ADC Code')
titlestr = strcat('FAST Ch5 w Zeroline')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd


figure
hold on
p2 = plot(zeroline_ch7-8192, '-b')
 lgd2 = legend([ p2 ], ...
  {'Zeroline'})
set(lgd2, 'location', 'southwest')
set(lgd2, 'fontsize', 14)

grid on
set(gca, 'fontsize', 14)
xlabel('\it DRS4 cell')
ylabel('\it ADC Code')
titlestr = strcat('Zeroline')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ch=3
frame=1
datestr = 'data_folder\19_11_2024\'
dirDatanow = strcat(dirroot, datestr);
cd(dirDatanow);
pwd;
fns = dir;
fns.name;
fn = 'ch1_2_side_a_fast_data.bin'
% readDRS2024bin.m
datanow = CH18(:, 1+  8*(frame-1)+ (ch-1) );
fast_ch3 = datanow;

% 2024-11-26
datestr = '\DRS4\27_08_2024ADC_rawData\'
dirDatanow = strcat(dirroot, datestr);
cd(dirDatanow);
pwd;
fns = dir;
fns.name;
fn = '0_lvl_side_a_fast_data.bin'
% readDRS2024bin.m
[CHdata] = readDRS2024binChannel (fn, ch);
##ZeroCH = [];
##for ii=1:frame_count
##datanow = CHdata(:, 1+  8*(frame-1)+ (ch-1) );
##ZeroCH = [ZeroCH, datanow];
##end
ZeroCHmed = median(CHdata, 2);
ZeroCHmin = zeros(1024,1);
for cc=1:1024
  datacc = CHdata(cc,:);
 ZeroCHmin(cc) = min(datacc);
end
ZeroCHmax = zeros(1024,1);
for cc=1:1024
  datacc = CHdata(cc,:);
 ZeroCHmax(cc) = max(datacc);
end
##
##ZeroCHmed = median(ZeroCH, 2);
##ZeroCHmin = min(ZeroCH, 1);
##ZeroCHmax = max(ZeroCH, 2);

zeroline_ch3 = ZeroCHmed;

figure
hold on
p1 = plot(fast_ch3 - 8192, '-r')
p2 = plot(zeroline_ch3-8192, '-b')
p3 = plot(ZeroCHmin-8192, '--b')
p4 = plot(ZeroCHmax-8192, '--b')
 lgd12 = legend([p1 p2 ], ...
  {'FAST Ch1', 'Zeroline'})
set(lgd12, 'location', 'southwest')
set(lgd12, 'fontsize', 14)

fast_ch3_zero = fast_ch3 - zeroline_ch3;

% 2024-11-24
figure
hold on
p1 = plot(fast_ch3 - 8192, '-r')
p2 = plot(zeroline_ch3-8192, '-b')
p3 = plot(fast_ch3_zero, '-k')
 lgd123 = legend([p1 p2 p3 ], ...
  {'FAST Ch1', 'ZerolineMedian100', 'FAST Ch1 - Zeroline'})
set(lgd123, 'location', 'southeast')
set(lgd123, 'fontsize', 14)

grid on
set(gca, 'fontsize', 14)
xlabel('\it DRS4 cell')
ylabel('\it ADC Code')

titlestr = strcat('FAST Ch3 w ZerolineMed')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

TimeScale=0.2*(1:1024)
figure
hold on
p1 = plot(TimeScale, fast_ch3 - 8192, '-r')
p2 = plot(TimeScale, zeroline_ch3-8192, '-b')
p3 = plot(TimeScale, fast_ch3_zero, '-k')
 lgd123 = legend([p1 p2 p3 ], ...
  {'FAST Ch1', 'ZerolineMedian100', 'FAST Ch1 - Zeroline'})
set(lgd123, 'location', 'southeast')
set(lgd123, 'fontsize', 14)

grid on
set(gca, 'fontsize', 14)
xlabel('\it Time, ns')
ylabel('\it ADC Code')

ROI = [780:880]
ROIns = [780:880]*0.2
xlim([ min(ROIns) max(ROIns)])

min_fast_ch3_zero_ROI = min(fast_ch3_zero(ROI))
xx = [ min(ROIns) max(ROIns)]
yy = [min_fast_ch3_zero_ROI/2 min_fast_ch3_zero_ROI/2 ]
p4 = plot(xx, yy, '--k')
[aa, bb] =find(fast_ch3_zero(ROI) < min_fast_ch3_zero_ROI/2)


xx = 0.2*([  min(aa) min(aa)] + min(ROI)-1)
yy = [-4000 min_fast_ch3_zero_ROI/2]
plot(xx, yy, '--g')
xx = 0.2*([  max(aa) max(aa)] + min(ROI)-1)
yy = [-4000 min_fast_ch3_zero_ROI/2]
plot(xx, yy, '--g')
xlim(0.2*([ min(aa)-5 max(aa)+5] +  min(ROI)-1))
set(lgd123, 'location', 'north')

titlestr = strcat('FAST Ch3 w ZerolineMed FWHM')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% bin ch %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pkg load interval
dirlinprog = 'e:\Users\Public\Documents\ST\2024\T\octave-interval\m'
%dirlinprog = 'D:\ST\2024\T\octave-interval\m'
addpath(dirlinprog)
dirlinprogpoly = 'e:\Users\Public\Documents\ST\2024\T\octave-interval\m\polytopes\'
%dirlinprogpoly = 'D:\ST\2024\T\octave-interval\m\polytopes\'
addpath(dirlinprogpoly)
%
% 2024-08-29
% internal estimation Q1-Q3
BETAch1int = zeros(1024*8,6);
BETAch1ext = zeros(1024*8,6);
NonComp = zeros (1024*8,1);
% 2024-09-02
##BETAext = zeros(1024*8,6);
##BETAint = zeros(1024*8,6);
for ch =6%:8
for bin=1:1024
ii=1024*(ch-1)+bin;
% 2024-09-20
%[b_int, b_out] = RegressionCoeff(X, fnX, ch, bin)
% 2024-09-26
[b_int, b_out, NonCompCount] = RegressionCoeff(X, fnX, ch, bin);
NonComp (ii) = NonCompCount;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
BETAch1int(ii, 1) = ch;
BETAch1int(ii, 2) = bin;
BETAch1int(ii, 3) = b_int(1,1);
BETAch1int(ii, 4) = b_int(1,2);
BETAch1int(ii, 5) = b_int(2,1);
BETAch1int(ii, 6) = b_int(2,2);
BETAch1ext(ii, 1) = ch;
BETAch1ext(ii, 2) = bin;
BETAch1ext(ii, 3) = b_out(1,1);
BETAch1ext(ii, 4) = b_out(1,2);
BETAch1ext(ii, 5) = b_out(2,1);
BETAch1ext(ii, 6) = b_out(2,2);
% 2024-09-02
##BETAext(ii, 1) = ch;
##BETAext(ii, 2) = bin;
##BETAext(ii, 3) = b_out(1,1);
##BETAext(ii, 4) = b_out(1,2);
##BETAext(ii, 5) = b_out(2,1);
##BETAext(ii, 6) = b_out(2,2);
ii
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% save NonCompCount
% load NonCompCount

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tokyo fig 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2024-10-25
save BETAch6intext

save BETAch1intext

%
% 2024-09-02
BETAch2ext = BETAext;
save BETAch2ext
BETAch3ext = BETAext;
save BETAch3ext
% 2024-08-30
save BETAch1ext
%
max(BETAch1int(:, 4))-min(BETAch1int(ii, 3))
(max(BETAch1int(:, 4))-min(BETAch1int(ii, 3)))/16384
%
save BETAch1inner
save BETAchannel1
% load BETAchannel1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2024-08-29
Beta0infint = BETAch1int(1:1024, 3);
Beta0supint = BETAch1int(1:1024, 4);
Beta0ch1int = infsup(Beta0infint, Beta0supint);
widBeta0ch1int = wid(Beta0ch1int);
% External
% 2024-08-30
Beta0infext = BETAch1ext(1:1024, 3);
Beta0supext = BETAch1ext(1:1024, 4);
Beta0ch1ext = infsup(Beta0infext, Beta0supext);
widBeta0ch1ext = wid(Beta0ch1ext);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2024-09-02
Beta0infext = BETAext(1+1024*(ch-1):1024*ch, 3);
Beta0supext = BETAext(1+1024*(ch-1):1024*ch, 4);
Beta0ext = infsup(Beta0infext, Beta0supext);
widBeta0ext = wid(Beta0ext);
%
figure
hist(widBeta0ext/16385, 100)
xlabel('V')
ylabel('Count')
set(gca, 'fontsize', 14);
titlestr=strcat("HIST Zero Line Width Channel =", num2str(ch), ' external ')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
hist(widBeta0ch1ext/16385)
hist(widBeta0ch1ext/16385, 100)
xlim([0.001 0.005])
xlim([0.006 0.0175])
ylim([0 3.5])
xlabel('V')
ylabel('Count')
set(gca, 'fontsize', 14);
titlestr=strcat("HIST Zero Line Width Channel =", num2str(ch), ' external ')
titlestr=strcat("HIST Zero Line Width Channel =", num2str(ch), ' external ', ' typical')
titlestr=strcat("HIST Zero Line Width Channel =", num2str(ch), ' external ', ' outlilers')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd


Beta0inf = BETAch1(1:1024, 3);
Beta0sup = BETAch1(1:1024, 4);

Beta0ch1 = infsup(Beta0inf, Beta0sup);
widBeta0ch1 = wid(Beta0ch1);
figure
hist(widBeta0ch1)
xlabel('ADC code')
ylabel('Count')
set(gca, 'fontsize', 14);
titlestr=strcat("HIST Zero Line Width Channel =", num2str(ch), ' external ')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

widBeta0ch1Vint = widBeta0ch1int/16384;
figure
hist(widBeta0ch1Vint)
xlabel('V')
ylabel('Count')
set(gca, 'fontsize', 14);
titlestr=strcat("HIST Zero Line Width (V) Channel =", num2str(ch), ' internal ')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd
