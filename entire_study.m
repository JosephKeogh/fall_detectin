%% Set Up
clc
clear all
close all

%% Global Variables
samples_per_dataset = 2;
show_data_plots = true;

%% Collect Data

% the string label for the datasets
falls_dataset_name = "falls";
control_dataset_name = "not_falls";

% the numeric label for the datasets
falls_num_identifier = 1;
control_num_identifier = 0;

% collect the data
create_sound_dataset(falls_dataset_name, samples_per_dataset);
create_sound_dataset(control_dataset_name, samples_per_dataset);

% labels for the data
number_labels = [ones(1, samples_per_dataset), zeros(1, samples_per_dataset)]';
text_labels = repelem([falls_dataset_name, control_dataset_name], [samples_per_dataset, samples_per_dataset])';
label_table = table(number_labels, text_labels);

%% Clean Data


%% Signal Processing

feat = [];

% loop through falls data
for sample = 1:samples_per_dataset
    
    % the data file we are looking at
    filename = falls_dataset_name + "_raw_audio_" + sample + ".wav";
    
    % get the data from the datafile
    [y,Fs] = audioread(filename);
    
    % extract features from the data
    data_features = extractSignalFeatures(y);
    
    % append features to all features
    feat = [feat; [data_features]];
    
end

% loop through control data
for sample = 1:samples_per_dataset
    
    % the data file we are looking at
    filename = control_dataset_name + "_raw_audio_" + sample + ".wav";
    
    % get the data from the datafile
    [y,Fs] = audioread(filename);
    
    % extract features from the data
    data_features = extractSignalFeatures(y);
    
    % append features to all features
    feat = [feat; [data_features]];
    
end

feat_table = array2table(feat)

%% Combine data for classification
feat_table(:, "label") = label_table(:, "number_labels");
data_table = feat_table

%% Split for training and testing

% proportion of data to be used for testing
test_prop = 0.5;

data = data_table;

% Cross varidation (train: 70%, test: 30%)
cv = cvpartition(size(data,1),'HoldOut',(1-test_prop));
idx = cv.test;

% split the data
training_data = data(~idx,:);
testing_data = data(idx,:);

% separate labels and features
training_data_feats = training_data;
training_data_feats.label = [];
training_data_feats = table2array(training_data_feats);
training_data_labels = training_data.label;

testing_data_feats = testing_data;
testing_data_feats.label = [];
testing_data_feats = table2array(testing_data_feats);
testing_data_lables = testing_data.label;



%% Train model
model = trainClassifier(training_data);

%% Predictions

preds = model(testing_data_feats)

%% Display Results

%% Done
disp("Completely finished")







































