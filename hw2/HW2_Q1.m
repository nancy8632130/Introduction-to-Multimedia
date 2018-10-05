%%% HW2_Q1.m - Complete the procedure of separating HW2_mix.wav into 3 songs

%% Clean variables and screen
close all;
clear;
clc;

%% Visualization parameters (Change it if you want)
% Some Tips:
% (Tip 1) You can change the axis range to make the plotted result more clearly 
% (Tip 2) You can use subplot function to show multiple spectrums / shapes in one figure
titlefont = 15;
fontsize = 9;
LineWidth = 2;

%% 1. Read in input audio file ( audioread )
% y_input: input signal, fs: sampling rate
[y_input, fs] = audioread('HW2_Mix.wav');

%%% Plot example : plot the input audio
% The provided function "make_spectrum" generates frequency
% and magnitude. Use the following example to plot the spectrum.

[frequency, magnitude] = makeSpectrum(y_input, fs);
subplot(3, 4, 1);
plot(frequency, magnitude, 'LineWidth', LineWidth); 
xlim([0,2300]);
title('Input', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)

%% 2. Filtering 
% (Hint) Implement my_filter here
%[outputSignal, outputFilter] = myFilter(y_input, fs, 48,'Blackmann', 'low-pass', 0.48);
N = 1001;
f1 = 400;
f2 = 780;
band=[400 ,780];
[low_pass_signal, low_pass_filter] = myFilter(y_input, fs, N, 'Blackman', 'low-pass', f1);
[band_pass_signal, band_pass_filter] = myFilter(y_input, fs, N, 'Blackman', 'bandpass',band);
[high_pass_signal, high_pass_filter] = myFilter(y_input, fs, N, 'Blackman', 'high-pass', f2);

%%% Plot the shape of filters in Time domain
%figure;
%The spectrums of the output signals.--------------------------------------
[frequency, magnitude] = makeSpectrum(low_pass_signal, fs);
subplot(3, 4, 2);
plot(frequency, magnitude, 'LineWidth', LineWidth); 
xlim([0,800]);
title('lowpass output signals', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);

[frequency, magnitude] = makeSpectrum(band_pass_signal, fs);
subplot(3, 4, 3);
plot(frequency, magnitude, 'LineWidth', LineWidth); 
xlim([0,1300]);
title('bandpass output signals', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);

[frequency, magnitude] = makeSpectrum(high_pass_signal, fs);
subplot(3, 4, 4);
plot(frequency, magnitude, 'LineWidth', LineWidth); 
xlim([0,2400]);
title('highpass output signals', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
%--------------------------------------------------------------------------
%The spectrums of the filters----------------------------------------------
[frequency, magnitude] = makeSpectrum(low_pass_filter, fs);
subplot(3, 4, 6);
plot(frequency, magnitude, 'LineWidth', LineWidth); 
xlim([0,1000]);
title('lowpass filter', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);

[frequency, magnitude] = makeSpectrum(band_pass_filter, fs);
subplot(3, 4, 7);
plot(frequency, magnitude, 'LineWidth', LineWidth); 
xlim([0,1000]);
title('bandpass filter', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);

[frequency, magnitude] = makeSpectrum(high_pass_filter, fs);
subplot(3, 4, 8);
plot(frequency, magnitude, 'LineWidth', LineWidth); 
xlim([0,1000]);
title('highpass filter', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
%--------------------------------------------------------------------------
%The shapes of the filters-------------------------------------------------
subplot(3, 4, 10);
plot(low_pass_filter); 
title('lowpass filter shapes', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);

subplot(3, 4, 11);
plot(band_pass_filter); 
title('bandpass filter shapes', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);

subplot(3, 4, 12);
plot(high_pass_filter); 
title('highpass filter shapes', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
%--------------------------------------------------------------------------
%%% Plot the spectrum of filters (Frequency Analysis)
%% 3. Save the filtered audio (audiowrite)
% Name the file 'FilterName_para1_para2.wav'
% para means the cutoff frequency that you set for the filter

% audiowrite('FilterName_para1_para2.wav', output_signal1, fs);

%%% Plot the spectrum of filtered signals

audiowrite('FilterName_Blackman_low-pass.wav',low_pass_signal, fs);
audiowrite('FilterName_Blackman_bandpass.wav',band_pass_signal, fs);
audiowrite('FilterName_Blackman_high-pass.wav', high_pass_signal, fs);

%% 4. one-fold echo and multiple-fold echo (slide #69)
%one-fold echo
s=size(y_input);
one_fold_echo = zeros(1, s(1));
multiple_fold_echo= zeros(1, s(1));
for i=1:s(1)
    if(i<=3200)
         one_fold_echo(i)=low_pass_signal(i);
    else
         one_fold_echo(i)=low_pass_signal(i)+0.8*low_pass_signal(i-3200);
    end
end
%multiple-fold echo
for i=1:s(1)
    if(i<=3200)
         multiple_fold_echo(i)=low_pass_signal(i);
    else
         multiple_fold_echo(i)=low_pass_signal(i)+0.4*multiple_fold_echo(i-3200);
    end
end
%% 5. Save the echo audios  'Echo_one.wav' and 'Echo_multiple.wav'
audiowrite('Echo_one.wav',one_fold_echo, fs);
audiowrite('Echo_multiple.wav',multiple_fold_echo, fs);



