% 2024-08-28
% array of beta
clear all
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2024-08-14
dirroot ='e:\Users\Public\Documents\ST\2024\T\'
dir2023 ='e:\Users\Public\Documents\ST\2023\T\'
dirki ='e:\Users\Public\Documents\ST\2024\T\kinterval-0.0.1\'
% 2024-08-12
dirData = 'e:\Users\Public\Documents\ST\2024\T\DRS4\'
% 2024-08-22

% 2024-08-23
% HomePC
dirroot = 'D:\ST\2024\T\'
dirki = 'D:\ST\2024\T\kinterval-0.0.1'
dirData = 'D:\ST\2024\T\DRS4\'
dir2023 =  'd:\ST\2023\T\'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(dirroot)
addpath(dir2023)
addpath(dirki)

cd(dirData), pwd
% 2024-08-27
datestr = '27_08_2024ADC_rawData\';
datestr = '04_10_2024_070_068\'
datestr = '04_10_2024_074_068\side_a\'
datestrtitle = strrep(datestr, '_', '');
indADC = findstr(datestrtitle, 'ADC');
datestrtitle = datestrtitle(1: indADC-1);
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
dirDatanow = strcat(dirData, datestr);
X = getLVL (dirDatanow);
% X = [ -0.027 -0.2050 -0.4710 - 0.4920 0.0061 0.225 0.43 0 0]
% TODO side A/B
fnX = getLVLfn (dirDatanow, X);
%
% load BETAchannel1
% load BETAch1ext

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% bin ch %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pkg load interval
dirlinprog = 'e:\Users\Public\Documents\ST\2024\T\octave-interval\m'
dirlinprog = 'D:\ST\2024\T\octave-interval\m'
addpath(dirlinprog)
dirlinprogpoly = 'e:\Users\Public\Documents\ST\2024\T\octave-interval\m\polytopes\'
dirlinprogpoly = 'D:\ST\2024\T\octave-interval\m\polytopes\'
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
for ch =1%:8
for bin=1%:2%1024
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

NonCompCh1 = NonComp(1:1024);
figure
hist(NonCompCh1, max(NonCompCh1))
xlabel('Number of non-compatible data / equations')
ylabel('Count')
set(gca, 'fontsize', 14);
xticks(0:max(NonCompCh1))
titlestr=strcat("HIST Number of non-compatible data internal Q1-Q3 Channel =", num2str(ch))
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd


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
