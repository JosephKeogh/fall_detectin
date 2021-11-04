function feat = extractSignalFeatures(y)

    feat = zeros(1,2);

    % grab data from file
    data = y';
    
    T = 0.05;

    % Fourier Transform of eeg data
    vin = (fft(data));
    n = length(data);
    fs = 1/T;
    f = (1:n)*fs/n;

    % create the filter
    H = 1 ./ (0.002*((f*2*pi*1i).^2) + 0.003*(f*2*pi*1i) + 1 );

    % apply the filter to the fourier transform
    vout = vin .* H;

    % inverse fourier transform of filtered data
    data_filtered = ifft(vout);
    
    % get the peaks of the data
    feat(1,1) = abs(max(vout(1,:)));
    feat(1,2) = abs(min(vout(1,:)));
   
end














