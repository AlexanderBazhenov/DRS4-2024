% 2024-09-17
% Colors_special
OxfordBlue = [0, .33, .71]
RoyalMail = 4.58*[0.218, .032, 0.042]
Pantone = 3*[0.128, 0.140, 0.036]
%
figure
hold on
%
Ys = Ysint
y = mid(Ys)/16384-0.5;
epsilon = rad(Ys)/16384;
irp_DRSint = ir_problem(Xi, y', epsilon');
% https://github.com/szhilin/octave-interval-examples/blob/master/SteamGenerator.ipynb
Xi = [ Xs'.^0 Xs'];
xlimits = [-0.55 .55];
pcolor = 2*Pantone
ir_plotmodelset_c(irp_DRSint, xlimits, pcolor)
h1 =errorbar ( Xs, y', epsilon', epsilon',".b");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[tolmax,argmax] = tolinprog(Xi,Xi,y'-epsilon',y'+epsilon',1)
[tolmax,argmax, env] = tolsolvty(Xi,Xi,y'-epsilon',y'+epsilon',1)




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Xp=[ min(Xs) max(Xs)]
yp = b_int(1,1)/16384+b_int(2,1)/16384*Xp-0.5
plot(Xp, yp, '-m')
yp = b_int(1,2)/16384+b_int(2,2)/16384*Xp-0.5
plot(Xp, yp, '-m')

Ys = Ysout
y = mid(Ys)/16384-0.5;
epsilon = rad(Ys)/16384;

irp_DRSout= ir_problem(Xi, y', epsilon');
pcolor = RoyalMail
ir_plotmodelset_c(irp_DRSout, xlimits, pcolor)
h2 =errorbar ( Xs, y', epsilon', epsilon',".k");

xlim([-0.51 0.51])
ylim([-0.45 0.45])

xlabel('V')
ylabel('V')
set(gca, 'fontsize', 14);
grid on
titlestr=strcat("Forecast Band Channel =", num2str(ch), ' cell=', num2str(bin),' internal', ' external ' )
titlestr=strcat("Forecast Band Channel =", num2str(ch), ' cell=', num2str(bin),' internal', ' external ', ' PART' )
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd

b_int_wid = b_int(1,1)-b_int(1,2)
b_out_wid = b_out(1,1)-b_out(1,2)

b_int_wid_mV = b_int_wid / 16384 *1000
b_out_wid_mV = b_out_wid / 16384 *1000
