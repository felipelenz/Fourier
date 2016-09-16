A=imread('DSC_0417.JPG');
image(A)
%%
z=zeros(size(UF16_23_4.x));

close all

for i=-80:50
    iteration=0;
    time_step=15*i;
    t=time_step*10e-9*1e6;
    t0=5e5+time_step;
    time=D1.time(t0);
    col=Ampl(:,t0);
    col=col'; 
    col=resample(col,numel(UF16_23_4.x),numel(col));

    fh=figure(1); subplot(221);
    text(0.2,0.5,'UF 16-23, RS 1','fontsize',30); axis off
    
    figure(1); drawnow; subplot(223);
    plot(D1.time.*1e6,Ampl(1,:),'b','linewidth',2); hold on;
    plot(D1.time.*1e6,Ampl(5,:),'color',[.8 .2 .8],'linewidth',2); 
    plot(D1.time.*1e6,Ampl(10,:),'color',[.1 .5 .2],'linewidth',2); 
    legend('D1 (0m)','D7 (200 m)','D15 (450 m)');
    plot([time, time].*1e6,[-.1,max(Ampl(1,:))+0.1],'r','linewidth',2); hold off;
    xlabel('Time (\mus)');
    ylabel('Calibrated luminosity (dig. V)');
    xlim([-10,10]);
    ylim([-.1,max(Ampl(1,:))+0.1]);
    set(gca,'Fontsize',20);
    
    drawnow; figure(1); subplot(122); %pause(0.1);
    surface([UF16_23_4.x;UF16_23_4.x],...
        [UF16_23_4.y;UF16_23_4.y],[z;z],...
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
    set(fh,'position',[10 100 1200 1000]);
    
%     % gif utilities
% %     set(gcf,'color','w'); % set figure background to white
%     drawnow;
%     frame = getframe(1);
%     im = frame2im(frame);
%     [imind,cm] = rgb2ind(im,256);
%     outfile = 'sinewave.gif';
%  
%     % On the first loop, create the file. In subsequent loops, append.
%     if iteration==0
%         imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
%     else
%         imwrite(imind,cm,outfile,'gif','DelayTime',0,'writemode','append');
%     end
%     iteration=iteration+1;
    
end