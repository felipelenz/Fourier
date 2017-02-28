%This code plots the photodiodes colormap from the time domain APD
%measurements. 
%Before you run this code, you should run RS_plot_2016, because we'll need
%to use the Ampl output of the aforementioned code.

%In order to make this work, you'll first need to open a
%photograph containing the channel geometry. In order to do this you can
%simple drag a JPEG to the Workspace ->> 
%or:
A=imread('NEO UF 16-10.JPG');
image(A);
%% Now you'll need to manually trace the channel geometry using the ginput
%function
[x,y]=ginput(100);
%% You'll need to adjust the x and y coordinates so that the bottom of the
%channel is centered at [0,0]

h_per_pixel=0.2180; %for NEO
% h_per_pixel=0.2145; %for SWO
X=x-x(1);
Y=-(y-y(1)).*h_per_pixel;
%% Save struct
UF16_10_1=struct('x',X.','y',Y.');
%%
z=zeros(size(UF16_10_1.x));

close all

% for i=120:250 %M-Comps time scale
for i=-30:20 %RS time scale
    iteration=0;
    time_step=20*i; %RS time scale
%     time_step=300*i; %M-Comps time scale
    t=time_step*10e-9*1e6;
    t0=5e5+time_step;
    time=D1.time(t0);
    col=Ampl(1:11,t0);
    col=col'; 
    col=resample(col,numel(UF16_10_1.x),numel(col));

    fh=figure(1); subplot(221);
    text(0,0.5,'UF 16-10, RS 1','fontsize',30); axis off
    
    figure(1); drawnow; subplot(223);
    plot(D1.time.*1e6,Ampl(1,:),'b','linewidth',2); hold on;
    plot(D1.time.*1e6,Ampl(5,:),'color',[.8 .2 .8],'linewidth',2); 
    plot(D1.time.*1e6,Ampl(10,:),'color',[.1 .5 .2],'linewidth',2); 
    legend('D1 (0m)','D7 (200 m)','D15 (450 m)');
    plot([time, time].*1e6,[-.1,max(Ampl(1,:))+0.1],'r','linewidth',2); hold off;
    xlabel('Time (\mus)');
    ylabel('Calibrated luminosity (dig. V)');
    xlim([-10,50]);
    ylim([-.1,max(Ampl(1,:))+0.1]);
    set(gca,'Fontsize',20);
    
    drawnow; figure(1); subplot(122); 
    %this section plots the 2D colormap:
    surface([UF16_10_1.x;UF16_10_1.x],...
        [UF16_10_1.y;UF16_10_1.y],[z;z],...
         [col;col],'facecol','no','edgecol','interp','linew',10);
    caxis([0 0.1]);%0.5*max(max_lum_2015)]);  
%     caxis([min(col) 1.2*max(col)]);  
    colorbar
    grid on;
    xlabel('NW <-> SE')
    ylabel('Height (m)')
    ylim([0,505])
    title(['Elapsed Time = ', num2str(t),' \mus']);
    set(gca,'Fontsize',20)
end