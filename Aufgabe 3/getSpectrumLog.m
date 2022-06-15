function [f, spec] = getSpectrumLog (h, exp1, exp2, n)
f1=10^(exp1);
f2=10^(exp2);
f=logspace(exp1,exp2,n);
spec=20*log10(getSpectrum(h,f));

end

