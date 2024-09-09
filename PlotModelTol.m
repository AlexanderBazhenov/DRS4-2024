% 2024-09-09
%
y = mid(Ys)/16384-0.5;
epsilon = rad(Ys)/16384;
% https://github.com/szhilin/octave-interval-examples/blob/master/SteamGenerator.ipynb
Xi = [ Xs'.^0 Xs'];
figure
hold on
h1 =errorbar ( Xs, y', epsilon', epsilon',".b");
[tolmax,argmax] = tolinprog(Xi,Xi,y'-epsilon',y'+epsilon',1)
[tolmax2,argmax2, env2] = tolsolvty(Xi,Xi,y'-epsilon',y'+epsilon',1)
Xp=[ min(Xs) max(Xs)]
yp = argmax(1)+argmax(2)*Xp
h2=plot(Xp, yp, 'r')
%
