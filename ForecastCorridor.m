% 2024-10-03
% forecast corridor
[Xs, inds] = sort(X);
xx = Xs'
xx = [xx.^0 xx]
% external
b_ex_left = sort(inf(yarrayout))
b_ex_rigth = sort(sup(yarrayout))
y_ex = (b_ex_left + b_ex_rigth)/2;
% y_ex = (inf(yarrayout)+ sup(yarrayout))/2;
epsilon_ex = (-b_ex_left + b_ex_rigth)/2;
epsilon_ex = (-inf(yarrayout)+ sup(yarrayout))/2;
irp_T2025_ex = ir_problem(xx, y_ex, epsilon_ex);
b_ex = ir_outer(irp_T2025_ex);

% easy
y_easy = (b_easy_left + b_easy_rigth)/2;
epsilon_easy = (-b_easy_left + b_easy_rigth)/2;
irp_T2025_easy = ir_problem(xx, y_easy, epsilon_easy);

% opt
y_opt = (b_opt_left4 + b_opt_rigth4)/2;
epsilon_opt= (-b_opt_left4 + b_opt_rigth4)/2;
irp_T2025_opt = ir_problem(xx4opt, y_opt, epsilon_opt);
%
##ir_plotbeta(irp_T2025_opt)
##titlestr=strcat('Information set', ' icamp2025=', ' ex', ' easy', ' opt')
##titlestr=strcat('Information set', ' icamp2025v2=', ' ex', ' easy', ' opt')
##title(titlestr)
##figure_name_out=strcat(titlestr, '.png')
##print('-dpng', '-r300', figure_name_out), pwd

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
xlimits = [0 10];
xlimits = [-0.5 0.5];
hold on
pcolor = [0.7 0.9 0.7]
%pcolor = 2*Pantone
[px,py]= ir_plotmodelset_c(irp_T2025_ex, xlimits, pcolor)
 h1 =  patch(px,py,pcolor);
##   plot(px,py(:,1),"m-","LineWidth",1, "color", 0.5*pcolor);
##   plot(x,yp(:,2),"m-","LineWidth",1, "color", 0.5*pcolor);


%
pcolor = [0.9 0.7 0.7]
%pcolor = RoyalMail
[px,py]= ir_plotmodelset_c(irp_T2025_easy, xlimits, pcolor)
 h2 =  patch(px,py,pcolor);
 set(h2, 'facecolor', 0.9*RoyalMail)

pcolor = [0.7 0.7 0.9]
pcolor = OxfordBlue
[px,py]=  ir_plotmodelset_c(irp_T2025_opt, xlimits, pcolor)
 h3 =  patch(px,py,pcolor);
 set(h3, 'facecolor', 1.3*OxfordBlue)

##
## %
##ir_scatter(irp_T2025_in,'b.')
##ir_scatter(irp_T2025_ex,'bo')

shift = 0
h4 = errorbar(xx(:,2)-shift, y_ex, epsilon_ex,'.r');
set(h4, 'color', Pantone)
xp = [-0.5 0.5]
yp = argmax(1)+argmax(2)*xp
h41 = plot(xp, yp, '-m')

%h5 = errorbar(xx(:,1), y_in, epsilon_in,'.b');
h5 = errorbar(xx(:,1), y_easy, epsilon_easy,'.r');
set(h5, 'color', RoyalMail)
h6 = errorbar(xx4opt(:,1)+0.1, y_opt, epsilon_opt,'.b');
set(h6, 'color', OxfordBlue)


lgd123 = legend([h1 h2 h3 h4 h5 h6], ...
  {'ex', 'easy', 'opt', 'ex errors', 'easy errors', 'opt errors'})
set(lgd123, 'location', 'north')
set(lgd123, 'fontsize', 14)

xticks([1:9])

%ir_scatter(irp_T2025_easy,'bs')
%ir_scatter(irp_T2025_opt,'kx')

grid on
set(gca, 'fontsize', 14)
xlabel('number')
ylabel('data')
titlestr = strcat('Set of models compatible with data and constraints', ' Tokyo2025 v2')
title(titlestr)
figure_name_out=strcat(titlestr, '.png')
print('-dpng', '-r300', figure_name_out), pwd
