clc
clear all
close all


%%
[y,Fs] = audioread('raw_audio_dataset_2_1.wav');

sound(y,Fs)

%%
disp('done')
