% 2024-09-20
function [yarrayint, yarrayout] = DataIntOut(X, fnX, ch, bin)
% 2024-09-17
[yarrayint] = DRSCalibrationDataInt (X, fnX, ch, bin);
%[yarrayout] = DRSCalibrationDataExt (X, fnX, ch, bin);
[yarrayout] = DRSCalibrationDataExt2 (X, fnX, ch, bin);
end
