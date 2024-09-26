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
% sort data
[Xs, inds] = sort(X);
Ysint = yarrayint(inds);
Ysout = yarrayout(inds);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    REGRESSION   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2024-08-27
% 2024-09-17
Xi = [ Xs'.^0 Xs'];
%
y = mid(Ysout);
epsilon = rad(Ysout);
% https://github.com/szhilin/octave-interval-examples/blob/master/SteamGenerator.ipynb
irp_DRSout = ir_problem(Xi, y', epsilon');
%
y = mid(Ysint);
epsilon = rad(Ysint);
irp_DRSint = ir_problem(Xi, y', epsilon');
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b_out = ir_outer(irp_DRSout);
% 2024-09-25
%DataCorrTol;
% 2024-09-26
[b_int, env] = DataCorrNaive(Ysint, Ysout, Xi);
  [envnegind, envneg] = find(env(:,2) < 0);
NonCompCount =  length(envnegind);
##Ys = Ysint
##y = mid(Ys)/16384-0.5;
##epsilon = rad(Ys)/16384;
##[tolmax,argmax, env] = tolsolvty(Xi,Xi,y'-epsilon',y'+epsilon',1)
##if tolmax > 0
##  b_int = ir_outer(irp_DRSint);
##  display('tolmax > 0')
##else
##  display('tolmax < 0')
##  [envnegind, envneg] = find(env(:,2) < 0)
##  indtoout = env(envnegind,1)
####  y(indtoout) = mid(Ysout(indtoout))/16384-0.5;
####  epsilon(indtoout) = rad(Ysout(indtoout))/16384;
##  y(indtoout) = mid(Ysout(indtoout));
##  epsilon(indtoout) = rad(Ysout(indtoout));
##  [tolmax,argmax, env] = tolsolvty(Xi,Xi,y'-epsilon',y'+epsilon',1)
##  irp_DRSint = ir_problem(Xi, y', epsilon');
##  b_int = ir_outer(irp_DRSint);
##endif
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
