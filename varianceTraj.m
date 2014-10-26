windowsize=8;
x = decimate(HEOGmV,10);
y = decimate(VEOGmV,10);
[theta, radius] =cart2pol(x,y);
polar_eye_position=radius.*exp(j*theta);


for k = 1:length(TimeSec(1:10000))
varWindow(k)=var(HEOGmV(k:k+3));   

    
end

plot(TimeSec(1:10000),varWindow)%)


x = HEOGmV;
y = VEOGmV;
a=tic;
