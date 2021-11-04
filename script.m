% if you want to plot the graphs, change the values in the if statement to
% be equal

% clear the workspace
clc
clear all
close all

% load the eeg data
% eeg = load('eeg_data.mat');
load eeg_data;

% select the time sampling interval
T = 0.02;

% Fourier Transform of eeg data
vin = (fft(eeg));
n = length(eeg);
fs = 1/T;
f = (1:n)*fs/n;

% plot the data
if isequal(1,1)
    figure(1);
    plot(f, eeg);
    title('Raw EEG Data');
    xlabel('Time');
    ylabel('Voltage');
end

% plot the fourier transform
if isequal(1,1)
    figure(2);
    plot(f, abs(vin));
    title('Fourer Transform of EEG Data');
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
    figure(3);
    plot(f, abs(vout));
    title('Filtered Fourer Transform of EEG Data');
    xlabel('Frequency');
    ylabel('Importance');
    xlim([0, 25]);
end

% inverse fourier transform of filtered data
eeg_filtered = ifft(vout);

% plot the filtered data
if isequal(1,1)
    figure(4);
    plot(f, eeg_filtered);
    title('Filtered EEG Data');
    xlabel('Time');
    ylabel('Voltage');
end
