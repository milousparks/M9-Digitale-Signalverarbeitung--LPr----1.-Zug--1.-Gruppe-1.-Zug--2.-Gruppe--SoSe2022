function [mag, phi] = H (w)
h=[0.035 0.24 0.447 0.24 0.035];
n=0:length(h)-1;
fg=zeros(length(w),1);
for i=1:length(w)
fg(i)=sum(h.*exp(-1i.*n.*w(i)));
end
mag=abs(fg);
phi=angle(fg);
end

