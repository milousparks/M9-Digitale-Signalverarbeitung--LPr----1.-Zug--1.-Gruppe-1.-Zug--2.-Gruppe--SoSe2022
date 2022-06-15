% Aufgabenblatt 4
% 4.1 Simulation eines akustischen Systems

[h1,fs]=audioread("IR_mid.wav");
[h2,fs]=audioread("IR_large.wav");

%playblocking(audioplayer(h1,fs))
%playblocking(audioplayer(h2,fs))

% Man hört eine impulsantwort von zwei verschiedenen Räumen.

[sample2,fs]=audioread("sample2.wav");
%%
y1=conv(sample2,h1); % Faltung von sample2 mit h1
y1norm=y1/max(y1); % Normierung auf max 1

% Wiedergabe der Originalaufnhame und der normalisierten Faltung
disp('Original Aufnahme:')
%playblocking(audioplayer(sample2,fs))
disp('Original Faltung mit h1:')
%playblocking(audioplayer(y1norm,fs))

y2=conv(sample2,h2); % Faltung von sample2 mit h2
y2norm=y2/max(y2);   % Normierung auf max 1

disp('Original Faltung mit h2:')
%playblocking(audioplayer(y2norm,fs))
%%
% Ploten der Impulsantworten
n=0:length(h1)-1;
T=1/fs;
t=0:T:T*n(end);

subplot(2,1,1)
plot(t ,h1)
xlim([0 0.15]);
ylim([-1 1]);
grid  on
ylabel('Amplitude')
xlabel('t [s]')
subplot(2,1,2)
plot(0:(1/fs):1/fs*(length(h2)-1) ,h2)
xlim([0 0.15]);
ylim([-1 1]);
ylabel('Amplitude')
xlabel('t [s]')
grid  on
% Die Impulsantwort h2 hat eine höhere Amplitude und damit Verstärkung
% sowie einen zweiten peak etwas später
%%
% 4.2 Künstliches Echo
t=0:1/fs:0.4;
h1=zeros(length(t),1);
h1(end)=1;

y1=conv(sample2,h1,'same');
sound(1,:)=sample2;
sound(2,:)=y1;
% Wiedergabe der Faltung Echo
disp('Faltung Echo 1x:')
playblocking(audioplayer(sound,fs))

%%
h2=[h1;h1;h1;h1;h1;h1;h1;h1;h1;h1];
y2=conv(sample2,h2);

% Wiedergabe der Faltung Echo
disp('Faltung Echo 10x:')
playblocking(audioplayer(y2,fs))
%%
N=0:10;
h3=[0.5^N(1)*h1;0.5^N(2)*h1;0.5^N(3)*h1;0.5^N(4)*h1;0.5^N(5)*h1;0.5^N(6)*h1;0.5^N(7)*h1;0.5^N(8)*h1;0.5^N(9)*h1;0.5^N(10)*h1];
y3=conv(sample2,h3);
% Wiedergabe der Faltung Echo
disp('Faltung Echo 10x mit abnehmender Amplitude:')
playblocking(audioplayer(y3,fs))
%%
% 4.3 Impulsantwort vs. Frequenzgang
close all

w=linspace(0,6*pi,1000);
[mag,phi]=H(w);
figure
subplot(2,1,1)
plot(w,mag)
set(gca,'XTick',0:pi:6*pi)
set(gca,'XTickLabel',{'0','$\pi$','$2\cdot\pi$','$3\cdot\pi$','$4\cdot\pi$','$5\cdot\pi$','$6\cdot\pi$'},'TickLabelInterpreter', 'latex')
set(gca,'fontsize',25)
xlabel('\omega')
ylabel('Amplitude')
grid on
subplot(2,1,2)
plot(w,phi)
set(gca,'XTick',0:pi:6*pi)
set(gca,'XTickLabel',{'0','$\pi$','$2\cdot\pi$','$3\cdot\pi$','$4\cdot\pi$','$5\cdot\pi$','$6\cdot\pi$'},'TickLabelInterpreter', 'latex')
set(gca,'fontsize',25)
set(gca,'YTick',-pi:pi:pi)
set(gca,'YTickLabel',{'$-\pi$','0','$\pi$'},'TickLabelInterpreter', 'latex')
xlabel('\omega')
ylabel('Phase')
%semilogx(w,20*log10(mag))
grid on

% Es handelt sich um einen Tiefpass. Bei pi wird die Nyquist frequenz
% erreciht und der Amplituden sowie Phasengange wiederholt sich periodisch 
figure
f=1:1:11025; %Hz 
fs=22050; %Hz 
subplot(2,1,1)
w=2*pi*f/fs;
[mag,phi]=H(w);
semilogx(f,20*log10(mag))
set(gca,'fontsize',25)
grid on
subplot(2,1,2)
semilogx(f,phi)
set(gca,'YTick',-pi:pi:pi)
set(gca,'YTickLabel',{'$-\pi$','0','$\pi$'},'TickLabelInterpreter', 'latex')
set(gca,'fontsize',25)
grid on

% fg= 3.311 Hz
%%
close all
fs=22050; %Hz 
f1=fs/2;
t1=10;
t=0:1/fs:t1; %s 
h=[0.035 0.24 0.447 0.24 0.035];
f0=1; % Hz
cossweep=chirp(t,f0,t1,(f1),"linear");
pspectrum(cossweep,fs,'spectrogram','TimeResolution',0.1, ...
    'OverlapPercent',99,'Leakage',0.85 )
figure
y=conv(cossweep,h);
plot(0:length(y)-1,y)
figure
plot(t,cossweep)
