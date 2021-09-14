function Hd = Mid-high_2000-4000
%MID-HIGH(2-4KHZ) Returns a discrete-time filter object.

%
% MATLAB Code
% Generated by MATLAB(R) 7.14 and the Signal Processing Toolbox 6.17.
%
% Generated on: 17-Nov-2012 11:45:28
%

% Butterworth Bandpass filter designed using FDESIGN.BANDPASS.

% All frequency values are in Hz.
Fs = 32000;  % Sampling Frequency

N   = 2;     % Order
Fc1 = 2000;  % First Cutoff Frequency
Fc2 = 4000;  % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
Hd = design(h, 'butter');

% [EOF]