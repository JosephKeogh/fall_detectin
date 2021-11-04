%% setup
clc
clear all
close all

%% Recording

% create recorder object
sample_rate_khz = 8;
recObj = audiorecorder(sample_rate_khz*1000, 16, 2);
disp('Starting to record...');

% how long we are going to record for
record_length_seconds = 3;

% start recording
recordblocking(recObj,record_length_seconds);
disp('End of Recording.');

% save data into array
doubleArray = getaudiodata(recObj);

% save the original sound data
audiowrite('raw_audio_1.wav', doubleArray, sample_rate_khz*1000);

%delete the sound object
delete(recObj);
data = doubleArray';


%% Signal Processing

% select the time sampling interval
T = 0.05; % lower this is, the less sampling you have

% Fourier Transform of eeg data
vin = (fft(data));
n = length(data);
fs = 1/T;
f = (1:n)*fs/n;

% plot the data
if isequal(1,1)
    figure(1);
    plot(f, data);
    hold on;
    title('Sounds');
    xlabel('Time');
    ylabel('amp');
end

% plot the fourier transform
if isequal(1,1)
    figure(2);
    plot(f, abs(vin));
    hold on;
    title('Fourier Transform');
    xlabel('Frequency');
    ylabel('Importance');
    xlim([0, 25]);
end

% create the filter
H = 1 ./ (0.002*((f*2*pi*1i).^2) + 0.003*(f*2*pi*1i) + 1 );

% apply the filter to the fourier transform
vout = vin .* H;

% plot the filtered transform
if isequal(1,1)
    plot(f, abs(vout));
    title('Filtered Fourer Transform of sound Data');
    xlabel('Frequency');
    ylabel('Importance');
    xlim([0, 25]);
end

% inverse fourier transform of filtered data
eeg_filtered = ifft(vout);

% plot the filtered data
if isequal(1,1)
    figure(1);
    plot(f, eeg_filtered);
    title('Filtered sound Data');
    xlabel('Time');
    ylabel('Amplitude');
end


disp('done')






























