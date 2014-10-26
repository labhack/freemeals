%figure
subplot(2,2,1)
 h = animatedline;
 h.MarkerSize = 50;
 h.Marker='o';
 grid on
 axis([min(HEOGmV),max(HEOGmV),min(VEOGmV),max(VEOGmV)])
subplot(2,2,2)
g = animatedline;
%h.Marker = 'x';
g.MarkerSize = 10;

axis([0,150,min(ECGmV),max(ECGmV)])

m = decimate(ECGmV,2);
%t = decimate(TimeSec,1);
tt = 1:length(m);
ttt = decimate(TimeSec,2);


x = decimate(HEOGmV,2);
y = decimate(VEOGmV,2);
t = decimate(TimeSec,2);
[theta, radius] =cart2pol(x,y);
a=tic;
grid on
newmax=1;

for k = 3:length(x)
    if(mod(k,3)==0)
        clearpoints(h);
    end
    
     if(mod(k,150)==0)
         clearpoints(g)
         oldmax=newmax;
         oldheartrate=heartrate;
         [~,newmax]=(max(m(k:k+150)));
         
         newmax=t(k+newmax);
         heartrate=1/(newmax-oldmax);
         if(heartrate>3)
             heartrate=oldheartrate;
         end
     end
     
    addpoints(g,mod(tt(k),150),m(k));
    title(['Heart rate is ',num2str(heartrate),' beats/sec, time is ',num2str(t(k)),' secs                                   '])
    if(var(x(k:k+3))>.2e-3)
        h.Color='red';
        h.Marker='x';
    else
        h.Color='black';
        h.Marker='o';
    end
   addpoints(h,x(k),y(k));
    
 %  pause(0.0155);
    drawnow; % update screen every .021 seconds
    t(k);
    
end