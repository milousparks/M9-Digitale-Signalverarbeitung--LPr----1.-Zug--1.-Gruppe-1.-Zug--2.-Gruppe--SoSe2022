function spec = getSpectrum(h, fvec)
fs=8000; %kHz
t=3; %s
n=0:1/fs:t;
for i=1:length(fvec)
y(i,:)=conv(sin((2*pi*fvec(i))*n),h);
spec=max(y,[],2);
end
end

