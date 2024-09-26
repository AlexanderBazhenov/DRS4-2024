function [b_int, env] = DataCorrNaive(Ysint, Ysout, Xi)
% 2024-09-26
% env - vector of compatibility by equations (data)
% 2024-09-26
% Naive Data Coorection by TOL env
Ys = Ysint
y = mid(Ys)/16384-0.5;
epsilon = rad(Ys)/16384;
irp_DRSint = ir_problem(Xi, y', epsilon');
[tolmax,argmax, env] = tolsolvty(Xi,Xi,y'-epsilon',y'+epsilon',1)
if tolmax > 0
  b_int = ir_outer(irp_DRSint);
  display('tolmax > 0')
else
  display('tolmax < 0')
  [envnegind, envneg] = find(env(:,2) < 0)
  indtoout = env(envnegind,1)
##  y(indtoout) = mid(Ysout(indtoout))/16384-0.5;
##  epsilon(indtoout) = rad(Ysout(indtoout))/16384;
  y(indtoout) = mid(Ysout(indtoout));
  epsilon(indtoout) = rad(Ysout(indtoout));
  [tolmax,argmax, env] = tolsolvty(Xi,Xi,y'-epsilon',y'+epsilon',1)
  irp_DRSint = ir_problem(Xi, y', epsilon');
  b_int = ir_outer(irp_DRSint);
endif
