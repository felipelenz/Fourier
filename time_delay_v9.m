%%
%Last edited on Dec. 08, 2015.
function time_delay_v9
%% Load Data
date=081314;
suffix48=4;
suffix49=4;
suffix50=4;
event=51;
seg=5;
fs=500e6;

pathname = ['/Users/lenz/Documents/Research Stuff/Carvalho et al. (2016) - Frequency Domain/Data'];
cd(pathname)

C1_filename48 = ['C1AC00004.trc'];
C2_filename48 = ['C2AC00004.trc'];
C3_filename48 = ['C3AC00004.trc'];
C4_filename48 = ['C4AC00004.trc'];

C1_filename49 = ['C1AC00004.trc'];
C2_filename49 = ['C2AC00004.trc'];
C3_filename49 = ['C3AC00004.trc'];
C4_filename49 = ['C4AC00004.trc'];

C1_filename50 = ['C1AC00004.trc'];
C2_filename50 = ['C2AC00004.trc'];
C3_filename50 = ['C3AC00004.trc'];
C4_filename50 = ['C4AC00004.trc'];

% Change to the Scope48 directory
pathname48 = ['/Users/lenz/Documents/Research Stuff/Carvalho et al. (2016) - Frequency Domain/Data/Scope48/'];

C1_48 = read_lecroy([pathname48 C1_filename48]);
C2_48 = read_lecroy([pathname48 C2_filename48]);
C3_48 = read_lecroy([pathname48 C3_filename48]);
C4_48 = read_lecroy([pathname48 C4_filename48]);

cd(pathname)

% Change to the Scope49 directory
pathname49 = ['/Users/lenz/Documents/Research Stuff/Carvalho et al. (2016) - Frequency Domain/Data/Scope49/'];

C4_49 = read_lecroy([pathname49 C4_filename49]);
C2_49 = read_lecroy([pathname49 C2_filename49]);
C3_49 = read_lecroy([pathname49 C3_filename49]);
C1_49 = read_lecroy([pathname49 C1_filename49]);

cd(pathname)

% Change to the Scope50 directory
pathname50 = ['/Users/lenz/Documents/Research Stuff/Carvalho et al. (2016) - Frequency Domain/Data/Scope50/'];

C4_50 = read_lecroy([pathname50 C4_filename50]);
C2_50 = read_lecroy([pathname50 C2_filename50]);
C3_50 = read_lecroy([pathname50 C3_filename50]);
C1_50 = read_lecroy([pathname50 C1_filename50]);

C1_48.data = offset(C1_48.data, 1000);
C2_48.data = offset(C2_48.data, 1000);
C3_48.data = offset(C3_48.data, 1000);
C4_48.data = offset(C4_48.data, 1000);

C1_49.data = offset(C1_49.data, 1000);
C2_49.data = offset(C2_49.data, 1000);
C3_49.data = offset(C3_49.data, 1000);
C4_49.data = offset(C4_49.data, 1000);

C1_50.data = offset(C1_50.data, 1000);
C2_50.data = offset(C2_50.data, 1000);
C3_50.data = offset(C3_50.data, 1000);
C4_50.data = offset(C4_50.data, 1000);

%% Declare Data
data1=C1_48.data(:,seg); z1=4; %diode 1
% data2=C4_50.data(:,seg); z2=115; %diode 11
% data2=C2_48.data(:,seg); z2=10;%diode 2
data2=C3_48.data(:,seg); z2=16;%diode 3
% data1=C4_48.data(:,seg); z1=22;%diode 4
% data1=C1_49.data(:,seg); z1=28; %diode 5
% data2=C2_49.data(:,seg); z2=42.5; %diode 6
% data1=C3_49.data(:,seg); z1=57;%diode 7
% data1=C4_49.data(:,seg); z1=71.5; %diode 8
% data2=C2_50.data(:,seg); z1=86; %diode 9
% data2=C3_50.data(:,seg); z2=100.5; %diode 10
data1=data1(1:2500001);
data2=data2(1:2500001);
%%
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

fc=2000e3;
low_limit=30e3/(round(fs/n));
limit=fc/(round(fs/n))+1;%600 kHz

freq=freq(1:limit);% chop frequency array. Obs: freq(1e4)=1 MHz
a=numel(freq);
x=2.*pi.*freq';
y=phase; % in Rad
y=y(1:a);
figure;
plot(x./2./pi,y);
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
string=['08-13-2014 (UF 14-51, RS 6) Diode 1 (4 m) to Diode 3 (16 m)']
suptitle(string)
set(0,'defaultlinelinewidth',2)

savefig(string);
%%
sample_increment=50e3/(round(fs/n)); %50 kHz
samples_array=[2 3 4 5 6 7 8 9 10 11 12 13 15 16 17 19 20].*sample_increment;
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
D1_D3=struct('narrowband_phase_velocity',narrowband_phase_velocity,...
    'narrowband_phase_velocity_upper_limit',narrowband_phase_velocity_upper_limit,...
    'narrowband_phase_velocity_lower_limit',narrowband_phase_velocity_lower_limit,...
    'narrowband_group_velocity',narrowband_group_velocity,...
    'narrowband_group_velocity_upper_limit',narrowband_group_velocity_upper_limit,...
    'narrowband_group_velocity_lower_limit',narrowband_group_velocity_lower_limit)