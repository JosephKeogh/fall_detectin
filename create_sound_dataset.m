%% Loop n times to create dataset

function f = create_sound_dataset(dataset_title, n)

    % create recorder object
    sample_rate_khz = 8;
    recObj = audiorecorder(sample_rate_khz*1000, 16, 2);

    % how long we are going to record for
    record_length_seconds = 2;
    
    text = "Prepare to record sound for dataset: " + dataset_title;
    disp("")
    disp(text)
    pause(5)

    for i = 1:n    

        disp("Starting to record...");    

        % start recording
        recordblocking(recObj,record_length_seconds);
        disp("End of Recording.");

        % save data into array
        doubleArray = getaudiodata(recObj);

        % save the original sound data
        filename = dataset_title + "_raw_audio_" + i + ".wav";
        audiowrite(filename, doubleArray, sample_rate_khz*1000);

    end

    %delete the sound object
    delete(recObj);
end

