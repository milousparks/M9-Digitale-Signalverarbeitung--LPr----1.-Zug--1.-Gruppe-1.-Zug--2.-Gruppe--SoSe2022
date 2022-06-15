function y = mysin(f,fs,T)

figure

sinf=@(t) sin(2*pi*t*f);
fplot(sinf,[0 T]);
title("Frequenz des Signales:",f)

xlabel("t [s]")
ylabel("Amplitude")
tstem=0:1/fs:T;
hold
t=0:1/fs:0.5;
stem(tstem,sinf(tstem))
grid on;

playblocking(audioplayer(sinf(t),fs))
end

