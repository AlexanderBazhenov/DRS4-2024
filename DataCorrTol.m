% 2024-10-04
% Optimal Data Coorection by TOL env
xx4opt = [ xx', xx', xx', xx' ]'
b_opt_left4 = [ b_in_left', b_in_left', b_ex_left', b_ex_left' ]'
b_opt_rigth4 = [ b_in_rigth', b_ex_rigth', b_in_rigth', b_ex_rigth']'
[tolmax,argmax, env] = tolsolvty(xx4opt,xx4opt,b_opt_left4,b_opt_rigth4,1)
  [envnegind, envneg] = find(env(:,2) < 0);
  indtoout = env(envnegind,1);
xx4opt (indtoout, :) = []
b_opt_left4  (indtoout, :) = []
b_opt_rigth4  (indtoout, :) = []
[tolmax,argmax, env] = tolsolvty(xx4opt,xx4opt,b_opt_left4,b_opt_rigth4,1)
