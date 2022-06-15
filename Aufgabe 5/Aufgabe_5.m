% Aufgabenblatt 5
% 5.1 Signalanalyse
close all
[sample3,fs]=audioread("sample3.wav");
N=10000;
y=sample3(1:N);
spectrum=fft(y);
mag=abs(spectrum)*1/N; % Skaliertes Spektrum
stem(0:length(spectrum)-1,mag)
grid on
grid minor
ylabel('Amplitude')
xlabel('n [\Omega_0]')
harmonic1=[mag(126);mag(251);mag(501)]
frequencys1=[mag(1)*fs/N;125*fs/N;250*fs/N;500*fs/N]
title('N=10k Abtastwerte')
%%
figure
N=1000;
y=sample3(1:N);
spectrum=fft(y);
mag=abs(spectrum)*1/N; % Skaliertes Spektrum
stem(0:length(spectrum)-1,mag)
grid on
grid minor
ylabel('Amplitude')
xlabel('n [\Omega_0]')
harmonic2=[mag(126);mag(251);mag(501)]
frequencys2=[mag(1)*fs/N;125*fs/N;250*fs/N;500*fs/N]
title('N=1k Abtastwerte')
% Erklärung TODO
%%
% 5.3 Saegezahn 

