date=072514;
suffix48=0;
suffix49=0;
suffix50=0;
event=35;

pathname = ['/Volumes/Promise 12TB RAID5/2014 Data/0',num2str(date)];
cd(pathname)
%%
C1_filename48 = ['C1AC0000',num2str(suffix48),'.trc'];
C2_filename48 = ['C2AC0000',num2str(suffix48),'.trc'];
C3_filename48 = ['C3AC0000',num2str(suffix48),'.trc'];
C4_filename48 = ['C4AC0000',num2str(suffix48),'.trc'];

C1_filename49 = ['C1AC0000',num2str(suffix49),'.trc'];
C2_filename49 = ['C2AC0000',num2str(suffix49),'.trc'];
C3_filename49 = ['C3AC0000',num2str(suffix49),'.trc'];
C4_filename49 = ['C4AC0000',num2str(suffix49),'.trc'];

C1_filename50 = ['C1AC0000',num2str(suffix50),'.trc'];
C2_filename50 = ['C2AC0000',num2str(suffix50),'.trc'];
C3_filename50 = ['C3AC0000',num2str(suffix50),'.trc'];
C4_filename50 = ['C4AC0000',num2str(suffix50),'.trc'];

% Change to the Scope48 directory
pathname48 = ['/Volumes/Promise 12TB RAID5/2014 Data/0',num2str(date),'/Scope48/'];

C1_48 = read_lecroy([pathname48 C1_filename48]);
C2_48 = read_lecroy([pathname48 C2_filename48]);
C3_48 = read_lecroy([pathname48 C3_filename48]);
C4_48 = read_lecroy([pathname48 C4_filename48]);

cd(pathname)

% Change to the Scope49 directory
pathname49 = ['/Volumes/Promise 12TB RAID5/2014 Data/0',num2str(date),'/Scope49/'];

C4_49 = read_lecroy([pathname49 C4_filename49]);
C2_49 = read_lecroy([pathname49 C2_filename49]);
C3_49 = read_lecroy([pathname49 C3_filename49]);
C1_49 = read_lecroy([pathname49 C1_filename49]);

cd(pathname)

% Change to the Scope50 directory
pathname50 = ['/Volumes/Promise 12TB RAID5/2014 Data/0',num2str(date),'/Scope50/'];

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
%% D1, D3, D6, D11
seg=4;
plot(C1_48.data(:,seg)./max(C1_48.data(:,seg))); hold all;
plot(C3_48.data(:,seg)./max(C3_48.data(:,seg)));
plot(C2_49.data(:,seg)./max(C2_49.data(:,seg)));
% plot(C4_50.data(:,seg)./max(C4_50.data(:,seg)));
test=C4_50.data(:,seg);
test2=resample(test,1.25e9,50e6);
plot(test2./max(test2))
fs=1.25e9;
%% Declare Data
% data1=C1_48.data(:,seg); z1=4; %diode 1
% data2=test2(1:end-48); z2=115; %C4_50.data(:,seg); z2=115; %diode 11
% data2=C2_48.data(:,seg); z2=10;%diode 2
% data2=C3_48.data(:,seg); z2=16;%diode 3
% data2=C4_48.data(:,seg); z1=22;%diode 4
% data1=C1_49.data(:,seg); z1=28; %diode 5
% data1=C2_49.data(:,seg); z1=42.5; %diode 6
% data1=C3_49.data(:,seg); z1=57;%diode 7
% data2=C4_49.data(:,seg); z1=71.5; %diode 8
% data1=C2_50.data(:,seg); z1=86; %diode 9
% data2=C3_50.data(:,seg); z2=100.5; %diode 10
%% D1-D3
data1=C1_48.data(:,seg); z1=4; %diode 1
data2=C3_48.data(:,seg); z2=16;%diode 3
%% D3-D6
data1=C3_48.data(:,seg); z1=16;%diode 3
data2=C2_49.data(:,seg); z2=42.5; %diode 6
%% D6-D11
data1=C2_49.data(:,seg); z1=42.5; %diode 6
data2=test2; z2=115;
% data2=C4_50.data(:,seg); z2=115; %diode 11
%%
data1=data1(1:8e6);
data2=test2(1:8e6);
% data2=data2(1:2e6);
%%
APD_data1=data1;
APD_data2=data2;%(1:end-48);
%x Plot figure 1
Ts=1/fs;
APD_sample=[0:length(APD_data1)-1]; %Sample array
APD_time=[0:length(APD_data1)-1].*Ts; %Time array
% plot(APD_time.*1e3,APD_data1,APD_time.*1e3,APD_data2)
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
% % Check window shape
% figure;
% subplot(211)
% plot([0:length(data1)-1].*(1/fs).*1e3,data1./max(data1)); hold on
% plot([0:length(h)-1].*(1/fs).*1e3,h,'r'); hold on;
% plot([0:length(h_noise)-1].*(1/fs).*1e3,h_noise,'m'); hold on;
% xlabel('Time (ms)');
% ylabel('Amplitude-normalized luminosity');
% grid
% title('Photodiode D6 (42.5 m)');
% subplot(212)
% plot([0:length(data2)-1].*(1/fs),data2./max(data2)); hold on
% plot([0:length(h)-1].*(1/fs),h,'r'); hold on;
% plot([0:length(h_noise)-1].*(1/fs),h_noise,'m'); hold on;

%x Time Domain multiplication
h=h;%(1:2500001);
h_noise=h_noise;%(1:2500001);
time_mult_1=APD_data1.*h;
time_mult_2=APD_data2.*h;
noise_mult_1=APD_data1.*h_noise;
noise_mult_2=APD_data2.*h_noise;

noise_1=APD_data1(n0_noise:n0_noise+n);
noise_2=APD_data2(n0_noise:n0_noise+n);
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

numerator=fft(time_mult_2,n);%./fft(h);
denominator=fft(time_mult_1,n);%./fft(h);

numerator_noise=fft(noise_2,n);%./fft(h);
denominator_noise=fft(noise_1,n);%./fft(h);
%x
figure;
plot( [0:n-1].*(fs/n).*1e-3,smooth(20*log10(abs(numerator)),10),'linewidth',2 ); hold all;
plot( [0:n-1].*(fs/n).*1e-3,smooth(20*log10(abs(denominator)),10),'linewidth',2 );
plot( [0:n-1].*(fs/n).*1e-3,smooth(20*log10(abs(numerator_noise)),10),'linewidth',2 );
plot( [0:n-1].*(fs/n).*1e-3,smooth(20*log10(abs(denominator_noise)),10),'linewidth',2 );

xlab=xlabel('Frequency in kHz'); 
ylab=ylabel('FFT magnitude (dB)');
legend('data1','data2','Noise of data1','Noise of data2','location','southeast')
title('FFT of luminosity waveforms','fontsize',25)
set(gca,'fontsize',16)
xlim([0,2000]);
grid on

%x
% sample_increment=100e3/(round((fs/n)*1e7)/1e7); %200 kHz
% samples_array=[1 2 3 4 5 6 7 8 9 10].*sample_increment;
% data1_amplitudedB=smooth(20*log10(abs(numerator)),10);
% data2_amplitudedB=smooth(20*log10(abs(denominator)),10);
% Amplitude1_dB=data1_amplitudedB(samples_array)
% Amplitude2_dB=data2_amplitudedB(samples_array)

% figure(2);
% plot( [0:n-1].*(fs/n).*1e-6,smooth(20*log10(abs(denominator./denominator_noise)),5),'linewidth',2 ); hold all;
% plot( [0:n-1].*(fs/n).*1e-6,smooth(20*log10(abs(numerator./numerator_noise)),5),'linewidth',2 );
% 
% xlab=xlabel('Frequency in MHz'); 
% ylab=ylabel('SNR magnitude (dB)');
% legend('data1','data2','location','southeast')
% set(gca,'fontsize',16)
% xlim([0,3.5]);
% grid on

%x Error Analysis
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

%x
figure;
plot( [0:n-1].*(fs/n).*1e-6,avg_SNR1 );  hold all; 
plot( [0:n-1].*(fs/n).*1e-6,avg_SNR2 );
plot([0,2.5e6],[10,10]); xlim([0,high_freq./1e6]); xlabel('Frequency (MHz)');


% SNR1_dB=avg_SNR1(samples_array)
% SNR2_dB=avg_SNR2(samples_array)

%% Measure phase

transfer=numerator./denominator;
phase=unwrap(angle(transfer));
freq=[0:n-1].*(fs/n);
w=freq.*2.*pi;

fi=50e3;
fc=450e3;
low_limit=fi/(round(fs/n));
limit=fc/(round(fs/n))+1;%600 kHz

freq=freq(1:limit);% chop frequency array. Obs: freq(1e4)=1 MHz
a=numel(freq);
x=2.*pi.*freq';
y=phase; % in Rad
y=y(1:a);
figure;
plot(x./2./pi,y);
%% Weighted Phase fits
% snr_2=ones(1,a);
% snr_1=ones(1,a);
weightVector=(smooth(snr_2(1:a),100)).^2;

costFunction = @(p) weightVector.*(p(1).*x.^3+p(2).*x.^2+p(3).*x+p(4)-y);
p = lsqnonlin(costFunction,[0,0,0,0])

hold all;
phase_fit=p(1).*x.^3+p(2).*x.^2+p(3).*x+p(4);
phase_delay=-(p(1).*x.^2+p(2).*x+p(3)+p(4)./x);
group_delay=-(3.*p(1).*x.^2+2.*p(2).*x.^1+p(3));
phase_velocity=(z2-z1)./phase_delay;
group_velocity=(z2-z1)./group_delay;
plot(x./2./pi,phase_fit);
%%
R2 = 1- (norm(phase_fit - y)/norm(y - mean(y)))^2
gof=goodnessOfFit(y,phase_fit,'MSE')
%%
rr=numel((phase_fit)-1)/2
R2 = 1- (norm(phase_fit(1:rr) - y(1:rr))/norm(y(1:rr) - mean(y(1:rr))))^2
gof=goodnessOfFit(y(1:rr),phase_fit(1:rr),'MSE')
%%
c=2.99e8;

FigHandle = figure;
set(FigHandle, 'Position', [100, 100, 1364, 530]);
 
subplot(131)
plot((x./2./pi).*1e-3,phase_fit,'Color',[0 114 189]./255); hold all;
subplot(132)
plot((x./2./pi).*1e-3,phase_delay.*1e6,'Color',[0 114 189]./255); hold all;
plot((x./2./pi).*1e-3,group_delay.*1e6,':','Color',[0 114 189]./255)
subplot(133)
plot((x./2./pi).*1e-3,(phase_velocity./c).*100,'Color',[0 114 189]./255); hold all;
plot((x./2./pi).*1e-3,(group_velocity./c).*100,':','Color',[0 114 189]./255); hold all;
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

subplot(131)
phase_error=smooth(error_Phase,100);

% plot((x./2./pi).*1e-3,phase_fit+phase_error,'Color',[118 171 47]./255); 
% plot((x./2./pi).*1e-3,phase_fit-phase_error,'Color',[125 46 141]./255);
%% Carry phase error
freq=[0:n-1].*(fs/n);
w=2.*pi.*freq;
lower_phase_limit=phase_fit-phase_error;
phase_delay_lower_limit=real((phase_delay-phase_error(1:limit)./(w(1:limit)')));
phase_delay_upper_limit=real((phase_delay+phase_error(1:limit)./(w(1:limit)')));
phase_velocity_upper_limit=(z2-z1)./phase_delay_lower_limit;
phase_velocity_lower_limit=(z2-z1)./phase_delay_upper_limit;

upper_phase_limit=phase_fit+phase_error;
group_delay_lower_limit=real(group_delay(1:end-1)-smooth(-(diff(phase_error(1:limit))./(w(2)-w(1))),1000));
group_delay_upper_limit=real(group_delay(1:end-1)+smooth(-(diff(phase_error(1:limit))./(w(2)-w(1))),1000));
group_velocity_upper_limit=(z2-z1)./group_delay_lower_limit;
group_velocity_lower_limit=(z2-z1)./group_delay_upper_limit;


for j=1:numel(phase_delay_lower_limit+1)
    if phase_delay_upper_limit(j)<phase_delay_lower_limit(j)
        phase_delay_upper_limitv2(j)=phase_delay_lower_limit(j);
        phase_delay_lower_limitv2(j)=phase_delay_upper_limit(j);
        
    else
        phase_delay_upper_limitv2(j)=phase_delay_upper_limit(j);
        phase_delay_lower_limitv2(j)=phase_delay_lower_limit(j);
    end
end

for j=1:numel(group_delay_lower_limit+1)
    if group_delay_upper_limit(j)<group_delay_lower_limit(j)
        group_delay_upper_limitv2(j)=group_delay_lower_limit(j);
        group_delay_lower_limitv2(j)=group_delay_upper_limit(j);
        
    else
        group_delay_upper_limitv2(j)=group_delay_upper_limit(j);
        group_delay_lower_limitv2(j)=group_delay_lower_limit(j);
    end
end

for j=1:numel(phase_velocity_lower_limit+1)
    if phase_velocity_upper_limit(j)<phase_velocity_lower_limit(j)
        phase_velocity_upper_limitv2(j)=phase_velocity_lower_limit(j);
        phase_velocity_lower_limitv2(j)=phase_velocity_upper_limit(j);
        
    else
        phase_velocity_upper_limitv2(j)=phase_velocity_upper_limit(j);
        phase_velocity_lower_limitv2(j)=phase_velocity_lower_limit(j);
    end
end

for j=1:numel(group_velocity_lower_limit+1)
    if group_velocity_upper_limit(j)<group_velocity_lower_limit(j)
        group_velocity_upper_limitv2(j)=group_velocity_lower_limit(j);
        group_velocity_lower_limitv2(j)=group_velocity_upper_limit(j);
        
    else
        group_velocity_upper_limitv2(j)=group_velocity_upper_limit(j);
        group_velocity_lower_limitv2(j)=group_velocity_lower_limit(j);
    end
end

phase_delay_lower_limit=phase_delay_lower_limitv2;
phase_delay_upper_limit=phase_delay_upper_limitv2;
group_delay_lower_limit=group_delay_lower_limitv2;
group_delay_upper_limit=group_delay_upper_limitv2;

phase_velocity_lower_limit=phase_velocity_lower_limitv2;
phase_velocity_upper_limit=phase_velocity_upper_limitv2;
group_velocity_lower_limit=group_velocity_lower_limitv2;
group_velocity_upper_limit=group_velocity_upper_limitv2;
 %%
% figure;
% plot((w(1:limit)./2./pi).*1e-3,(phase_velocity_lower_limit./c).*100,'Color',[236 176 31]./255); hold all
% plot((w(1:limit)./2./pi).*1e-3,(phase_velocity_upper_limit./c).*100,'Color',[216 82 24]./255);
% plot((w(1:limit-1)./2./pi).*1e-3,(group_velocity_lower_limit./c).*100,':','Color',[236 176 31]./255); hold all
% plot((w(1:limit-1)./2./pi).*1e-3,(group_velocity_upper_limit./c).*100,':','Color',[216 82 24]./255);
% xlim([50,300])


subplot(131);
plot((w(1:limit)./2./pi).*1e-3,lower_phase_limit,'Color',[236 176 31]./255); hold all;
plot((w(1:limit)./2./pi).*1e-3,upper_phase_limit,'Color',[216 82 24]./255)
xlim([fi,fc/2].*1e-3)
xlabel('Frequency (kHz)');
ylabel('Transfer function phase (radians)');
grid
legend('best fit','lower limit','upper limit')
set(0,'defaultlinelinewidth',2)
set(gca,'fontsize',16)

subplot(132);
plot((w(1:limit)./2./pi).*1e-3,phase_delay_lower_limit.*1e6,'Color',[236 176 31]./255); hold all;
plot((w(1:limit)./2./pi).*1e-3,phase_delay_upper_limit.*1e6,'Color',[216 82 24]./255); 
plot((w(1:limit-10)./2./pi).*1e-3,group_delay_lower_limit(1:end-9).*1e6,':','Color',[236 176 31]./255);
plot((w(1:limit-10)./2./pi).*1e-3,group_delay_upper_limit(1:end-9).*1e6,':','Color',[216 82 24]./255);
xlabel('Frequency (kHz)');
ylabel('Time (\mus)');
grid
legend('\tau_p','\tau_g',...
    '\tau_p lower limit','\tau_p upper limit',...
    '\tau_g lower limit','\tau_g upper limit',...
    'location','southwest')
xlim([fi,fc/2].*1e-3)
set(0,'defaultlinelinewidth',2)
set(gca,'fontsize',16)

subplot(133);
plot((w(1:limit)./2./pi).*1e-3,(phase_velocity_lower_limit./c).*100,'Color',[236 176 31]./255); hold all;
plot((w(1:limit)./2./pi).*1e-3,(phase_velocity_upper_limit./c).*100,'Color',[216 82 24]./255);
plot((w(1:limit-1)./2./pi).*1e-3,(group_velocity_lower_limit./c).*100,':','Color',[236 176 31]./255);
plot((w(1:limit-1)./2./pi).*1e-3,(group_velocity_upper_limit./c).*100,':','Color',[216 82 24]./255);
xlabel('Frequency (kHz)');
ylabel('velocity (% of c)');
grid
legend('v_p','v_g',...
    'v_p lower limit','v_p upper limit',...
    'v_g lower limit','v_g upper limit',...
    'location','northwest')
ylim([0,100])
xlim([fi,fc/2].*1e-3)
set(gca,'fontsize',16)

%%
f=(x./2./pi).*1e-3;
sample_increment=50e3/(round(fs/n)); %50 kHz     
% sample_increment=50e3/(round((fs/n)*1e7)/1e7);
samples_array=[1 2 3 4 5 6].*sample_increment;
figure;
frequency=f(samples_array);
% narrowband_phase_velocity_upper_limit=phase_velocity(samples_array);
narrowband_phase_velocity=phase_velocity(samples_array);

narrowband_phase_velocity_upper_limit=phase_velocity_upper_limit(samples_array)';%-narrowband_phase_velocity;
narrowband_phase_velocity_lower_limit=phase_velocity_lower_limit(samples_array)';%-narrowband_phase_velocity;
% errorbar(frequency,(narrowband_phase_velocity./c).*100,...
%          (narrowband_phase_velocity_lower_limit-narrowband_phase_velocity./c).*100,...
%          (narrowband_phase_velocity_upper_limit-narrowband_phase_velocity./c).*100,'rx')
plot(frequency,(narrowband_phase_velocity./c).*100,...
     frequency,(narrowband_phase_velocity_lower_limit./c).*100,...
     frequency,(narrowband_phase_velocity_upper_limit./c).*100)
 
xlabel('Frequency (kHz)');
ylabel('Phase velocity (% of c)');
%%
figure;     
narrowband_group_velocity=group_velocity(samples_array);
narrowband_group_velocity_upper_limit=group_velocity_upper_limit(samples_array)';%-narrowband_group_velocity;
narrowband_group_velocity_lower_limit=group_velocity_lower_limit(samples_array)';%-narrowband_group_velocity;
% errorbar(frequency,(narrowband_group_velocity./c).*100,...
%          (narrowband_group_velocity_lower_limit./c).*100,...
%          (narrowband_group_velocity_upper_limit./c).*100,'rx')
     
plot(frequency,(narrowband_group_velocity./c).*100,...
     frequency,(narrowband_group_velocity_lower_limit./c).*100,...
     frequency,(narrowband_group_velocity_upper_limit./c).*100)
 
xlabel('Frequency (kHz)');
ylabel('Group velocity (% of c)');
%%
D3_D6=struct('narrowband_phase_velocity',narrowband_phase_velocity,...
    'narrowband_phase_velocity_upper_limit',narrowband_phase_velocity_upper_limit,...
    'narrowband_phase_velocity_lower_limit',narrowband_phase_velocity_lower_limit,...
    'narrowband_group_velocity',narrowband_group_velocity,...
    'narrowband_group_velocity_upper_limit',narrowband_group_velocity_upper_limit,...
    'narrowband_group_velocity_lower_limit',narrowband_group_velocity_lower_limit)
