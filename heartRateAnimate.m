h = animatedline;
%h.Marker = 'x';
h.MarkerSize = 10;
axis([0,150,min(ECGmV),max(ECGmV)])

y = decimate(ECGmV,2);
%t = decimate(TimeSec,1);
t = 1:length(y);
a=tic;
for k = 1:length(x)
    if(mod(k,150)==0)
        clearpoints(h)
    end
    
    addpoints(h,mod(t(k),150),y(k));
    
   %pause(0.0155);
    drawnow % update screen every .021 seconds
    t(k)
    
end