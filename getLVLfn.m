## Author: user <user@DESKTOP-SLVDEOK>
## Created: 2024-08-27
% dirDatanow = strcat(dirData, datestr)
function [fnX ] = getLVLfn (dirDatanow, X)
cd(dirDatanow);
pwd;
fns = dir;
fns.name;
% find zero level data
fnX = [];
for ii=1:length(fns)
  ii
 fnamenow = fns(ii).name;
 idx = findstr(fnamenow, '_lvl');
     if (idx > 0)
       LVLstr = fnamenow(1: idx-1);
       X = [X str2num(LVLstr) ];
       fnX = [ fnX fnamenow ];
      end
 end
%
endfunction
