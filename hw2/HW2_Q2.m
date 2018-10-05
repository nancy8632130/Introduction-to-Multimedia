%%% HW2_Q2.m - bit reduction -> audio dithering -> noise shaping -> low-pass filter -> audio limiting -> normalization
%%% Follow the instructions (hints) and you can finish the homework

%% Clean variables and screen
clear all; close all;clc;

%% Visualization parameters (Change it if you want)
% Some Tips:
% (Tip 1) You can change the axis range to make the plotted result more clearly 
% (Tip 2) You can use subplot function to show multiple spectrums / shapes in one figure
titlefont = 15;
fontsize =6;
LineWidth = 1.5;

%% 1. Read in input audio file ( audioread )
[input, fs] = audioread('Tempest.wav');

%%% Plot the spectrum of input audio
[frequency, magnitude] = makeSpectrum(input, fs);
subplot(3, 4, 1);
plot(frequency, magnitude, 'LineWidth', LineWidth); 
xlim([0,3500]);
title('input spectrum', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);

%%% Plot the shape of input audio
subplot(3, 4, 5);
plot(input(:,1)); 
xlim([50000,51000]);
title('input shape', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);

subplot(3, 4, 9);
plot(input); 
title('input shape', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);

%% 2. Bit reduction
% (Hint) The input audio signal is double (-1 ~ 1) 
input=input*2^15;
s=size(input);
out=zeros(s(1),s(2));

for i=1:s(1)
   for j=1:s(2)
       %out(i,j)=bitsra(input(i,j),8);
       out(i,j)=round(input(i,j)/128)*128;
   end
end

%%% Save audio (audiowrite) Tempest_8bit.wav

audiowrite('Tempest_8bit.wav',out, fs);

%% 3. Audio dithering
% (Hint) add random noise
f_in=out;
pd = makedist('Uniform',-1,1);
addnoise = pdf(pd,f_in);

for i = 1:s(1)
	for j = 1:s(2)
		if i ~= 1
            f_in(i, j) = floor(f_in(i, j) +   addnoise(i,j)) ;
		end
	end
end

%%% Plot the spectrum of the dithered result
[frequency, magnitude] = makeSpectrum(f_in, fs);
subplot(3, 4, 2);
plot(frequency, magnitude, 'LineWidth', LineWidth); 
xlim([0,3500]);
title('dithered result spectrum', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);

subplot(3, 4, 3);
plot(f_in(:,1)); 
xlim([50000,51000]);
title('dithered result shape', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);

subplot(3, 4, 4);
plot(f_in); 
title('dithered result shape', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);


%% 4. First-order feedback loop for Noise shaping
% (Hint) Check the signal value. How do I quantize the dithered signal? maybe scale up first?
fin=round(f_in/128)*128;
c = 1.2;
f_out = fin;
for i = 1:s(1)
	for j = 1:s(2)
		if i ~= 1
            f_out(i, j) = floor(fin(i, j)  +c *(fin(i, j)-f_out(i, j)));
		end
	end
end

%%% Plot the spectrum of noise shaping
[frequency, magnitude] = makeSpectrum(f_out, fs);
subplot(3, 4, 6);
plot(frequency, magnitude, 'LineWidth', LineWidth); 
xlim([0,3500]);
title('noise shaping spectrum', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);

subplot(3, 4, 7);
plot(f_out(:,1)); 
xlim([50000,51000]);
title('noise shaping shape', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);

subplot(3, 4, 8);
plot(f_out); 
title('noise shaping shape', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);

%% 5. Implement Low-pass filter
[f_out(:,1), ~] = myFilter(f_out(:,1) , fs, 1001, 'Blackman', 'low-pass', 1300);
[f_out(:,2), ~] = myFilter(f_out(:,2) , fs, 1001, 'Blackman', 'low-pass',1300);

%% 6. Audio limiting
m1=-1.9*10^4;
m2=1.9*10^4;
for i = 1:s(1)
	for j = 1:s(2)
		if f_out(i,j)<=m1
			f_out(i,j)=m1;
        end
        if f_out(i,j)>=m2
			f_out(i,j)=m2;
        end
	end
end
%% 7. Normalization
in_max = max(max(input));
out_max = max(max(f_out));
gain = in_max/out_max ;
f_out =f_out*gain;
%% 6. Save audio (audiowrite) Tempest_Recover.wav

audiowrite('Tempest_Recover.wav', f_out/2^15, fs);

%%% Plot the spectrum of output audio
[frequency, magnitude] = makeSpectrum(f_out, fs);
subplot(3, 4, 10);
plot(frequency, magnitude, 'LineWidth', LineWidth); 
xlim([0,1]);
title('output spectrum', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);


%%% Plot the shape of output audio
subplot(3, 4, 12);
plot(f_out); 
title('output shape', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);

subplot(3, 4, 11);
plot(f_out(:,1)); 
xlim([50000,51000]);
title('output shape', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);



