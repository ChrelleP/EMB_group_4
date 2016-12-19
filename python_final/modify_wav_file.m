%% MATLAB downsampling of WAV file
clc; clear;

% Load wav file
[data, rate] = audioread( 'low_battery_recorded.wav' );

% Downsample
ds_integer = 4;
ds_data = downsample(data, ds_integer);
rate = floor(rate / ds_integer);
[samples, channels] = size(ds_data);

% Make Mono
if channels == 2
    ds_data = (ds_data(:,1) + ds_data(:,2) ) / 2;
end

freqOfTone = 400; %audacity is showing freq = 2100hz (approx)
samplingFreq = 44100 ;
duration = 3; %the file properties is showing duration of 5s
t=[0: 1/samplingFreq: duration];
y=sin(2*pi*freqOfTone*t)';


plot(ds_data)

% Write wav file
audiowrite('modified.wav', ds_data, rate);
disp('Modification complete!')

%% Plot FFT and run low pass motherfucker

n=length(ds_data)-1;

f=0:samplingFreq/n:samplingFreq;

wavefft=abs(fft(ds_data)); % perform Fourier Transform

subplot(2,1,1)
plot(f,wavefft); % plot Fourier Transform
xlabel('frequency')
ylabel('Amplitude')
title('Frequency Domain Plot')

fc=4300;
[b,a] = butter(5,fc/(samplingFreq/2),'low');
output = filter(b,a,ds_data);


n=length(output)-1;

f=0:samplingFreq/n:samplingFreq;

wavefft=abs(fft(output)); % perform Fourier Transform

subplot(2,1,2)

plot(f,wavefft); % plot Fourier Transform
xlabel('frequency')
ylabel('Amplitude')


audiowrite('modified_lp.wav', output, rate);


%% modify as square
binary = zeros(1,length(output));
for i = 1:length(ds_data)
    if(output(i) > 0)
       binary(i) = 1;
    else
        binary(i) = 0;
    end;
end;

audiowrite('binary.wav', binary, rate);

plot(binary)


%% Plot FFT and run low pass motherfucker

n=length(binary)-1;

f=0:samplingFreq/n:samplingFreq;

wavefft=abs(fft(binary)); % perform Fourier Transform

subplot(2,1,1)
plot(f,wavefft); % plot Fourier Transform
xlabel('frequency')
ylabel('Amplitude')
title('Frequency Domain Plot')
%% LP filter
fc=3000;
[b,a] = butter(5,fc/(samplingFreq/2),'low');
output = filter(b,a,ds_data);


n=length(output)-1;

f=0:samplingFreq/n:samplingFreq;

wavefft=abs(fft(output)); % perform Fourier Transform

subplot(2,1,2)

plot(f,wavefft); % plot Fourier Transform
xlabel('frequency')
ylabel('Amplitude')


audiowrite('modified_lp.wav', output, rate);

%% Plotting of data and examples

% Sinus waveform
t       = [0:0.1:20];
Amp     = 1;
freq    = 1000;
sin_wav = A*sin(f*t);

% Normalize
max_val = max([max(ds_data), abs(min(ds_data))]);
norm_val = 255;
norm_data = ds_data / max_val * norm_val;

% Method 3
method3_data = abs(norm_data);
method3_ori = zeros(samples,1);
method3_ori(norm_data>0) = 1;

% ----- Plots -----
range_upper = 1200;
range_lower = 800;
range = range_lower:1:range_upper;

% Plot signal
figure(1)
subplot(2,1,1)
plot(range, ds_data([range_lower:range_upper]))
subplot(2,1,2)
plot(range, norm_data([range_lower:range_upper]))
axis([-inf inf -255 255])

% Plot method 3
figure(2)
subplot(3,1,1)
plot(range, norm_data([range_lower:range_upper]))
axis([-inf inf -norm_val norm_val])
subplot(3,1,2)
plot(range, method3_ori([range_lower:range_upper]))
axis([-inf inf 0 1.2])
subplot(3,1,3)
plot(range, method3_data([range_lower:range_upper]))