time=linspace(0,pi,100);
x=sin(2.*pi.*60.*time);
y=sin(2.*pi.*60.*time-pi/4);

stem(x);hold all;
stem(y);
%%
X=fft(x);
Y=fft(y);
H=Y./X;

figure;
H_ampl=20.*log10(abs(H));
H_phase=unwrap(angle(H));
stem(H_ampl);
figure;
stem(H_phase);
%%
X=Y./H;
%%
X_ampl=(abs(X)); %DO NOT USE dB TO TAKE THE IFFT THIS!!!!!!!!!!
X_phase=unwrap(angle(X));

Xf=X_ampl.*exp(sqrt(-1).*X_phase);

Xt=real(ifft(Xf));
%%
figure;
plot(Xt./max(Xt),'linewidth',2);
hold all;
plot(x./max(x));
%%
y2=data2;
Y2=fft(y2);

X2=Y2./H;

X2_ampl=(abs(X2)); %DO NOT USE dB TO TAKE THE IFFT THIS!!!!!!!!!!
X2_phase=unwrap(angle(X2));

X2f=X2_ampl.*exp(sqrt(-1).*X2_phase);

X2t=real(ifft(X2f));
%%
figure;
plot(X2t./max(X2t),'linewidth',2); hold all;
plot(Xt./max(Xt),'linewidth',1);