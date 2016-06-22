%% Load Data
date=081314;
suffix48=4;
suffix49=4;
suffix50=4;
event=51;
seg=7;
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

%% Read data
[w,Phase_fit_1_2,time_delay_1_2]=time_delay_v7_with_LPF(C1_48.data(1:2500001,seg),C2_48.data(1:2500001,seg));
[w,Phase_fit_1_3,time_delay_1_3]=time_delay_v7_with_LPF(C1_48.data(1:2500001,seg),C3_48.data(1:2500001,seg));
[w,Phase_fit_1_4,time_delay_1_4]=time_delay_v7_with_LPF(C1_48.data(1:2500001,seg),C4_48.data(1:2500001,seg));

[w,Phase_fit_1_5,time_delay_1_5]=time_delay_v7_with_LPF(C1_48.data(1:2500001,seg),C1_49.data(1:2500001,seg));
[w,Phase_fit_1_6,time_delay_1_6]=time_delay_v7_with_LPF(C1_48.data(1:2500001,seg),C2_49.data(1:2500001,seg));
[w,Phase_fit_1_7,time_delay_1_7]=time_delay_v7_with_LPF(C1_48.data(1:2500001,seg),C3_49.data(1:2500001,seg));

[w,Phase_fit_1_8,time_delay_1_8]=time_delay_v7_with_LPF(C1_48.data(1:2500001,seg),C1_50.data(1:2500001,seg));
[w,Phase_fit_1_9,time_delay_1_9]=time_delay_v7_with_LPF(C1_48.data(1:2500001,seg),C2_50.data(1:2500001,seg));
[w,Phase_fit_1_10,time_delay_1_10]=time_delay_v7_with_LPF(C1_48.data(1:2500001,seg),C3_50.data(1:2500001,seg));
[w,Phase_fit_1_11,time_delay_1_11]=time_delay_v7_with_LPF(C1_48.data(1:2500001,seg),C4_50.data(1:2500001,seg));
%% Plot Phase
figure(1);
plot((w./2./pi).*1e-3,Phase_fit_1_2,'linewidth',2); hold all;
plot((w./2./pi).*1e-3,Phase_fit_1_3,'linewidth',2);
plot((w./2./pi).*1e-3,Phase_fit_1_4,'linewidth',2);
plot((w./2./pi).*1e-3,Phase_fit_1_5,'linewidth',2);
plot((w./2./pi).*1e-3,Phase_fit_1_6,'linewidth',2);
plot((w./2./pi).*1e-3,Phase_fit_1_7,'linewidth',2);
plot((w./2./pi).*1e-3,Phase_fit_1_8,'linewidth',2);
plot((w./2./pi).*1e-3,Phase_fit_1_9,'linewidth',2);
plot((w./2./pi).*1e-3,Phase_fit_1_10,'linewidth',2);
plot((w./2./pi).*1e-3,Phase_fit_1_11,'linewidth',2);
legend('D1-D2','D1-D3','D1-D4','D1-D5','D1-D6','D1-D7','D1-D8','D1-D9','D1-D10','D1-D11','location','southwest');

xlabel('Frequency (kHz)');
ylabel('Transfer function phase (rad)');
set(gca,'fontsize',20);
grid
%% Plot Time Delay
figure(2);
plot((w(1:end-1)./2./pi).*1e-3,time_delay_1_2,'linewidth',2); hold all;
plot((w(1:end-1)./2./pi).*1e-3,time_delay_1_3,'linewidth',2);
plot((w(1:end-1)./2./pi).*1e-3,time_delay_1_4,'linewidth',2);
plot((w(1:end-1)./2./pi).*1e-3,time_delay_1_5,'linewidth',2);
plot((w(1:end-1)./2./pi).*1e-3,time_delay_1_6,'linewidth',2);
plot((w(1:end-1)./2./pi).*1e-3,time_delay_1_7,'linewidth',2);
plot((w(1:end-1)./2./pi).*1e-3,time_delay_1_8,'linewidth',2);
plot((w(1:end-1)./2./pi).*1e-3,time_delay_1_9,'linewidth',2);
plot((w(1:end-1)./2./pi).*1e-3,time_delay_1_10,'linewidth',2);
plot((w(1:end-1)./2./pi).*1e-3,time_delay_1_11,'linewidth',2);

legend('D1-D2','D1-D3','D1-D4','D1-D5','D1-D6','D1-D7','D1-D8','D1-D9','D1-D10','D1-D11');
xlabel('Frequency (kHz)');
ylabel('Time delay (s)');
set(gca,'fontsize',20);
grid
%% Plot Speed

speed_1_2=((10-4)./(time_delay_1_2.*1e10)).*1e1;
speed_1_3=((16-4)./(time_delay_1_3.*1e10)).*1e10;
speed_1_4=((22-4)./(time_delay_1_4.*1e10)).*1e10;
speed_1_5=((28-4)./(time_delay_1_5.*1e10)).*1e10;
speed_1_6=((42.5-4)./(time_delay_1_6.*1e10)).*1e10;
speed_1_7=((57-4)./(time_delay_1_7.*1e10)).*1e10;
speed_1_8=((71.5-4)./(time_delay_1_8.*1e10)).*1e10;
speed_1_9=((86-4)./(time_delay_1_9.*1e10)).*1e10;
speed_1_10=((100.5-4)./(time_delay_1_10.*1e10)).*1e10;
speed_1_11=((115-4)./(time_delay_1_11.*1e10)).*1e10;

figure(3);
plot((w(1:end-1)./2./pi).*1e-3,speed_1_2,'linewidth',2); hold all;
plot((w(1:end-1)./2./pi).*1e-3,speed_1_3,'linewidth',2);
plot((w(1:end-1)./2./pi).*1e-3,speed_1_4,'linewidth',2);
plot((w(1:end-1)./2./pi).*1e-3,speed_1_5,'linewidth',2);
plot((w(1:end-1)./2./pi).*1e-3,speed_1_6,'linewidth',2);
plot((w(1:end-1)./2./pi).*1e-3,speed_1_7,'linewidth',2);
plot((w(1:end-1)./2./pi).*1e-3,speed_1_8,'linewidth',2);
plot((w(1:end-1)./2./pi).*1e-3,speed_1_9,'linewidth',2);
plot((w(1:end-1)./2./pi).*1e-3,speed_1_10,'linewidth',2);
plot((w(1:end-1)./2./pi).*1e-3,speed_1_11,'linewidth',2);

xlabel('Frequency (kHz)');
ylabel('Upward luminosity speed (m/s)');
legend('D1-D2','D1-D3','D1-D4','D1-D5','D1-D6','D1-D7','D1-D8','D1-D9','D1-D10','D1-D11','location','northwest')
set(gca,'fontsize',20);
grid