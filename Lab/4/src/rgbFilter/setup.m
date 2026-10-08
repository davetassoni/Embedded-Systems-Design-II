% Dr. Kaputa
% Edited by David Tassoni
% RGB Demo Setup File
R = 752;
C = 480;
Ts = 1;


redMin = 0;
redMax = 105;

greenMin = 0;
greenMax = 255;

blueMin = 0;
blueMax = 155;

% Change this for filter mode
filterMode = 0;
% 0 YCbCr
% 1 RGB


applyFilter = int8(filterMode);