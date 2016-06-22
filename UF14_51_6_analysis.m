limit=4000;
freq=[0:n-1].*(fs/n);
freq=freq(1:limit)';
w=2.*pi.*freq;

p1_1_2=1.25e-20 ;
p2_1_2=-4.81e-14;
p3_1_2=-5.52e-08 ;
p4_1_2=-0.0849;
Phase_fit_1_2=p1_1_2.*w.^3+p2_1_2.*w.^2+p3_1_2.*w+p4_1_2;

p1_2_3=-4.819e-20;
p2_2_3=2.707e-13;
p3_2_3=-6.663e-07 ;
p4_2_3=-0.0541 ;
Phase_fit_2_3=p1_2_3.*w.^3+p2_2_3.*w.^2+p3_2_3.*w+p4_2_3;

p1_3_6=1.547E-20;%5.932e-20;
p2_3_6=2.973E-14;%-1.042e-13;
p3_3_6=-4.531E-07;%-3.451e-07;
p4_3_6=-9.144E-02;%-0.1091;
Phase_fit_3_6=p1_3_6.*w.^3+p2_3_6.*w.^2+p3_3_6.*w+p4_3_6;

p1_6_9=-7.962e-20 ;
p2_6_9=  4.356e-13;
p3_6_9= -9.334e-07;
p4_6_9=-0.07884;
Phase_fit_6_9=p1_6_9.*w.^3+p2_6_9.*w.^2+p3_6_9.*w+p4_6_9;

p1_9_11=-2.422e-19;
p2_9_11=7.669e-13;
p3_9_11= -9.416e-07 ;
p4_9_11=0.06959;
Phase_fit_9_11=p1_9_11.*w.^3+p2_9_11.*w.^2+p3_9_11.*w+p4_9_11;

for i=2:limit-1,
    time_delay_1_2(i)=-(Phase_fit_1_2(i+1)-Phase_fit_1_2(i-1))/(2*500e6/5000002);
    time_delay_2_3(i)=-(Phase_fit_2_3(i+1)-Phase_fit_2_3(i-1))/(2*500e6/5000002);
    time_delay_3_6(i)=-(Phase_fit_3_6(i+1)-Phase_fit_3_6(i-1))/(2*500e6/5000002);
    time_delay_6_9(i)=-(Phase_fit_6_9(i+1)-Phase_fit_6_9(i-1))/(2*500e6/5000002);
    time_delay_9_11(i)=-(Phase_fit_9_11(i+1)-Phase_fit_9_11(i-1))/(2*500e6/5000002);
end

speed_1_2=((10-4)./(time_delay_1_2.*1e10)).*1e10;
speed_2_3=((16-10)./(time_delay_2_3.*1e10)).*1e10;
speed_3_6=((42.5-16)./(time_delay_3_6.*1e10)).*1e10;
speed_6_9=((86-42.5)./(time_delay_6_9.*1e10)).*1e10;
speed_9_11=((115-86)./(time_delay_9_11.*1e10)).*1e10;
figure('rend','painters','pos',[10 10 700 700*2.588])
subplot(311);
plot(freq./1000,Phase_fit_1_2,...
    freq./1000,Phase_fit_2_3,...
    freq./1000,Phase_fit_3_6,...
    freq./1000,Phase_fit_6_9,...
    freq./1000,Phase_fit_9_11);
title('UF14-51, RS#6');
xlabel('Frequency (kHz)');
ylabel('Phase fit (rad)');
legend('D1(4m)-D2(10m)','D2(10m)-D3(16m)','D3(16m)-D6(42.5m)',...
    'D6(43.5m)-D9(86m)','D9(86m)-D11(115m)','location','southwest');
set(gca,'fontsize',16)
grid

subplot(312);
plot(freq(1:end-1)./1000,time_delay_1_2.*1e6,...
    freq(1:end-1)./1000,time_delay_2_3.*1e6,...
    freq(1:end-1)./1000,time_delay_3_6.*1e6,...
    freq(1:end-1)./1000,time_delay_6_9.*1e6,...
    freq(1:end-1)./1000,time_delay_9_11.*1e6);
xlabel('Frequency (kHz)');
ylabel('Time delay (\mus)');
legend('D1(4m)-D2(10m)','D2(10m)-D3(16m)','D3(16m)-D6(42.5m)',...
    'D6(43.5m)-D9(86m)','D9(86m)-D11(115m)','location','northwest');
grid
set(gca,'fontsize',16)

subplot(313);
plot(freq(1:end-1)./1000,speed_1_2,...
    freq(1:end-1)./1000,speed_2_3,...
    freq(1:end-1)./1000,speed_3_6,...
    freq(1:end-1)./1000,speed_6_9,...
    freq(1:end-1)./1000,speed_9_11);
xlabel('Frequency (kHz)');
ylabel('Upward luminosity speed (m/s)');
legend('D1(4m)-D2(10m)','D2(10m)-D3(16m)','D3(16m)-D6(42.5m)',...
    'D6(43.5m)-D9(86m)','D9(86m)-D11(115m)','location','northwest');
grid
set(0,'defaultlinelinewidth',2)
set(gca,'fontsize',16)
xlim([0,300])