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
##dirroot = 'D:\ST\2024\T\'
##dirki = 'D:\ST\2024\T\kinterval-0.0.1'
##% dirOld2022 =  'd:\ST\2022\T\'
##dir2023 =  'd:\ST\2023\T\'
##dirki ='d:\ST\2024\T\\kinterval-0.0.1\'
##dirData = 'd:\ST\2024\T\DRS4\'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(dirroot)
addpath(dir2023)
addpath(dirki)

cd(dirData), pwd
% 2024-08-27
datestr='27_08_2024ADC_rawData\'
datestrtitle = strrep(datestr, '_', '')
indADC = findstr(datestrtitle, 'ADC')
datestrtitle = datestrtitle(1: indADC-1)
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
fnX = getLVLfn (dirDatanow, X);
%
% load BETAchannel1
% load BETAch1ext

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
% 2024-09-02
BETAext = zeros(1024*8,6);
BETAint = zeros(1024*8,6);
for ch =1%:8
for bin=1:2%1024
ii=1024*(ch-1)+bin;
%
%tic
% 2024-09-17
[yarrayint] = DRSCalibrationDataInt (X, fnX, ch, bin);
[yarrayout] = DRSCalibrationDataExt (X, fnX, ch, bin);
%toc - 3.7s
% sort data
[Xs, inds] = sort(X);
Ysint = yarrayint(inds);
Ysout = yarrayout(inds);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    REGRESSION   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2024-08-27
% 2024-09-17
y = mid(Ysint);
epsilon = rad(Ysint);
% https://github.com/szhilin/octave-interval-examples/blob/master/SteamGenerator.ipynb
Xi = [ Xs'.^0 Xs'];
irp_DRSint = ir_problem(Xi, y', epsilon');
%
y = mid(Ysout);
epsilon = rad(Ysout);
% https://github.com/szhilin/octave-interval-examples/blob/master/SteamGenerator.ipynb
Xi = [ Xs'.^0 Xs'];
irp_DRSout = ir_problem(Xi, y', epsilon');

%
##y = mid(Ys)/16384;
##epsilon = rad(Ys)/16384;
##% https://github.com/szhilin/octave-interval-examples/blob/master/SteamGenerator.ipynb
##Xi = [ Xs'.^0 Xs'];
##figure
##hold on
##h1 =errorbar ( Xs, y', epsilon', epsilon',".b");
##[tolmax,argmax] = tolinprog(Xi,Xi,y'-epsilon',y'+epsilon',1)
##Xp=[ min(Xs) max(Xs)]
##yp = argmax(1)+argmax(2)*Xp
##h2=plot(Xp, yp)
##%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b_out = ir_outer(irp_DRSout);
Ys = Ysint
y = mid(Ys)/16384-0.5;
epsilon = rad(Ys)/16384;
[tolmax,argmax, env] = tolsolvty(Xi,Xi,y'-epsilon',y'+epsilon',1)
if tolmax > 0
  b_int = ir_outer(irp_DRSint);
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
