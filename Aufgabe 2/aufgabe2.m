% Aufgabe 2 
% Milan Daniel Larsen 581829
% Dany Karel Kenfack Nguemo 571705
% 2.1

[sample1,fs]=audioread("sample1.wav");
fprintf('Abtastrate: %d Hz \n',fs)
n=0:length(sample1)-1;
T=1/fs;
t=T*length(sample1);
fprintf('Länge der Aufnahme: %d s \n',t)

%hold on
%plot(n,sample1(:,1))
mono=sum(sample1,2)/2;
tp=4; %sec
disp('Stereo Signal:')
playblocking(audioplayer(sample1(1:tp*fs,:),fs))
disp('Mono Signal:')
playblocking(audioplayer(mono(1:tp*fs),fs))
% c Unterabtastung
disp('Mono Unterabtastung:')
monou=mono(1:10:tp*fs);
playblocking(audioplayer(monou,fs/10))
% Durch die Auswahl jedes zweiten Elementes halbiert sich die
% Abtastfrequenz
% Wenn ohne halbierung der Abtastfrequenz das Signal abgespeilt wird,
% erscheint es schneller als normal
rng=awgn(monou,40);
disp('Mono mit Rauschen:')
playblocking(audioplayer(rng,fs/10))
%%
% 2.2 Linearität
[sample1,fs]=audioread("sample1.wav");
sample1=sample1.^2;
tp=4; %sec
disp('Stereo Signal:')
playblocking(audioplayer(sample1(1:tp*fs,:),fs))
% Die Operation verzerrt das Signal deutlich
%%
% 2.3 Erzeugen einer Audiodatei
leng=3; %s
nBits=16;
fs=44100;
ch=2;

myVoice=audiorecorder(fs,nBits,ch);
disp('Start Record Audio:')
recordblocking(myVoice, 3);
disp('Stop Record Audio:')
y = getaudiodata(myVoice);
%%

maxy=max(y);
x=1./maxy;
ynrom=y(:,:).*x;
%%
disp('Aufnahme:')
playblocking(audioplayer(y,fs))
disp('Aufnahme normiert:')
playblocking(audioplayer(ynrom,fs))
%%
filename = 'audfnahme.wav';
audiowrite(filename,ynrom,fs);
clear y Fs

%%
% Abtasttheorem 
close all
T=0.001; %s
fs=2000; %Hz
for f=1700:100:2300
    mysin(f,fs,T)
end

% Der T0n mit f=2kHz ist nicht hörbar weil, die Abtastung genau auf den
% Nulldurchgang fällt. Im Frequenzbereich von 1700 Hz bis 1900 Hz ist
% bereits das Abtasttheorem verletzt. Durch die Abtastung mit 2kHz erscheint die Frequenz zu sinken je näher man sich den 
% 2 kHz von unten aus annähert. Andersrum verhält es sich nachdem man die
% 2kHz überschritten hat. 

