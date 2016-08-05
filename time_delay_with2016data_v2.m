%%
%Last edited on Dec. 08, 2015.
function [w,Phase_fit,phase_delay] = time_delay_with2016data(data1,data2)
%% Load Data
date=80116;
suffix=2;
suffix43=suffix;
suffix44=suffix;
suffix48=suffix;
suffix50=suffix;
suffix39=suffix;
suffix42=suffix;
suffix37=suffix;
suffix29=suffix;
seg=2;
fs=100e6;

pathname = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date)];
cd(pathname)

C2_filename43 = ['C2AC0000',int2str(suffix43),'.trc']; %diode2 (0 m)

C1_filename44 = ['C1AC0000',int2str(suffix44),'.trc']; %diode5 (100 m)
C4_filename44 = ['C4AC0000',int2str(suffix44),'.trc']; %diode8 (200 m)

C3_filename48 = ['C3AC0000',int2str(suffix48),'.trc']; %diode11 (300 m)

C2_filename50 = ['C2AC0000',int2str(suffix50),'.trc']; %diode14 (400 m)

C1_filename39 = ['C1AC0000',int2str(suffix39),'.trc']; %diode17 (500 m)
C4_filename39 = ['C4AC0000',int2str(suffix39),'.trc']; %diode20 (600 m)

C3_filename42 = ['C3AC0000',int2str(suffix42),'.trc']; %diode23 (700 m)
 
C2_filename37 = ['C2AC0000',int2str(suffix37),'.trc']; %diode26 (800 m)

C1_filename29 = ['C1AC0000',int2str(suffix29),'.trc']; %diode29 (900 m)
C3_filename29 = ['C3AC0000',int2str(suffix29),'.trc']; %diode31 (1000 m)

% Change to the Scope43 directory
pathname43 = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date),'/Scope43/'];
C2_43 = read_lecroy([pathname43 C2_filename43]);

cd(pathname)

% Change to the Scope44 directory
pathname44 = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date),'/Scope44/'];

C4_44 = read_lecroy([pathname44 C4_filename44]);
C1_44 = read_lecroy([pathname44 C1_filename44]);

cd(pathname)

% Change to the Scope48 directory
pathname48 = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date),'/Scope48/'];

C3_48 = read_lecroy([pathname48 C3_filename48]);

% Change to the Scope50 directory
pathname50 = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date),'/Scope50/'];

C2_50 = read_lecroy([pathname50 C2_filename50]);

% Change to the Scope39 directory
pathname39 = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date),'/Scope39/'];

C4_39 = read_lecroy([pathname39 C4_filename39]);
C1_39 = read_lecroy([pathname39 C1_filename39]);

% Change to the Scope42 directory
pathname42 = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date),'/Scope42/'];

C3_42 = read_lecroy([pathname42 C3_filename42]);

% Change to the Scope37 directory
pathname37 = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date),'/Scope37/'];

C2_37 = read_lecroy([pathname37 C2_filename37]);

% Change to the Scope29 directory
pathname29 = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date),'/Scope29/'];

C1_29 = read_lecroy([pathname29 C1_filename29]);
C3_29 = read_lecroy([pathname29 C3_filename29]);

C2_43.data = offset(C2_43.data, 1000);

C4_44.data = offset(C4_44.data, 1000);
C1_44.data = offset(C1_44.data, 1000);

C3_48.data = offset(C3_48.data, 1000);

C2_50.data = offset(C2_50.data, 1000);

C4_39.data = offset(C4_39.data, 1000);
C1_39.data = offset(C1_39.data, 1000);

C3_42.data = offset(C3_42.data, 1000);

C2_37.data = offset(C2_37.data, 1000);

C1_29.data = offset(C1_29.data, 1000);
C3_29.data = offset(C3_29.data, 1000);
%%
diode2=C2_43.data(:,seg); z1=100;
diode5=C1_44.data(:,seg); z2=200;
diode8=C4_44.data(:,seg);
diode11=C3_48.data(:,seg);
diode14=C2_50.data(:,seg);
diode17=C1_39.data(:,seg);
diode20=C4_39.data(:,seg);
diode23=C3_42.data(:,seg);
diode26=C2_37.data(:,seg);
diode29=C1_29.data(:,seg);
diode31=C3_29.data(:,seg);
%% Declare Data
data1=diode8;
data2=diode11;
APD_data1=data1;
APD_data2=data2;
%% Plot figure 1
Ts=1/fs;
APD_sample=[0:length(APD_data1)-1]; %Sample array
APD_time=[0:length(APD_data1)-1].*Ts; %Time array
% plot(APD_time.*1e3,APD_data1,APD_time.*1e3,APD_data2)
% xlim([1.99,2.01])
% xlabel('Time (ms)')
% ylabel('Uncalibrated luminosity (arb. units)')

%% Apply window
Ts=1/fs;
% window size
n=(500e-6)/Ts; %number of samples in a 500us window
n0=(22e-6)/Ts; %window starts 40us before peak
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

% % Check window shape
% plot([0:length(data2)-1].*(1/fs),data2./max(data2)); hold on
% plot([0:length(h)-1].*(1/fs),h,'r'); hold on;
% plot([0:length(h_noise)-1].*(1/fs),h_noise,'m'); hold on;

%% Time Domain multiplication
h=h;%(1:2500001);
h_noise=h_noise;%(1:2500001);
time_mult_1=APD_data1.*h;
time_mult_2=APD_data2.*h;
noise_mult_1=APD_data1.*h_noise;
noise_mult_2=APD_data2.*h_noise;

noise_1=APD_data1(n0_noise:n0_noise+n);
noise_2=APD_data2(n0_noise:n0_noise+n);
n=NS;

time=[0:length(h)-1].*(1/fs);
plot( time,time_mult_1,...
    time,noise_mult_1 ); hold all;
plot( time,time_mult_2,...
    time,noise_mult_2 );
xlabel('Time (s)'); ylabel ('Digitalizer volts'); hold all;

%% Convolution in Frequency domain
%Declare High Frequency limit
% high_freq=2.5e6; %in Hz

numerator=fft(time_mult_2,n);
denominator=fft(time_mult_1,n);

numerator_noise=fft(noise_2,n);
denominator_noise=fft(noise_1,n);

% figure;
% plot( [0:n-1].*(fs/n).*1e-6,smooth(20*log10(abs(denominator)),100),'linewidth',2 ); hold all;
% plot( [0:n-1].*(fs/n).*1e-6,smooth(20*log10(abs(numerator)),100),'linewidth',2 );
% plot( [0:n-1].*(fs/n).*1e-6,smooth(20*log10(abs(denominator_noise)),100),'linewidth',2 );
% plot( [0:n-1].*(fs/n).*1e-6,smooth(20*log10(abs(numerator_noise)),100),'linewidth',2 );
% 
% xlab=xlabel('Frequency in MHz'); 
% ylab=ylabel('FFT Magnitude (dB)');
% legend('data1','data2','Noise of data1','Noise of data2')
% title('FFT of luminosity waveforms','fontsize',25)
% set(gca,'fontsize',20)
% set(xlab,'fontsize',25)
% set(ylab,'fontsize',25)
% xlim([0,2]);
% grid on

%% Error Analysis
high_freq=4e6;
freq=[0:n-1].*(fs/n);
[sigma1,location1]=findpeaks(20*log10(abs(denominator_noise)));
[sigma2,location2]=findpeaks(20*log10(abs(numerator_noise)));
% plot( freq, 20*log10(abs(denominator_noise)) ); hold all
% plot( freq(location1),sigma1,'r*');

sigma1=interp1(freq(location1),sigma1,freq,'spline');
sigma2=interp1(freq(location2),sigma2,freq,'spline');

% figure;
% plot(freq,sigma1,freq,sigma2); xlim([0 high_freq]); hold all;

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

% figure;
% plot( [0:n-1].*(fs/n),SNR1_dB );  hold all; %SNR amplitude (in dB) over frequency
% plot( [0:n-1].*(fs/n),SNR2_dB );
% xlabel('Frequency in Hz'); ylabel('Signal-to-Noise Ratio Magnitude (dB)'); xlim([0 high_freq]);
% legend('SNR (data1)','SNR (data2)')

SNR1_dB=SNR1_dB';
SNR2_dB=SNR2_dB';
SNR1_dB_BL=SNR1_dB(1:high_freq*1e-2); % chop frequency array. Obs: freq(1e4)=1 MHz
SNR2_dB_BL=SNR2_dB(1:high_freq*1e-2); % chop frequency array. Obs: freq(1e4)=1 MHz

snr_1=10.^(SNR1_dB_BL./20);
snr_2=10.^(SNR2_dB_BL./20);
snr_2=medfilt1(snr_2,5); %use medfilt1 because there are values > 1 (matlab asin function doesn't accept arguments > 1)


%%%%%%moving average filter
avg_SNR1= tsmovavg(SNR1_dB','s',100,1);
avg_SNR2= tsmovavg(SNR2_dB','s',100,1);
%%
figure;
plot( [0:n-1].*(fs/n).*1e-6,avg_SNR1 );  hold all; 
plot( [0:n-1].*(fs/n).*1e-6,avg_SNR2 );
plot([0,2.5e6],[10,10]); xlim([0,high_freq./1e6]); xlabel('Frequency (MHz)');

%% Measure phase

transfer=numerator./denominator;
phase=unwrap(angle(transfer));
freq=[0:n-1].*(fs/n);
w=freq.*2.*pi;

fc=210e3;
low_limit=30e3/(round(fs/n));
limit=fc/(round(fs/n))+1;

freq=freq(1:limit);% chop frequency array. Obs: freq(1e4)=1 MHz
a=numel(freq);
x=2.*pi.*freq';
y=phase; % in Rad
y=y(1:a);
figure;
plot(x,y);
%% Error Analysis
max_error_Magnitude=zeros(1,a);
min_error_Magnitude=zeros(1,a);
error_Magnitude=zeros(1,a);
for m=1:a,
    max_error_Magnitude(m)=( abs( numerator(m) )+sigma2(m) )/( abs( denominator(m) )-sigma1(m) );
    min_error_Magnitude(m)=( abs( numerator(m) )-sigma2(m) )/( abs( denominator(m) )+sigma1(m) );
    error_Magnitude(m)=( max_error_Magnitude(m)+min_error_Magnitude(m) )/2;
end

error_Phase=zeros(1,a);
for p=1:a,
    error_Phase(p)= asin (1/snr_2(p)) + asin (1/snr_1(p));
end

figure;
phase_error=smooth(error_Phase,100);
plot(freq(1:a).*1e-6,phase_error);
ylabel('Phase error (rad)') % right y-axis
xlabel('Frequency (MHz)');
phase_error=phase_error(low_limit:limit);
%% Fit through smoothed phase
freq=[0:n-1].*(fs/n);
w=2.*pi.*freq;
fittype='poly3'

[f,gof]=fit(w(low_limit:limit)',phase(low_limit:limit),fittype)
plot(f,w(low_limit:limit),phase(low_limit:limit))
%%
phase_fit=f.p1.*w.^3+f.p2.*w.^2+f.p3.*w+f.p4;

phase_delay=-(f.p1.*w.^2+f.p2.*w+f.p3+f.p4./w);

group_delay=-(3.*f.p1.*w.^2+2.*f.p2.*w.^1+f.p3);

phase_velocity=(z2-z1)./phase_delay;

group_velocity=(z2-z1)./group_delay;
%%
f=(w./2./pi).*1e-3;
plot(f(low_limit:limit),phase_fit(low_limit:limit)); hold all;
plot(f(low_limit:limit),phase_fit(low_limit:limit)+phase_error');
plot(f(low_limit:limit),phase_fit(low_limit:limit)-phase_error');
xlabel('Frequency (kHz)');
ylabel('Transfer function phase (radians)');
grid
%% Fit through upper limit
freq=[0:n-1].*(fs/n);
w=2.*pi.*freq;
fittype='poly3'
upper_limit=phase_fit(low_limit:limit)+phase_error';
[f,gof]=fit(w(low_limit:limit)',upper_limit',fittype)
plot(f,w(low_limit:limit),upper_limit)
phase_upper_limit=f.p1.*w.^3+f.p2.*w.^2+f.p3.*w+f.p4;
phase_delay_lower_limit=-(f.p1.*w.^2+f.p2.*w+f.p3+f.p4./w);
group_delay_lower_limit=-(3.*f.p1.*w.^2+2.*f.p2.*w+f.p3);
phase_velocity_upper_limit=(z2-z1)./phase_delay_lower_limit;
group_velocity_upper_limit=(z2-z1)./group_delay_lower_limit;
%% Fit through upper limit
freq=[0:n-1].*(fs/n);
w=2.*pi.*freq;
fittype='poly3'
lower_limit=phase_fit(low_limit:limit)-phase_error';
[f,gof]=fit(w(low_limit:limit)',lower_limit',fittype)
plot(f,w(low_limit:limit),lower_limit)
phase_lower_limit=f.p1.*w.^3+f.p2.*w.^2+f.p3.*w+f.p4;
phase_delay_upper_limit=-(f.p1.*w.^2+f.p2.*w+f.p3+f.p4./w);
group_delay_upper_limit=-(3.*f.p1.*w.^2+2.*f.p2.*w+f.p3);
phase_velocity_lower_limit=(z2-z1)./phase_delay_upper_limit;
group_velocity_lower_limit=(z2-z1)./group_delay_upper_limit;
%%
FigHandle = figure;
set(FigHandle, 'Position', [100, 100, 842, 595]);

c=2.99e8; %speed of light

subplot(221)
f=(w./2./pi).*1e-3;
plot(f(low_limit:limit),phase_fit(low_limit:limit),'Color',[0 114 189]./255); hold all;
plot(f(low_limit:limit),phase_fit(low_limit:limit)+phase_error','Color',[118 171 47]./255);
plot(f(low_limit:limit),phase_upper_limit(low_limit:limit),'Color',[216 82 24]./255);
plot(f(low_limit:limit),phase_fit(low_limit:limit)-phase_error','Color',[125 46 141]./255); 
plot(f(low_limit:limit),phase_lower_limit(low_limit:limit),'Color',[236 176 31]./255);
xlabel('Frequency (kHz)');
ylabel('Transfer function phase (radians)');
xlim([100,fc/1000]);
legend('best fit','upper limit','upper limit fit','lower limit','lower limit fit','location','northeast');
grid

subplot(222)
plot(f(low_limit:limit),phase_delay(low_limit:limit)); hold all;
plot(f(low_limit:limit),phase_delay_upper_limit(low_limit:limit));
plot(f(low_limit:limit),phase_delay_lower_limit(low_limit:limit));

xlabel('Frequency (kHz)');
ylabel('Phase delay (s)');
xlim([100,fc/1000]);
legend('best fit','upper limit fit','lower limit fit','location','northeast');
grid

subplot(223)
plot(f(low_limit:limit),(phase_velocity(low_limit:limit)./c).*100); hold all;
plot(f(low_limit:limit),(phase_velocity_upper_limit(low_limit:limit)./c).*100);
plot(f(low_limit:limit),(phase_velocity_lower_limit(low_limit:limit)./c).*100);
xlabel('Frequency (kHz)');
ylabel('Phase velocity (% of c)');
xlim([100,fc/1000]);
legend('best fit','upper limit fit','lower limit fit','location','northwest');
grid

subplot(224)
plot(f(low_limit:limit),(group_velocity(low_limit:limit)./c).*100); hold all;
plot(f(low_limit:limit),(group_velocity_upper_limit(low_limit:limit)./c).*100);
plot(f(low_limit:limit),(group_velocity_lower_limit(low_limit:limit)./c).*100);
xlabel('Frequency (kHz)');
ylabel('Group velocity (% of c)');
xlim([100,fc/1000]);
legend('best fit','upper limit fit','lower limit fit','location','northwest');
grid
string=['08-01-2016 (UF 16-10, RS 2) Diode 8 (200 m) to Diode 11 (300 m)']
suptitle(string)
set(0,'defaultlinelinewidth',2)
%%
sample_increment=50e3/(round(fs/n)); %50 kHz
samples_array=[2 3 4 5 6 7 8 9].*sample_increment;
figure;
frequency=f(samples_array);
narrowband_phase_velocity=phase_velocity(samples_array);
narrowband_phase_velocity_upper_limit=phase_velocity_upper_limit(samples_array)-narrowband_phase_velocity;
narrowband_phase_velocity_lower_limit=phase_velocity_lower_limit(samples_array)-narrowband_phase_velocity;
errorbar(frequency,(narrowband_phase_velocity./c).*100,...
         (narrowband_phase_velocity_upper_limit./c).*100,...
         (narrowband_phase_velocity_lower_limit./c).*100,'rx')
xlabel('Frequency (kHz)');
ylabel('Phase velocity (% of c)');

figure;     
narrowband_group_velocity=group_velocity(samples_array);
narrowband_group_velocity_upper_limit=group_velocity_upper_limit(samples_array)-narrowband_group_velocity;
narrowband_group_velocity_lower_limit=group_velocity_lower_limit(samples_array)-narrowband_group_velocity;
errorbar(frequency,(narrowband_group_velocity./c).*100,...
         (narrowband_group_velocity_upper_limit./c).*100,...
         (narrowband_group_velocity_lower_limit./c).*100,'rx')
xlabel('Frequency (kHz)');
ylabel('Group velocity (% of c)');
%%
D8_D11=struct('narrowband_phase_velocity',narrowband_phase_velocity,...
    'narrowband_phase_velocity_upper_limit',narrowband_phase_velocity_upper_limit,...
    'narrowband_phase_velocity_lower_limit',narrowband_phase_velocity_lower_limit,...
    'narrowband_group_velocity',narrowband_group_velocity,...
    'narrowband_group_velocity_upper_limit',narrowband_group_velocity_upper_limit,...
    'narrowband_group_velocity_lower_limit',narrowband_group_velocity_lower_limit)