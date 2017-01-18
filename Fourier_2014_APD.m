% The original file from which this code was based is called time_delay_v9_SNR.m
% and can be found on https://github.com/felipelenz/Fourier
% Code by Felipe Lenz

% Step 1: run the code PNRFRead_2014_Doug.m file, also found in the link
% above. To run the PNRF file, simple input [W,xstart] = PNRFRead_2014_Doug(sweep)
% in MATLAB's command window. The W and xstart are the outputs of the file
% and sweep number can be found in the 2014 Summary Table

% Step 2: Understand the output. W is a struct, which contains many
% measurements. Here, we are interested in the outputs W.IIHIData
% (Channel-base current) and W.APDData (Channel-base luminosity). Be
% mindful that the time bases are the same and that they do not take in
% consideration propagation delay. We will have to remove those by hand.

%% Current-to-Luminosity
data1=W.IIHIData;
data2=W.APDData;
fs=100e6; %HBM system sampling rate is 100 MHz
%%
IIHI_Data=data1;
APD_Data=[data2 0 0 0 0];%(1:end-48);
%x Plot figure 1
Ts=1/fs;
APD_sample=[0:length(IIHI_Data)-1]; %Sample array
APD_time=[0:length(IIHI_Data)-1].*Ts; %Time array
% plot(APD_time.*1e3,IIHI_Data,APD_time.*1e3,APD_Data)
% xlim([1.99,2.01])
% xlabel('Time (ms)')
% ylabel('Uncalibrated luminosity (arb. units)')
%x Apply window
Ts=1/fs;
% window size
n=(500e-6)/Ts; %number of samples in a 500us window
n0=(45e-6)/Ts; %window starts 40us before peak
n0_noise=(1000e-6)/Ts; %noise window starts 1ms before peak

% Define Tukey Window
NS=numel(data1);
h=tukeywin(n,0.15);
[~,index]=max(data1);

% Add zeroes before the window
h1=linspace(0,0,index-n0);
h1_noise=linspace(0,0,index-n0_noise);

% Add zeroes after window
a=numel(h); b=numel(h1); b_noise=numel(h1_noise);
c=NS-a-b; c_noise=NS-a-b_noise;
h2=linspace(0,0,c);
h2_noise=linspace(0,0,c_noise);

% Combine h1,h,h2 into one array (tuckeywin zero padded)
h_noise=[h1_noise';h;h2_noise'];
h=[h1';h;h2'];
%x
% Check window shape
figure;
% subplot(211)
plot([0:length(data1)-1].*(1/fs).*1e3,data1./max(data1)); hold on
plot([0:length(h)-1].*(1/fs).*1e3,h,'r'); hold on;
plot([0:length(h_noise)-1].*(1/fs).*1e3,h_noise,'m'); hold on;
xlabel('Time (ms)');
ylabel('Amplitude-normalized luminosity');
grid
title('Photodiode D6 (42.5 m)');
% subplot(212)
% plot([0:length(data2)-1].*(1/fs),data2./max(data2)); hold on
% plot([0:length(h)-1].*(1/fs),h,'r'); hold on;
% plot([0:length(h_noise)-1].*(1/fs),h_noise,'m'); hold on;
%%
%x Time Domain multiplication
h=h.';
h_noise=h_noise.';
time_mult_1=IIHI_Data.*h;
time_mult_2=APD_Data.*h;

noise_mult_1=IIHI_Data.*h_noise;
noise_mult_2=APD_Data.*h_noise;

noise_1=IIHI_Data(n0_noise:n0_noise+n);
noise_2=APD_Data(n0_noise:n0_noise+n);
n=NS;

% time=[0:length(h)-1].*(1/fs);
% plot( time,time_mult_1,...
%     time,noise_mult_1 ); hold all;
% plot( time,time_mult_2,...
%     time,noise_mult_2 );
% xlabel('Time (s)'); ylabel ('Digitalizer volts'); hold all;
% 
%x Convolution in Frequency domain
%Declare High Frequency limit
% high_freq=2.5e6; %in Hz

numerator=fft(time_mult_2,n);
denominator=fft(time_mult_1,n);

numerator_noise=fft(noise_2,n);
denominator_noise=fft(noise_1,n);
%%
figure;
plot( [0:n-1].*(fs/n).*1e-3,smooth(20*log10(abs(numerator)),10),'linewidth',2 ); hold all;
plot( [0:n-1].*(fs/n).*1e-3,smooth(20*log10(abs(denominator)),10),'linewidth',2 );
plot( [0:n-1].*(fs/n).*1e-3,smooth(20*log10(abs(numerator_noise)),10),'linewidth',2 );
plot( [0:n-1].*(fs/n).*1e-3,smooth(20*log10(abs(denominator_noise)),10),'linewidth',2 );

xlab=xlabel('Frequency in kHz'); 
ylab=ylabel('FFT magnitude (dB)');
legend('IIHI','APD','Noise of IIHI','Noise of APD','location','southeast')
title('FFT of luminosity waveforms','fontsize',25)
set(gca,'fontsize',16)
% xlim([0,2000]);
grid on
%% Error Analysis
high_freq=4e6;
freq=[0:n-1].*(fs/n);
[sigma1,location1]=findpeaks(double(20*log10(abs(denominator_noise))));
[sigma2,location2]=findpeaks(double(20*log10(abs(numerator_noise))));
% plot( freq, 20*log10(abs(denominator_noise)) ); hold all
% plot( freq(location1),sigma1,'r*');

sigma1=interp1(freq(location1),sigma1,freq,'spline');
sigma2=interp1(freq(location2),sigma2,freq,'spline');
% figure;
plot(freq,sigma1,freq,sigma2); xlim([0 high_freq]); hold all;

for index=1:3,
    [sigma1,location1]=findpeaks(sigma1);
%     plot(freq(location1),sigma1,'r*');
    sigma1=interp1(freq(location1),sigma1,freq,'spline');
    
    [sigma2,location2]=findpeaks(sigma2);
%     plot(freq(location2),sigma2,'g*');
    sigma2=interp1(freq(location2),sigma2,freq,'spline');
    
%     plot(freq,sigma1,freq,sigma2); xlim([0 high_freq]); hold all;
%     figure;
%     plot(freq,sigma1,'r',freq,sigma2,'c'); xlim([0 high_freq]); hold all;
%     xlabel('frequency (Hz)'); ylabel('Standard Deviation Magnitude (dB)');
%     legend('sigma1 (data1)','sigma2 (data2)');
end

SNR1_dB=20*log10(abs(denominator./denominator_noise) );
SNR2_dB=20*log10(abs(numerator./numerator_noise) );

figure;
plot( [0:n-1].*(fs/n),SNR1_dB );  hold all; %SNR amplitude (in dB) over frequency
plot( [0:n-1].*(fs/n),SNR2_dB );
xlabel('Frequency in Hz'); ylabel('Signal-to-Noise Ratio Magnitude (dB)'); xlim([0 high_freq]);
legend('SNR (data1)','SNR (data2)')

SNR1_dB=SNR1_dB';
SNR2_dB=SNR2_dB';
SNR1_dB_BL=SNR1_dB(1:high_freq*1e-2); % chop frequency array. Obs: freq(1e4)=1 MHz
SNR2_dB_BL=SNR2_dB(1:high_freq*1e-2); % chop frequency array. Obs: freq(1e4)=1 MHz

snr_1=10.^(SNR1_dB_BL./20);
snr_2=10.^(SNR2_dB_BL./20);

snr_2=medfilt1(snr_2,5); %use medfilt1 because there are values > 1 (matlab asin function doesn't accept arguments > 1)

avg_SNR1=tsmovavg(SNR1_dB,'s',100,1);
avg_SNR2=tsmovavg(SNR2_dB,'s',100,1);

figure;
plot( [0:n-1].*(fs/n).*1e-6,avg_SNR1 );  hold all; 
plot( [0:n-1].*(fs/n).*1e-6,avg_SNR2 );
plot([0,2.5e6],[10,10]); xlim([0,high_freq./1e6]); xlabel('Frequency (MHz)');

%% Measure phase
transfer=numerator./denominator;
amplitude=20*log10(abs(transfer))-20*log10(abs(transfer(1)));
phase=unwrap(angle(transfer));
freq=[0:n-1].*(fs/n);
w=freq.*2.*pi;

fi=1;
fc=1e6;
low_limit=fi/(round(fs/n));
limit=fc/(round(fs/n))+1;

freq=freq(low_limit:limit);% chop frequency array.
a=numel(freq);
x=2.*pi.*freq';
x=x(low_limit:a);

y=phase; % in Rad
y=double(y(low_limit:a).');
amplitude=double(amplitude(low_limit:a).'); % in dB

figure;
subplot(211)
plot((x./2./pi).*1e-6,amplitude);
title('Current-to-Luminosity Transfer Function');
ylabel('Transfer Function Amplitude (dB)');
xlabel('Frequency (MHz)');
subplot(212)
plot((x./2./pi).*1e-6,y);
ylabel('Transfer Function Phase (rad)');
xlabel('Frequency (MHz)');