% Aufgabenblatt 5
% 5.1 Signalanalyse
close all
[sample3,fs]=audioread("sample3.wav") ;
y=sample3(1:10000);
spectrum=fft(y);
stem(abs(spectrum))
grid on
grid minor
ylabel