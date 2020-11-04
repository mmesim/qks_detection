function CC_shifted = my_shift(y,tau,bpick,delta)
%Function to shift waveforms in frequency domain

%delay in samples
delay=(-tau(1,1)+bpick)./delta;

%frequencies
f=0:(1/(delta*length(y))):(1/(2*delta));

%fft and ifft
yp=fft(y); 

yp=yp(1:fix(length(y)/2)+1);

yp=yp.*exp(-1i*2*pi*f*delay*delta);

yp = [yp conj(fliplr(yp(2:end-1)))];

CC_shifted=ifft(yp,'symmetric');

end