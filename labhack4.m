%labhack3
clear

time_inc = 0.01;
subject = 2;
trial = 1;
%% Set stream tokens

my_credentials = loadplotlycredentials;
my_stream_token1 = 'gr6r6ghf62';
my_stream_token2 = 'oktev14vf2';
my_stream_token3 = 'ht5emp1jmc';
my_stream_token4 = 'r71dyuvm4l';
my_stream_token5 = 'm16dar9t5a';

%% Read file data
ECGstr = ['D:\labhack\AllData\LABHACK\HUMAN Formal Study 1 Raw Physio Exports - BioRadio\EEG Exports 1of 3\Subject ' num2str(subject) '\Trial ' num2str(trial) '_R1_Fast.txt'];
ECGSTUFF = importdata(ECGstr);
EYESstr = ['D:\labhack\AllData\LABHACK\HUMAN Formal Study 1 Raw Physio Exports - BioRadio\EEG Exports 1of 3\Subject ' num2str(subject) '\Trial ' num2str(trial) '_R2_Fast.txt'];
EYES = importdata(EYESstr);
hr = ECGSTUFF;
filename=horzcat('D:\labhack\AllData\LABHACK\HUMAN Formal Study 1 Performance Time History Data\Subject ',num2str(subject),'\Survelillance Scores TH\P2_T',num2str(trial),'_Surveillance_Scores_TH.txt');
score_surv=importdata(filename);
filename=horzcat('D:\labhack\AllData\LABHACK\HUMAN Formal Study 1 Performance Time History Data\Subject ',num2str(subject),'\Tracking Scores TH\P2_T',num2str(trial),'_Tracking_Scores_TH.txt');
score_track=importdata(filename);
filename=horzcat('D:\labhack\AllData\LABHACK\HUMAN Formal Study 1 Respiration Time History Data\Subject ',num2str(subject),'\Surveillance\P2_T',num2str(trial),'_Surv_Respiration_TH.txt');
resp_surv=importdata(filename);
filename=horzcat('D:\labhack\AllData\LABHACK\HUMAN Formal Study 1 Respiration Time History Data\Subject ',num2str(subject),'\Tracking\P2_T',num2str(trial),'_Tracking_Respiration_TH.txt');
resp_track=importdata(filename);


time_averaging=20; %Time average in seconds for hr and rr
f_hr=496.15;
f_resp=18; %Heart rate and respiratory rate

xeye = EYES.data(:,9);
yeye = EYES.data(:,8);
teye = EYES.data(:,1);
tECG = ECGSTUFF.data(:,1);
ECG = ECGSTUFF.data(:,2);

%PERFORMANCE DATA - BAR
time_per=[score_surv.data(:,1)' 600+score_track.data(:,1)'];
score_tot=[score_surv.data(:,4)' score_track.data(:,4)'];
score_one=[score_surv.data(:,2)' score_surv.data(end,2)+score_track.data(:,2)'];
score_diff = diff(score_one);
time_diff = time_per(2:end);


%HEART RATE DATA - BAR
hr_vec=hr.data(:,2);
hr_time=hr.data(:,1);
%RESP RATE DATA - BAR
resp_data=[resp_surv.data(:,3)' resp_track.data(:,3)'];
resp_time=[resp_surv.data(:,1)' 600+resp_track.data(:,1)'];


kk=1;
ll=1;

%% Setup plotly plots
%----SETUP-----%

data{1}.x = [];
data{1}.y = [];
data{1}.type = 'scatter';
data{1}.stream.token = my_stream_token1;
data{1}.stream.maxpoints = 50;
data{1}.xaxis = 'x1';
data{1}.yaxis = 'y1';

data{2}.x = [];
data{2}.y = [];
data{2}.type = 'bar';
data{2}.stream.token = my_stream_token2;
data{2}.stream.maxpoints = 1;
data{2}.xaxis = 'x2';
data{2}.yaxis = 'y2';

data{3}.x = [];
data{3}.y = [];
data{3}.type = 'scatter';
data{3}.mode = 'lines+markers';
data{3}.stream.token = my_stream_token3;
data{3}.stream.maxpoints = 1;
data{3}.xaxis = 'x3';
data{3}.yaxis = 'y3';
data{3}.marker.symbol = 'circle';
data{3}.marker.size = 10;

data{4}.x = [];
data{4}.y = [];
data{4}.type = 'bar';
data{4}.stream.token = my_stream_token4;
data{4}.stream.maxpoints = 1;
data{4}.xaxis = 'x4';
data{4}.yaxis = 'y4';

data{5}.x = [];
data{5}.y = [];
data{5}.type = 'bar';
data{5}.stream.token = my_stream_token5;
data{5}.stream.maxpoints = 1;
data{5}.xaxis = 'x5';
data{5}.yaxis = 'y5';

args.layout.xaxis1.anchor = 'y1';
args.layout.yaxis1.title = 'ECG (mV)';
args.layout.yaxis1.anchor = 'x1';
args.layout.yaxis1.range = [-2 2];
args.layout.xaxis1.domain = [0.6 1];
args.layout.yaxis1.domain = [0.7 1];

args.layout.xaxis2.anchor = 'y2';
args.layout.yaxis2.title = 'RR Amplitude';
args.layout.yaxis2.anchor = 'x2';
args.layout.yaxis2.range = [-2 2];
args.layout.xaxis2.domain = [0 0.4];
args.layout.yaxis2.domain = [0.7 1];
args.layout.xaxis2.showticklabels = 'false';

args.layout.xaxis3.anchor = 'y3';
args.layout.yaxis3.anchor = 'x3';
args.layout.xaxis3.title = 'EOG Horizontal (mV)';
args.layout.yaxis3.title = 'EOG Vertical (mV)';
args.layout.yaxis3.range = [min(yeye)-.1 max(yeye)+.1];
args.layout.xaxis3.range = [min(xeye)-.1 max(xeye)+.1];
args.layout.xaxis3.domain = [0 0.4];
args.layout.yaxis3.domain = [0.3667 0.6667];

args.layout.xaxis4.anchor = 'y4';
args.layout.yaxis4.title = 'HR Amplitude';
args.layout.yaxis4.anchor = 'x4';
args.layout.yaxis4.range = [-2 2];
args.layout.xaxis4.domain = [0.6 1];
args.layout.yaxis4.domain = [0.3667 0.6667];
args.layout.xaxis4.showticklabels = 'false';

args.layout.xaxis5.anchor = 'y5';
args.layout.yaxis5.title = 'Differential Performance';
args.layout.yaxis5.anchor = 'x5';
args.layout.yaxis5.range = [-2 2];
args.layout.xaxis5.domain = [0.6 1];
args.layout.yaxis5.domain = [0 0.3];
args.layout.xaxis5.showticklabels = 'false';

%----PLOTLY-----%

resp1  = plotly(data,args);
resp1.url = 'https://plot.ly/~jarneal/7';
URL_OF_PLOT = resp1.url;
ps1 = plotlystream(my_stream_token1);
ps2 = plotlystream(my_stream_token2);
ps3 = plotlystream(my_stream_token3);
ps4 = plotlystream(my_stream_token4);
ps5 = plotlystream(my_stream_token5);

%----open the stream----%
ps1.open();
ps2.open();
ps3.open();
ps4.open();
ps5.open();

%% Actually do the processing
tmin = min(tECG);
tmax = max(tECG);
t = tmin+.02;
while t<50
    ECG1 = getrecent(ECG,tECG,t);
    mydata.x = t;
    mydata.y = ECG1;
    ps1.write(mydata);
    mydata.x = getrecent(xeye,teye,t);
    mydata.y = getrecent(yeye,teye,t);
    ps3.write(mydata);
    mydata.y = getrecent(score_diff,time_diff,t);
    mydata.x = t;
    ps5.write(mydata);
    
    if mod(t,time_averaging)<(time_inc) && (t<max(resp_surv.data(:,1)) || t>600)
        nfft=4*f_resp*time_averaging; %Number of fft samples
        df = f_resp/(nfft);
        frequency=(-f_resp/2):df:(f_resp/2);
        [~,idx]=min(abs(resp_time-t));
        data_wind=resp_data(idx-18*f_resp+1:idx);
        data_wind=data_wind-mean(data_wind);
        data_ft=fftshift(abs(fft(data_wind,nfft)));
        [~,index]=max(data_ft);
        resp(kk)=abs(frequency(index));
        resp_time_2(kk)=t;
        mydata.x = 0;
        mydata.y = resp(kk);
        ps2.write(mydata);
        [~,idx]=min(abs(time_per-t));
        perf_avg(kk)=mean(score_one(idx-19:idx));
        kk=kk+1;
    elseif kk-1==0
        mydata.x = 0;
        mydata.y = 0;
        ps2.write(mydata)
    else
        mydata.x = 0;
        mydata.y = resp(kk-1);
        ps2.write(mydata)
    end
    
    if mod(t,time_averaging)<time_inc
        hr_wind=round(19*f_hr);
        nfft=round(4*hr_wind);
        df=f_hr/nfft;
        frequency2=(-f_hr/2):df:(f_hr/2)-df;
        mask=abs(frequency2)<3;
        [~,idx]=min(abs(hr_time-t));
        [a,b]=butter(5,3/(476.1906/2));
        data_wind=hr_vec(idx-round(19*f_hr):idx);
        data_wind=data_wind-mean(data_wind);
        data_wind=filtfilt(a,b,data_wind);
        data_ft=fftshift(abs(fft(data_wind,nfft)));
        [~,index]=max(data_ft.*mask');
        heart_rate(ll)=abs(frequency2(index));
        mydata.x = 0;
        mydata.y = heart_rate(ll);
        ps4.write(mydata);
        hr_time_2(ll)=t;
        ll=ll+1;
    elseif ll-1==0
        mydata.x = 0;
        mydata.y = 0;
        ps4.write(mydata);
    else
        mydata.x = 0;
        mydata.y = heart_rate(ll-1);
        ps4.write(mydata);
    end
    
    pause(.01)
    t = t+time_inc;
end

%----close the stream----%

ps1.close();
ps2.close();
ps3.close();
ps4.close();
ps5.close();

%DISPLAY AT THE END ?


figure
subplot(2,1,1)
plot(time_per,score_tot);
title('Cumulative Score')
xlabel('Time (s)')
ylabel('Cumulative Score')

subplot(2,1,2)
plotyy(resp_time_2,resp,hr_time_2,heart_rate);
xlabel('Time')
ylabel('Frequency')
legend('Respiratory','Heart Rate')


figure
subplot(2,1,1)
R_mat=[resp',diff([0 perf_avg])'];
R_mat=sortrows(R_mat)
plot(R_mat(:,1),R_mat(:,2));
xlabel('Respiratory Rate')
ylabel('Differential Score')

[~,index]=min(abs(hr_time_2-resp_surv.data(end,1)));
[~,index2]=min(abs(hr_time_2-600+resp_track.data(1,1)));
heart_rate_2=[heart_rate(1:index-1) heart_rate(index2:end)];
H_mat=[heart_rate_2',diff([0 perf_avg])']
H_mat=sortrows(H_mat);
subplot(2,1,2)
plot(H_mat(:,1),H_mat(:,2))
xlabel('Heart Rate')
ylabel('Differential Score')







