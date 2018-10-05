function [outputSignal, outputFilter] = myFilter(inputSignal, fsample, N, windowName, filterName, fcutoff)
%%% Input 
% inputSignal: input signal
% fsample: sampling frequency
% N : size of FIR filter(odd)
% windowName: 'Blackmann'
% filterName: 'low-pass', 'high-pass', 'bandpass', 'bandstop' 
% fcutoff: cut-off frequency or band frequencies
%       if type is 'low-pass' or 'high-pass', para has only one element         
%       if type is 'bandpass' or 'bandstop', para is a vector of 2 elements

%%% Ouput
% outputSignal: output (filtered) signal
% outputFilter: output filter 

%% 1. Normalization
%
%fc = (0:length(inputSignal)-1)/fsample;
f_c = fcutoff / fsample;
middle = floor(N/2);
outputFilter = zeros(1, N);
%% 2. Create the filter according the ideal equations (slide #76)
% (Hint) Do the initialization for the outputFilter here
% if strcmp(filterName,'?') == 1
% ...
% end

if strcmp(filterName,'low-pass')==1
	for n = -middle:middle
		if n == 0
			outputFilter(n+middle+1)=2*f_c;
		else
			outputFilter(n+middle+1)=sin(2*pi*f_c*n)/(pi*n);
		end
	end
elseif strcmp(filterName,'high-pass')==1
	for n = -middle:middle
		if n == 0
			outputFilter(n+middle+1)= 1-2*f_c;
		else
			outputFilter(n+middle+1)= -sin(2*pi*f_c*n)/(pi*n);
		end
	end
elseif strcmp(filterName,'bandpass')==1
	for n = -middle:middle
		if n == 0
			outputFilter(n+middle+1)= 2*(f_c(2)-f_c(1));
		else
			outputFilter(n+middle+1)=  sin(2*pi*f_c(2)*n)/(pi*n)- sin(2*pi*f_c(1)*n)/(pi*n);
		end
	end
end

%% 3. Create the windowing function (slide #79) and Get the realistic filter
% if strcmp(windowName,'Blackman') == 1 
%     % do it here
% end
if strcmp(windowName,'Blackman')==1
	for n = -middle:middle
		outputFilter(n+middle+1)= outputFilter(n+middle+1)*(0.42+0.5*cos((2*pi*n)/(N-1))+0.08*cos((4*pi*n)/(N-1)));
	end
end

%% 4. Filter the input signal in time domain. Do not use matlab function 'conv'
%[L, ~] = size(inputSignal);
s= size(inputSignal);
outputSignal = zeros(1, s(1));
for n = 1:s(1)
	for h = 1:N
		if n - h < 1
			outputSignal(n)=outputSignal(n)+outputFilter(h)*0;
		else
			outputSignal(n)=outputSignal(n)+outputFilter(h)*inputSignal(n-h);
        end
	end
end






