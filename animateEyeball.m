h = animatedline;
h.MarkerSize = 50;
h.Marker='o';

axis([min(HEOGmV),max(HEOGmV),min(VEOGmV),max(VEOGmV)])

x = decimate(HEOGmV,10);
y = decimate(VEOGmV,10);
t = decimate(TimeSec,10);
[theta, radius] =cart2pol(x,y);
a=tic;
grid on
for k = 3:length(x)
    if(mod(k,3)==0)
        clearpoints(h);
    end
    if(var(x(k:k+3))>.2e-3)
        h.Color='red';
        h.Marker='x';
    else
        h.Color='black';
        h.Marker='o';
    end
    addpoints(h,x(k),y(k));
    
   pause(0.0155);
    drawnow; % update screen every .021 seconds
    t(k)
    
end