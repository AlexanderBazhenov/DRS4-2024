% 2024-09-20
function [b_int, b_out, NonCompCount] = RegressionCoeff(X, fnX, ch, bin)
% 2024-09-26
% NonCompCount - number of non compatible equations (data)
%
%tic
% 2024-09-17
% 2024-09-29 DATA INT OUT
[yarrayint, yarrayout] = DataIntOut(X, fnX, ch, bin);
##[yarrayint] = DRSCalibrationDataInt (X, fnX, ch, bin);
##[yarrayout] = DRSCalibrationDataExt (X, fnX, ch, bin);
%toc - 3.7s
% [b_in_left, b_in_right, b_ex_left, b_ex_right] = DataRegressionInfSup(yarrayint, yarrayout)


% sort data
[Xs, inds] = sort(X);
Ysint = yarrayint(inds);
Ysout = yarrayout(inds);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    REGRESSION   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2024-08-27
% 2024-09-17
Xi = [ Xs'.^0 Xs'];
%
y = mid(Ysout)-16384*0.5;
epsilon = rad(Ysout);
% https://github.com/szhilin/octave-interval-examples/blob/master/SteamGenerator.ipynb
irp_DRSout = ir_problem(Xi, y', epsilon');
%
y = mid(Ysint)-16384*0.5;
epsilon = rad(Ysint);
irp_DRSint = ir_problem(Xi, y', epsilon');
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[b_out, exitcode] = ir_outer(irp_DRSout);
% 2024-09-25
%DataCorrTol;
% 2024-09-26
[b_int, indtoout] = DataCorrNaive(Ysint, Ysout, Xi);
NonCompCount = 0;
if indtoout > 0
  NonCompCount =  length(indtoout);
end
end
