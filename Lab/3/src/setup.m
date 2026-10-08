% David Tassoni
% RBG and YCbCr Image Setup File

% Sample Time
Ts = 1;

% RGB Limits
r_min = 0;
r_max = 255;
g_min = 0;
g_max = 255;
b_min = 0;
b_max = 255;  

% % RGB Limits
% r_min = 60;
% r_max = 155;
% g_min = 87;
% g_max = 255;
% b_min = 196;
% b_max = 211; 

rgb_limits = [r_min g_min b_min; 
              r_max g_max b_max];
          
%YCbCr Limits
y_min  = (0.299 * r_min) + (0.587 * g_min) + (0.114 * b_min);
y_max  = (0.299 * r_max) + (0.587 * g_max) + (0.114 * b_max);
cb_min = (-0.169 * r_min) - (0.331 * g_min) + (0.500 * b_min);
cb_max = (-0.169 * r_max) - (0.331 * g_max) + (0.500 * b_max);
cr_min = (0.5 * r_min) - (0.419 * g_min) - (0.081 * b_min);
cr_max = (0.5 * r_max) - (0.419 * g_max) - (0.081 * b_max);

YCbCr_limits = [y_min cb_min cr_min; 
                y_max cb_max cr_max];

% Switch Labels
YCbCr = 0;
RGB = 1;