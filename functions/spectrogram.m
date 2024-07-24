function [S,F,T] = spectrogram(X,WINDOW,NOVERLAP,NFFT,Fs)
% This function has the same name as a MATLAB built-in function
% Use this one when Signal Processing toolbox is not available
% Or, we can totally replace reliance on Signal Processing toolbox if possible
% X is audio data
% WINDOW is length of each segment
% NOVERLAP is overlap between segments
% NFFT number of points for NFFT (needs to be an even number)
% Fs sampling rate in Hz

% Create a hamming window
n = 1:WINDOW;
win_hamm = 0.54 - 0.46*cos(2*pi*n./WINDOW);

len_X = length(X);%length of X in frame

F = linspace(0,Fs/2,(NFFT/2+1))';
T_seg = 1:(WINDOW - NOVERLAP):len_X-WINDOW;
T = (T_seg-1+WINDOW/2)/Fs;%time in seconds

S = zeros(length(F),length(T));%complex double <frequency x time>

for idx = 1:length(T_seg)
    segment = X(T_seg(idx):T_seg(idx)+WINDOW-1);
    fft_temp = fft(segment.*win_hamm, NFFT);
    S(:,idx) = fft_temp(1:(NFFT/2+1));
end