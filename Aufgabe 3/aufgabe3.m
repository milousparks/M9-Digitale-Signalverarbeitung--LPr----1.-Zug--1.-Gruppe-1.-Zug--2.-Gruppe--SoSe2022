% Aufgabenblatt 3
% 3.1 Impulsantwort
close all
clear

aver=@(x) (sum(x,[1 3]))/3;

n=-10:10;
xn=zeros(length(n),1);
xn((length(n)-1)/2+1)=1;

for i=3:length(n)
    yn(i)= aver(xn((i-2):i))
end
stem(n,yn)
grid on
xlabel('[n]')
ylabel('Amplitude')
%%
%b
f=4; %Hz 
fs=64; %Hz
A=1;
input=@(t) square(f*t*2*pi);
t=0:1/fs:1;
n2=1:length(t);

output=conv(input(t),yn,'same');

figure;
plot(n2,input(t))
hold on
plot(n2,output)
legend('Input','Output')
grid on;
%% 
%c
f=[4,8,16,32]; %Hz 
fs=64; %Hz
A=1;
t=0:1/fs:1;
n2=1:length(t);
input=@(t,f) sin(f*t*2*pi);

figure
for i=1:4
    output(i,:)=conv(input(t,f(i)),yn,'same');
    figure
    plot(n2,input(t,f(i)))
    grid on
hold on
stem(n2,output(i,:))
end
xlabel('[n]')
ylabel('Amplitude')

grid on;

% Das System hat ein Tiefpass Verhalten. Die Sinen höherer Frequenz werden
% in ihrer Amplitude gedämpft. Dies geschied durch die Mittelwertbildung
% über immer drei Werte
%%
%3.2 LSI Systeme

%Definition Signale
close all
n=0:16;
x1=sin(6*pi*n/16);
x2=sin(10*pi*n/16);
hn= [1 0.5 0.25]; %Impulsantwort

y1=conv(hn,x1); % Faltung mit x1
y2=conv(hn,x2); % Faltung mit x2

a=0.5;
b=2;

xges=a*x1+b*x2; % Ermittlung von Xges
yges=conv(hn,xges); % Faltung von xges mit Impulsantwort

yges2=a*y1+b*y2;

plot(0:(length(yges)-1),yges,'-x')
hold on
plot(0:(length(yges)-1),yges2,'-o')
grid on
title('Plot: Nachweis der Linearität')
figure
stem(yges,'x')
hold on
stem(yges2,'o')
grid on
title('Stem: Nachweis der Linearität')

% Die Linearität ist in den Plots zu erkennen, da die ensprechenden
% Ausgangsignale gleich sind.
%%
%3.3 Reihenschaltung von LSI Systemen
close all

h1=[1 0.5 0.25]; % Sys 1
h2=[-0.25 -1 -0.5];% Sys 2

yn=h1; %Impulsantwort
 
zn=conv(h2,yn);
zn2=conv(h1,h2);
stem(zn,'LineStyle','-.','MarkerFaceColor','red')
hold on
stem(zn2,'LineStyle','-.','MarkerFaceColor','blue')
grid on

% Die Ausgangssignale sind identisch

%%
% 3.4 Manuelle Aufnahme des Frequenzganges
close all
hn=[0.25 0.25 0.25 0.25];
fs=64; %Hz
f=[1 11 21 32 51]; %Hz
T=3; %s
t=0:1/fs:T;
y=zeros(5,196);
for i=1:length(f)
y(i,:)=conv(sin((2*pi*f(i))*t),hn);
end
%plot(0:length(y(1,:))-1,y(1,:))
ymax=max(y,[],2);
plot(f,ymax)
xlabel('f [Hz]')
ylabel('Amplitude')
title('Amplitudengang Linear')
grid on

%%
% 3.5 Frequenzgang
close all
h=[0.25 0.25 0.25 0.25];
fvec=1:1:1e3;
spec=getSpectrum(h,fvec);
plot(fvec,spec)
grid on
ylabel('Amplitude')
xlabel('f [Hz]')
%%
figure
[f,specLog]=getSpectrumLog(h,1,3,1000);
semilogx(f,specLog)
grid on;
ylabel('Amplitude [dB]')
xlabel('f [Hz]')

% Die Grenzfrequenz ist definiert bei -3 dB. Durch ablesen ist die
% Grenzfrequenz fg=332 Hz



