suffix=2;
% iihi_suffix=0;
% cal=20613.86;
seg=1;
date=080116;

pathname = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date)];
cd(pathname)

C1_filename43 = ['C1AC0000',int2str(suffix),'.trc'];
C2_filename43 = ['C2AC0000',int2str(suffix),'.trc'];
C3_filename43 = ['C3AC0000',int2str(suffix),'.trc'];
C4_filename43 = ['C4AC0000',int2str(suffix),'.trc'];

C1_filename44 = ['C1AC0000',int2str(suffix),'.trc'];
C2_filename44 = ['C2AC0000',int2str(suffix),'.trc'];
C3_filename44 = ['C3AC0000',int2str(suffix),'.trc'];
C4_filename44 = ['C4AC0000',int2str(suffix),'.trc'];

C1_filename48 = ['C1AC0000',int2str(suffix),'.trc'];
C2_filename48 = ['C2AC0000',int2str(suffix),'.trc'];
C3_filename48 = ['C3AC0000',int2str(suffix),'.trc'];
C4_filename48 = ['C4AC0000',int2str(suffix),'.trc'];

C1_filename50 = ['C1AC0000',int2str(suffix),'.trc'];
C2_filename50 = ['C2AC0000',int2str(suffix),'.trc'];
C3_filename50 = ['C3AC0000',int2str(suffix),'.trc'];
C4_filename50 = ['C4AC0000',int2str(suffix),'.trc'];

C1_filename39 = ['C1AC0000',int2str(suffix),'.trc'];
C2_filename39 = ['C2AC0000',int2str(suffix),'.trc'];
C3_filename39 = ['C3AC0000',int2str(suffix),'.trc'];
C4_filename39 = ['C4AC0000',int2str(suffix),'.trc'];

C1_filename42 = ['C1AC0000',int2str(suffix),'.trc'];
C2_filename42 = ['C2AC0000',int2str(suffix),'.trc'];
C3_filename42 = ['C3AC0000',int2str(suffix),'.trc'];
C4_filename42 = ['C4AC0000',int2str(suffix),'.trc'];

C1_filename37 = ['C1AC0000',int2str(suffix),'.trc'];
C2_filename37 = ['C2AC0000',int2str(suffix),'.trc'];
C3_filename37 = ['C3AC0000',int2str(suffix),'.trc'];
C4_filename37 = ['C4AC0000',int2str(suffix),'.trc'];

C1_filename29 = ['C1AC0000',int2str(suffix),'.trc'];
C2_filename29 = ['C2AC0000',int2str(suffix),'.trc'];
C3_filename29 = ['C3AC0000',int2str(suffix),'.trc'];
C4_filename29 = ['C4AC0000',int2str(suffix),'.trc'];

% IIHI_file=['C1AC0000',int2str(iihi_suffix),'.trc'];
% 
% pathname26 = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date),'/Scope26/'];
% IIHI = read_lecroy([pathname26 IIHI_file]);
% cd(pathname)

% Change to the Scope43 directory
pathname43 = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date),'/Scope43/'];

D1 = read_lecroy([pathname43 C1_filename43]);
D2 = read_lecroy([pathname43 C2_filename43]);
D3 = read_lecroy([pathname43 C3_filename43]);
D4 = read_lecroy([pathname43 C4_filename43]);

cd(pathname)

% Change to the Scope48 directory
pathname44 = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date),'/Scope44/'];

D5 = read_lecroy([pathname44 C1_filename44]);
D6 = read_lecroy([pathname44 C2_filename44]);
D7 = read_lecroy([pathname44 C3_filename44]);
D8 = read_lecroy([pathname44 C4_filename44]);

cd(pathname)

% Change to the Scope48 directory
pathname48 = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date),'/Scope48/'];

D9 = read_lecroy([pathname48 C1_filename48]);
D10 = read_lecroy([pathname48 C2_filename48]);
D11 = read_lecroy([pathname48 C3_filename48]);
D12 = read_lecroy([pathname48 C4_filename48]);

cd(pathname)

% Change to the Scope50 directory
pathname50 = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date),'/Scope50/'];

D13 = read_lecroy([pathname50 C1_filename50]);
D14 = read_lecroy([pathname50 C2_filename50]);
D15 = read_lecroy([pathname50 C3_filename50]);
D16 = read_lecroy([pathname50 C4_filename50]);

cd(pathname)

% Change to the Scope49 directory
pathname39 = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date),'/Scope39/'];

D17 = read_lecroy([pathname39 C1_filename39]);
D18 = read_lecroy([pathname39 C2_filename39]);
D19 = read_lecroy([pathname39 C3_filename39]);
D20 = read_lecroy([pathname39 C4_filename39]);

cd(pathname)

% Change to the Scope42 directory
pathname42 = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date),'/Scope42/'];

D21 = read_lecroy([pathname42 C1_filename42]);
D22 = read_lecroy([pathname42 C2_filename42]);
D23 = read_lecroy([pathname42 C3_filename42]);
D24 = read_lecroy([pathname42 C4_filename42]);

cd(pathname)

% Change to the Scope37 directory
pathname37 = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date),'/Scope37/'];

D25 = read_lecroy([pathname37 C1_filename37]);
D26 = read_lecroy([pathname37 C2_filename37]);
D27 = read_lecroy([pathname37 C3_filename37]);
D28 = read_lecroy([pathname37 C4_filename37]);

cd(pathname)

% Change to the Scope29 directory
pathname29 = ['/Volumes/Promise 12TB RAID5/2016 Data/0',int2str(date),'/Scope29/'];

D29 = read_lecroy([pathname29 C1_filename29]);
D30 = read_lecroy([pathname29 C2_filename29]);
D31 = read_lecroy([pathname29 C3_filename29]);
C4_29 = read_lecroy([pathname29 C4_filename29]);

cd(pathname)

D1.data = offset(D1.data, 1000);
D2.data = offset(D2.data, 1000);
D3.data = offset(D3.data, 1000);
D4.data = offset(D4.data, 1000);

D5.data = offset(D5.data, 1000);
D6.data = offset(D6.data, 1000);
D7.data = offset(D7.data, 1000);
D8.data = offset(D8.data, 1000);

D9.data = offset(D9.data, 1000);
D10.data = offset(D10.data, 1000);
D11.data = offset(D11.data, 1000);
D12.data = offset(D12.data, 1000);

D13.data = offset(D13.data, 1000);
D14.data = offset(D14.data, 1000);
D15.data = offset(D15.data, 1000);
D16.data = offset(D16.data, 1000);

D17.data = offset(D17.data, 1000);
D18.data = offset(D18.data, 1000);
D19.data = offset(D19.data, 1000);
D20.data = offset(D20.data, 1000);

D21.data = offset(D21.data, 1000);
D22.data = offset(D22.data, 1000);
D23.data = offset(D23.data, 1000);
D24.data = offset(D24.data, 1000);

D25.data = offset(D25.data, 1000);
D26.data = offset(D26.data, 1000);
D27.data = offset(D27.data, 1000);
D28.data = offset(D28.data, 1000);

D29.data = offset(D29.data, 1000);
D30.data = offset(D30.data, 1000);
D31.data = offset(D31.data, 1000);
C4_29.data = offset(C4_29.data, 1000);

IIHI.data = offset(IIHI.data, 1000).*cal;
%% 2014 APDs
%0 m
offset=0;
plot(D2.time.*1e6,D2.data(:,seg).*1); hold all;
offset=max(D2.data(:,seg).*1);
max_lum=[max(D2.data(:,seg).*1)];
peak=[offset];

%100 m
% offset=0;
plot(D5.time.*1e6,D5.data(:,seg).*.82+offset)
offset=max(D5.data(:,seg).*.82)+offset;
max_lum=[max_lum max(D5.data(:,seg).*.82)];
peak=[peak offset];

%200 m
% offset=0;
plot(D8.time.*1e6,D8.data(:,seg).*.57+offset)
offset=max(D8.data(:,seg).*.57)+offset;
max_lum=[max_lum max(D8.data(:,seg).*.57)];
peak=[peak offset];

%300 m
% offset=0;
plot(D11.time.*1e6,D11.data(:,seg).*0.81+offset)
offset=max(D11.data(:,seg).*0.81)+offset;
max_lum=[max_lum max(D11.data(:,seg).*0.81)];
peak=[peak offset];

%400 m
% offset=0;
plot(D14.time.*1e6,D14.data(:,seg).*1.62+offset)
offset=max(D14.data(:,seg).*1.62)+offset;
max_lum=[max_lum max(D14.data(:,seg).*1.62)];
peak=[peak offset];
 
%500 m
% offset=0;
plot(D17.time.*1e6,D17.data(:,seg).*1.34/10+offset)
offset=max(D17.data(:,seg).*1.34/10)+offset;
max_lum=[max_lum max(D17.data(:,seg).*1.34/10)];
peak=[peak offset];

%600 m
% offset=0;
plot(D20.time.*1e6,D20.data(:,seg).*0.76/10+offset)
offset=max(D20.data(:,seg).*0.76/10)+offset;
max_lum=[max_lum max(D20.data(:,seg).*0.76/10)];
peak=[peak offset];

%700 m
% offset=0;
plot(D23.time.*1e6,D23.data(:,seg).*1.54/10+offset)
offset=max(D23.data(:,seg).*1.54/10)+offset;
max_lum=[max_lum max(D23.data(:,seg).*1.54/10)];
peak=[peak offset];

%800 m
% offset=0;
plot(D26.time.*1e6,D26.data(:,seg).*1.44/10+offset)
offset=max(D26.data(:,seg).*1.44/10)+offset;
max_lum=[max_lum max(D26.data(:,seg).*1.44/10)];
peak=[peak offset];

%900 m
% offset=0;
plot(D29.time.*1e6,D29.data(:,seg).*1.8/10+offset)
offset=max(D29.data(:,seg).*1.8/10)+offset;
max_lum=[max_lum max(D29.data(:,seg).*1.8/10)];
peak=[peak offset];

%1 km
% offset=0;
plot(D31.time.*1e6,D31.data(:,seg).*1.78/10+offset)
offset=max(D31.data(:,seg).*1.78/10)+offset;
max_lum=[max_lum max(D31.data(:,seg).*1.78/10)];
peak=[peak offset];

legend('0 m','100 m','200 m','300 m','400 m','500 m','600 m','700 m','800 m','900 m','1000 m')
%%
Ampl_2014diodes=[D2.data(:,seg)'.*1; %0m
      D5.data(:,seg)'.*.82; %100 m
      D8.data(:,seg)'.*.57; %200 m
      D11.data(:,seg)'.*0.81; % 300 m
      D14.data(:,seg)'.*1.62; %400 m
      D17.data(:,seg)'.*1.34/10; % 500 m
      D20.data(:,seg)'.*0.76/10; %600 m
      D23.data(:,seg)'.*1.54/10; %700 m
      D26.data(:,seg)'.*1.44/10; %800 m
      D29.data(:,seg)'.*1.8/10; % 900m
      D31.data(:,seg)'.*1.78/10]; %1km
%%
h_2014=[0,100,200,300,400,500,600,700,800,900,1000];
max_lum_2014=max_lum;
figure;
plot(h_2014,max_lum_2014,'*-')

%% 2015 APDs
offset=0;
plot(D1.time.*1e6,D1.data(:,seg).*1.2); hold all
offset=max(D1.data(:,seg).*1.2);
max_lum=[max(D1.data(:,seg).*1.2)];
peak=[offset];

plot(D3.time.*1e6,D3.data(:,seg).*1.3+offset)
offset=max(D3.data(:,seg).*1.3)+offset;
max_lum=[max_lum max(D3.data(:,seg).*1.3)];
peak=[peak offset];

plot(D4.time.*1e6,D4.data(:,seg).*1.2+offset)
offset=max(D4.data(:,seg).*1.2)+offset;
max_lum=[max_lum max(D4.data(:,seg).*1.2)];
peak=[peak offset];

plot(D6.time.*1e6,D6.data(:,seg).*1.18+offset)
offset=max(D6.data(:,seg).*1.18)+offset;
max_lum=[max_lum max(D6.data(:,seg).*1.18)];
peak=[peak offset];

plot(D7.time.*1e6,D7.data(:,seg).*1.4+offset)
offset=max(D7.data(:,seg).*1.4)+offset;
max_lum=[max_lum max(D7.data(:,seg).*1.4)];
peak=[peak offset];

plot(D9.time.*1e6,D9.data(:,seg).*1.37+offset)
offset=max(D9.data(:,seg).*1.37)+offset;
max_lum=[max_lum max(D9.data(:,seg).*1.37)];
peak=[peak offset];

plot(D10.time.*1e6,D10.data(:,seg).*1.48+offset)
offset=max(D10.data(:,seg).*1.48)+offset;
max_lum=[max_lum max(D10.data(:,seg).*1.48)];
peak=[peak offset];

plot(D12.time.*1e6,D12.data(:,seg).*1.49+offset);
offset=max(D12.data(:,seg).*1.49)+offset;
max_lum=[max_lum max(D12.data(:,seg).*1.49)];
peak=[peak offset];

plot(D13.time.*1e6,D13.data(:,seg).*1.24+offset)
offset=max(D13.data(:,seg).*1.24)+offset;
max_lum=[max_lum max(D13.data(:,seg).*1.24)];
peak=[peak offset];

plot(D15.time.*1e6,D15.data(:,seg).*0.78+offset)
offset=max(D15.data(:,seg).*0.78)+offset;
max_lum=[max_lum max(D15.data(:,seg).*0.78)];
peak=[peak offset];

plot(D16.time.*1e6,D16.data(:,seg).*1.64/10+offset)
offset=max(D16.data(:,seg).*1.64/10)+offset;
max_lum=[max_lum max(D16.data(:,seg).*1.64/10)];
peak=[peak offset];

plot(D18.time.*1e6,D18.data(:,seg).*.78/10+offset)
offset=max(D18.data(:,seg).*.78/10)+offset;
max_lum=[max_lum max(D18.data(:,seg).*.78/10)];
peak=[peak offset];

plot(D19.time.*1e6,D19.data(:,seg).*1.97/10+offset)
offset=max(D19.data(:,seg).*1.97/10)+offset;
max_lum=[max_lum max(D19.data(:,seg).*1.97/10)];
peak=[peak offset];

plot(D21.time.*1e6,D21.data(:,seg).*1.64/10+offset)
offset=max(D21.data(:,seg).*1.64/10)+offset;
max_lum=[max_lum max(D21.data(:,seg).*1.64/10)];
peak=[peak offset];

plot(D22.time.*1e6,D22.data(:,seg).*.82/10+offset)
offset=max(D22.data(:,seg).*.82/10)+offset;
max_lum=[max_lum max(D22.data(:,seg).*.82/10)];
peak=[peak offset];

plot(D24.time.*1e6,D24.data(:,seg).*0.82/10+offset)
offset=max(D24.data(:,seg).*0.82/10)+offset;
max_lum=[max_lum max(D24.data(:,seg).*0.82/10)];
peak=[peak offset];

plot(D25.time.*1e6,D25.data(:,seg).*0.95/10+offset)
offset=max(D25.data(:,seg).*0.95/10)+offset;
max_lum=[max_lum max(D25.data(:,seg).*0.95/10)];
peak=[peak offset];

plot(D27.time.*1e6,D27.data(:,seg).*0.89/10+offset)
offset=max(D27.data(:,seg).*0.89/10)+offset;
max_lum=[max_lum max(D27.data(:,seg).*0.89/10)];
peak=[peak offset];

plot(D28.time.*1e6,D28.data(:,seg).*0.98/10+offset)
offset=max(D28.data(:,seg).*0.98/10)+offset;
max_lum=[max_lum max(D28.data(:,seg).*0.98/10)];
peak=[peak offset];

plot(D30.time.*1e6,D30.data(:,seg).*0.91/10+offset)
offset=max(D30.data(:,seg).*0.91/10)+offset;
max_lum=[max_lum max(D30.data(:,seg).*0.91/10)];
peak=[peak offset];
%%
Ampl=[D1.data(:,seg)'.*1.2; %0m
      D3.data(:,seg)'.*1.3; %50 m
      D4.data(:,seg)'.*1.2; %100 m
      D6.data(:,seg)'.*1.18; %150 m
      D7.data(:,seg)'.*1.4; %200 m
      D9.data(:,seg)'.*1.37; % 250 m
      D10.data(:,seg)'.*1.48; % 300 m
      D12.data(:,seg)'.*1.49; %350 m
      D13.data(:,seg)'.*1.24; %400 m
      D15.data(:,seg)'.*0.78; %450 m
      D16.data(:,seg)'.*1.64/10; % 500 m
      D18.data(:,seg)'.*.78/10; %550 m
      D19.data(:,seg)'.*1.97/10; %600 m
      D21.data(:,seg)'.*1.64/10; %650 m
      D22.data(:,seg)'.*.82/10; %700 m
      D24.data(:,seg)'.*0.82/10; %750 m
      D25.data(:,seg)'.*0.95/10; %800 m
      D27.data(:,seg)'.*0.89/10; %850 m
      D28.data(:,seg)'.*0.98/10; % 900m
      D30.data(:,seg)'.*0.91/10]; %1km
%%
h_2015=[0,50,100,150,200,250,300,350,400,450,500,550,600,...
    650,700,750,800,850,900,1000];

max_lum_2015=max_lum;
figure;
plot(h_2015,max_lum_2015,'*-')
%% Measure speed
close all;
a=20;
time=D1.time;
sample=(time-time(1))./1e-8;
data=Ampl(a,:).';
plot(data./max(data));
%%
[x,y]=ginput(3);
x=round(x);
x=x.'
%%
noise=data(x(1):x(2));
hold all; 
plot(sample(x(1):x(2)),data(x(1):x(2))./max(data))

mu=mean(noise)
sigma=std(noise)
%%
figure;
plot(data); hold on;
plot([sample(1),sample(end)],[mu,mu],'-r');
plot([sample(1),sample(end)].*a,[mu+sigma,mu+sigma],'--r');
plot([sample(1),sample(end)].*a,[mu-sigma,mu-sigma],'--r');

% Find Max
[MaxAmpl, MaxRawInd]=max(data(x(2):x(3))); %find light peak
MaxRawInd=MaxRawInd+x(2)-1;
data_topeak=data(x(2):MaxRawInd);

% Find Min
[~, Min_index]=max(abs(1./((mu+3*sigma)-data_topeak))); hold on;
Min_index=x(2)+Min_index-1;
MinAmpl=data(Min_index);

Ampl=(MaxAmpl-MinAmpl);
disp('Luminosity Amplitude (digitizer volts):');
disp(Ampl)

%Find the closest point to 5% Amplitude
[~, five_percent_index]=max(abs(1./((0.05*Ampl+MinAmpl)-data_topeak)));
five_percent_index=x(2)+five_percent_index-1;

five_percent=[five_percent_index]
plot(five_percent_index,data(five_percent_index),'k*')

xlim([x(1),x(3)])
%% Plot Pairs aimed at same height
figure;
time=D2.time.*1e6;
a=-20;
b=100;

% subplot(3,4,1)
% plotyy(time,Ampl(1,:),IIHI.time.*1e6,IIHI.data(:,seg).*cal);

for i=1:10
    subplot(3,4,i+1);
    plot(time,Ampl(2*i-1,:)./max(Ampl(2*i-1,:))); hold all;
    plot(time,Ampl_2014diodes(i,:)./max(Ampl_2014diodes(i,:)))
    xlim([a,b])
    ylim([-0.1,1.1])
    grid on;
    title([num2str((i-1)*100),' m']);
end
subplot(3,4,12);
plot(time,Ampl(20,:)./max(Ampl(20,:))); hold all;
plot(time,Ampl_2014diodes(11,:)./max(Ampl_2014diodes(11,:)))
xlim([a,b])
ylim([-0.1,1.1])
grid on;
title(['1,000 m']);

suptitle('August 1, 2016 - UF 16-07, RS#5')

%%
% temp=Ampl(1,:)./max(Ampl(1,:)); %2015 diode
% temp2=Ampl_2014diodes(1,:)./max(Ampl_2014diodes(1,:)); %2014 diode

temp=(D1.data(:,seg).*1.2)./max(D1.data(:,seg).*1.2);%2015 diode
temp2=(D2.data(:,seg).*1)./max(D2.data(:,seg).*1);%2014 diode

figure;
plot(temp)
hold all
plot(temp2)
plot(temp-temp2)
max(temp-temp2)
max(IIHI.data(:,seg).*cal)
