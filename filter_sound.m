function [data, vin, vout, data_filtered] = filter_sound(file_name, T)

    num=2;
    
    % grab data from file
    [y,Fs] = audioread(file_name);
    data = y';

    % Fourier Transform of eeg data
    vin = (fft(data));
    n = length(data);
    fs = 1/T;
    f = (1:n)*fs/n;

    % plot the data
    if isequal(1,num)
        figure(1);
        plot(f, data);
        hold on;
        title('Sounds');
        xlabel('Time');
        ylabel('amp');
    end

    % plot the fourier transform
    if isequal(1,num)
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
    if isequal(1,num)
        plot(f, abs(vout));
        title('Filtered Fourer Transform of sound Data');
        xlabel('Frequency');
        ylabel('Importance');
        xlim([0, 25]);
    end

    % inverse fourier transform of filtered data
    data_filtered = ifft(vout);

    % plot the filtered data
    if isequal(1,num)
        figure(1);
        plot(f, data_filtered);
        title('Filtered sound Data');
        xlabel('Time');
        ylabel('Amplitude');
    end
end