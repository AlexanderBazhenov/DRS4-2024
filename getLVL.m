## Author: user <user@DESKTOP-SLVDEOK>
## Created: 2024-08-27
% dirDatanow = strcat(dirData, datestr)
function [X] = getLVL (dirDatanow)
cd(dirDatanow);
pwd;
fns = dir;
fns.name;
% find zero level data
X = [];
% fnX = [];
for ii=1:length(fns)
  fnamenow = fns(ii).name;
 idx = findstr(fnamenow, '_lvl');
 % 2024-10-04
 idx = findstr(fnamenow, 'lvl');
     if (idx > 0)
       LVLstr = fnamenow(1: idx-1);
      X = [X str2num(LVLstr) ];
%      fnX = [ fnX fnamenow ];
      end
 end
%
endfunction
