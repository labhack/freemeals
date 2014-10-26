

windowsize=8;
for k = 1:length(TimeSec)-7
varWindow(k)=(var(theta(k:k+windowsize-1)))^2;   

if(varWindow(k)>20)
    saccades_radius(k)=radius(k);
    saccades_angle(k)=theta(k);
end
    
end

saccade_polar=saccades_radius.*exp(j*saccades_angle);

%plot(TimeSec(1:length(TimeSec)-7),varWindow)