clear; clc; close all;

%% Question 1 
% Load reference image: frame437
% Load target image: frame439
reference=imread('data/frame437.jpg');
target=imread('data/frame439.jpg');
s=size(reference);

% PSNR and total SAD values (for plotting) 

%%% Full Search %%%
% search range = กำ8 / macroblock size = 8x8
searchRange = 8;
macroblockSize = 8;

% PSNR_full = [PSNR_full ???];  => ??? is your PSNR value  
% SAD_full = [SAD_full ???];    => ??? is your total SAD value

%figure; imshow(tar/2+0.5);
% Show motion vectors:
% - MV is your motion vectors matrix
% - Size of MV is (h/macroblockSize, w/macroblockSize, 2)
% - Frame size: (h, w, 3) 
%hold on, quiver(1:macroblockSize:w, 1:macroblockSize:h, MV(:,:, 2), MV(:,:,1)), hold off; 
reference=im2double(reference);       
target=im2double(target);
X = {'a:predicted images','b:motion vectors images','c:residual images','SAD','PSNR','Q2','CPU Time'};

% search range = กำ8 / macroblock size = 8x8
t1=cputime;
[predicted_image_8_8 ,MV_8_8]= full_search(8,8,target,reference);
tf_8_8=cputime-t1;

%*******************************************************************************************
% search range = กำ8 / macroblock size = 16x16
t1=cputime;
[predicted_image_16_8 ,MV_16_8]= full_search(16,8,target,reference);
tf_16_8=cputime-t1;
%*******************************************************************************************
% search range = กำ16 / macroblock size = 8x8
t1=cputime;
[predicted_image_8_16 ,MV_8_16]= full_search(8,16,target,reference);
tf_8_16=cputime-t1;
%*******************************************************************************************
% search range = กำ16 / macroblock size = 16x16
t1=cputime;
[predicted_image_16_16 ,MV_16_16]= full_search(16,16,target,reference);
tf_16_16=cputime-t1;
%*******************************************************************************************

%%% 2D Logarithmic Search %%%
% search range = กำ8 / macroblock size = 8x8
t1=cputime;
[two_d_8_8,MV2_8_8]= twoD_logarithmic_search(8,8,target,reference);
t2_8_8=cputime-t1;

%*******************************************************************************************
% search range = กำ8 / macroblock size = 16x16
t1=cputime;
[two_d_16_8,MV2_16_8]= twoD_logarithmic_search(16,8,target,reference);
t2_16_8=cputime-t1;
%*******************************************************************************************
% search range = กำ16 / macroblock size = 8x8
t1=cputime;
[two_d_8_16,MV2_8_16]= twoD_logarithmic_search(8,16,target,reference);
t2_8_16=cputime-t1;

%*******************************************************************************************
% search range = กำ16 / macroblock size = 16x16
t1=cputime;
[two_d_16_16,MV2_16_16]= twoD_logarithmic_search(16,16,target,reference);
t2_16_16=cputime-t1;
%SHOW predicted images
figure('name',X{1},'numbertitle','off');
subplot(4, 2, 1);
imshow(predicted_image_8_8);
title('full-predicted-p=8-N=8'); 

subplot(4, 2, 3);
imshow(predicted_image_16_8);
title('full-predicted-p=8-N=16'); 

subplot(4, 2, 5);
imshow(predicted_image_8_16);
title('full-predicted-p=16-N=8'); 

subplot(4, 2, 7);
imshow(predicted_image_16_16);
title('full-predicted-p=16-N=16'); 

subplot(4, 2, 2);
imshow(two_d_8_8);
title('2D-predicted-p=8-N=8'); 

subplot(4, 2, 4);
imshow(two_d_16_8);
title('2D-predicted-p=8-N=16'); 

subplot(4, 2, 6);
imshow(two_d_8_16);
title('2D-predicted-p=16-N=8'); 

subplot(4, 2, 8);
imshow(two_d_16_16);
title('2D-predicted-p=16-N=16'); 

%SHOW motion vectors images
figure('name',X{2},'numbertitle','off');
subplot(4, 2, 1);

imshow(target);
hold on, quiver(1:8:s(2), 1:8:s(1), MV_8_8(:,:, 2), MV_8_8(:,:,1)), hold off; 
title('full-MV-p=8-N=8'); 

subplot(4, 2, 3);
imshow(target);
hold on, quiver(1:16:s(2), 1:16:s(1), MV_16_8(:,:, 2), MV_16_8(:,:,1)), hold off; 
title('full-MV-p=8-N=16'); 

subplot(4, 2, 5);
imshow(target);
hold on, quiver(1:8:s(2), 1:8:s(1), MV_8_16(:,:, 2), MV_8_16(:,:,1)), hold off; 

subplot(4, 2,7);
imshow(target);
hold on, quiver(1:16:s(2), 1:16:s(1), MV_16_16(:,:, 2), MV_16_16(:,:,1)), hold off; 
title('full-MV-p=16-N=16'); 

subplot(4, 2, 2);
imshow(target);
hold on, quiver(1:8:s(2), 1:8:s(1), MV2_8_8(:,:, 2), MV2_8_8(:,:,1)), hold off; 
title('2D-MV-p=8-N=8'); 

subplot(4, 2, 4);
imshow(target);
hold on, quiver(1:16:s(2), 1:16:s(1), MV2_16_8(:,:, 2), MV2_16_8(:,:,1)), hold off; 
title('2D-MV-p=8-N=16'); 

subplot(4, 2, 6);
imshow(target);
hold on, quiver(1:8:s(2), 1:8:s(1), MV2_8_16(:,:, 2), MV2_8_16(:,:,1)), hold off; 
title('2D-MV-p=16-N=8'); 

subplot(4, 2, 8);
imshow(target);
hold on, quiver(1:16:s(2), 1:16:s(1), MV2_16_16(:,:, 2), MV2_16_16(:,:,1)), hold off; 
title('2D-MV-p=16-N=16'); 

%SHOW residual images
figure('name',X{3},'numbertitle','off');

residual_image_8_8 = generate_residual_image(target,predicted_image_8_8)
subplot(4, 2, 1);
imshow(residual_image_8_8);
title('full-residual-p=8-N=8'); 

residual_image_16_8 = generate_residual_image(target,predicted_image_16_8)
subplot(4, 2, 3);
imshow(residual_image_16_8);
title('full-residual-p=8-N=16'); 

residual_image_8_16 = generate_residual_image(target,predicted_image_8_16)
subplot(4, 2, 5);
imshow(residual_image_8_16);
title('full-residual-p=16-N=8'); 

residual_image_16_16 = generate_residual_image(target,predicted_image_16_16)
subplot(4, 2, 7);
imshow(residual_image_16_16);
title('full-residual-p=16-N=16'); 

residual_image2_8_8 = generate_residual_image(target,two_d_8_8)
subplot(4, 2, 2);
imshow(residual_image2_8_8);
title('2D-residual-p=8-N=8'); 

residual_image2_16_8 = generate_residual_image(target,two_d_16_8)
subplot(4, 2, 4);
imshow(residual_image2_16_8);
title('2D-residual-p=8-N=16'); 

residual_image2_8_16 = generate_residual_image(target,two_d_16_8)
subplot(4, 2, 6);
imshow(residual_image2_8_16);
title('2D-residual-p=16-N=8'); 

residual_image2_16_16 = generate_residual_image(target,two_d_16_16)
subplot(4, 2, 8);
imshow(residual_image2_16_16);
title('2D-residual-p=16-N=16'); 


%% Plot total SAD and PSNR
%SHOW SAD
figure('name',X{4},'numbertitle','off');
%full
f_8_8= SAD(target,predicted_image_8_8);
f_16_8= SAD(target,predicted_image_16_8);
f_8_16= SAD(target,predicted_image_8_16);
f_16_16= SAD(target,predicted_image_16_16);
%2D
d_8_8= SAD(target,two_d_8_8);
d_16_8= SAD(target,two_d_16_8);
d_8_16= SAD(target,two_d_8_16);
d_16_16= SAD(target,two_d_16_16);

SAD_full = [f_8_8,f_16_8,f_8_16,f_16_16];
SAD_2D = [d_8_8,d_16_8,d_8_16,d_16_16];
x = [1 2 3 4];
plot(x, SAD_full, x, SAD_2D);
x = [1 2 3 4];
legend('full', '2D');
xticks(x);
xticklabels({'8, 8x8', '8, 16x16', '16, 8x8', '16, 16x16'});
title('SAD');

%SHOW PSNR
figure('name',X{5},'numbertitle','off');
%full  
%n=8 p=8
target=im2uint8(target);
predicted_image_8_8=im2uint8(predicted_image_8_8);
mseR=(double(target(:,:,1))-double(predicted_image_8_8(:,:,1))).^2;
mseG=(double(target(:,:,2))-double(predicted_image_8_8(:,:,2))).^2;
mseB=(double(target(:,:,3))-double(predicted_image_8_8(:,:,3))).^2;
mR=sum(sum(mseR))/(s(1)*s(2));
mG=sum(sum(mseG))/(s(1)*s(2));
mB=sum(sum(mseB))/(s(1)*s(2));
mse=(mR+mG+mB)/3;
PSNR_full_8_8=10*log10(255^2/mse);
%P_full_8_8=psnr(target,predicted_image_8_8);
%n=16 p=8
target=im2uint8(target);
predicted_image_16_8=im2uint8(predicted_image_16_8);
mseR=(double(target(:,:,1))-double(predicted_image_16_8(:,:,1))).^2;
mseG=(double(target(:,:,2))-double(predicted_image_16_8(:,:,2))).^2;
mseB=(double(target(:,:,3))-double(predicted_image_16_8(:,:,3))).^2;
mR=sum(sum(mseR))/(s(1)*s(2));
mG=sum(sum(mseG))/(s(1)*s(2));
mB=sum(sum(mseB))/(s(1)*s(2));
mse=(mR+mG+mB)/3;
PSNR_full_16_8=10*log10(255^2/mse);
%P_full_16_8=psnr(target,predicted_image_16_8);
%n=8 p=16
target=im2uint8(target);
predicted_image_8_16=im2uint8(predicted_image_8_16);
mseR=(double(target(:,:,1))-double(predicted_image_8_16(:,:,1))).^2;
mseG=(double(target(:,:,2))-double(predicted_image_8_16(:,:,2))).^2;
mseB=(double(target(:,:,3))-double(predicted_image_8_16(:,:,3))).^2;
mR=sum(sum(mseR))/(s(1)*s(2));
mG=sum(sum(mseG))/(s(1)*s(2));
mB=sum(sum(mseB))/(s(1)*s(2));
mse=(mR+mG+mB)/3;
PSNR_full_8_16=10*log10(255^2/mse);
%P_full_8_16=psnr(target,predicted_image_8_16);
%n=16 p=16
target=im2uint8(target);
predicted_image_16_16=im2uint8(predicted_image_16_16);
mseR=(double(target(:,:,1))-double(predicted_image_16_16(:,:,1))).^2;
mseG=(double(target(:,:,2))-double(predicted_image_16_16(:,:,2))).^2;
mseB=(double(target(:,:,3))-double(predicted_image_16_16(:,:,3))).^2;
mR=sum(sum(mseR))/(s(1)*s(2));
mG=sum(sum(mseG))/(s(1)*s(2));
mB=sum(sum(mseB))/(s(1)*s(2));
mse=(mR+mG+mB)/3;
PSNR_full_16_16=10*log10(255^2/mse);
%P_full_16_16=psnr(target,predicted_image_16_16);

%2D
%n=8 p=8
target=im2uint8(target);
two_d_8_8=im2uint8(two_d_8_8);
mseR=(double(target(:,:,1))-double(two_d_8_8(:,:,1))).^2;
mseG=(double(target(:,:,2))-double(two_d_8_8(:,:,2))).^2;
mseB=(double(target(:,:,3))-double(two_d_8_8(:,:,3))).^2;
mR=sum(sum(mseR))/(s(1)*s(2));
mG=sum(sum(mseG))/(s(1)*s(2));
mB=sum(sum(mseB))/(s(1)*s(2));
mse=(mR+mG+mB)/3;
PSNR_full2_8_8=10*log10(255^2/mse);
%P_full2_8_8=psnr(target,two_d_8_8);
%n=16 p=8
target=im2uint8(target);
two_d_16_8=im2uint8(two_d_16_8);
mseR=(double(target(:,:,1))-double(two_d_16_8(:,:,1))).^2;
mseG=(double(target(:,:,2))-double(two_d_16_8(:,:,2))).^2;
mseB=(double(target(:,:,3))-double(two_d_16_8(:,:,3))).^2;
mR=sum(sum(mseR))/(s(1)*s(2));
mG=sum(sum(mseG))/(s(1)*s(2));
mB=sum(sum(mseB))/(s(1)*s(2));
mse=(mR+mG+mB)/3;
PSNR_full2_16_8=10*log10(255^2/mse);
%P_full2_16_8=psnr(target,two_d_16_8);
%n=8 p=16
target=im2uint8(target);
two_d_8_16=im2uint8(two_d_8_16);
mseR=(double(target(:,:,1))-double(two_d_8_16(:,:,1))).^2;
mseG=(double(target(:,:,2))-double(two_d_8_16(:,:,2))).^2;
mseB=(double(target(:,:,3))-double(two_d_8_16(:,:,3))).^2;
mR=sum(sum(mseR))/(s(1)*s(2));
mG=sum(sum(mseG))/(s(1)*s(2));
mB=sum(sum(mseB))/(s(1)*s(2));
mse=(mR+mG+mB)/3;
PSNR_full2_8_16=10*log10(255^2/mse);
%P_full2_8_16=psnr(target,two_d_8_16);
%n=16 p=16
target=im2uint8(target);
two_d_16_16=im2uint8(two_d_16_16);
mseR=(double(target(:,:,1))-double(two_d_16_16(:,:,1))).^2;
mseG=(double(target(:,:,2))-double(two_d_16_16(:,:,2))).^2;
mseB=(double(target(:,:,3))-double(two_d_16_16(:,:,3))).^2;
mR=sum(sum(mseR))/(s(1)*s(2));
mG=sum(sum(mseG))/(s(1)*s(2));
mB=sum(sum(mseB))/(s(1)*s(2));
mse=(mR+mG+mB)/3;
PSNR_full2_16_16=10*log10(255^2/mse);
%P_full2_16_16=psnr(target,two_d_16_16);

%PSNR_full = [P_full_8_8,P_full_16_8,P_full_8_16,P_full_16_16];  
%PSNR_2D = [P_full2_8_8,P_full2_16_8,P_full2_8_16,P_full2_16_16];
PSNR_full = [PSNR_full_8_8,PSNR_full_16_8,PSNR_full_8_16,PSNR_full_16_16];  
PSNR_2D = [PSNR_full2_8_8,PSNR_full2_16_8,PSNR_full2_8_16,PSNR_full2_16_16];
x = [1 2 3 4];
plot(x, PSNR_full, x, PSNR_2D);
legend('full', '2D');
xticks(x);
xticklabels({'8, 8x8', '8, 16x16', '16, 8x8', '16, 16x16'});
title('PSNR');
%% Question 2
% Load reference image: frame432
reference2=imread('data/frame432.jpg');
reference2=im2double(reference2);    
target=im2double(target);    

% Target image is same as Q1: frame439
% search range = กำ8 / macroblock size = 8x8
[predicted_image_Q2 ,MV_8_8]= full_search(8,8,target,reference2);

%PSNR
%n=8 p=8
target=im2uint8(target);
predicted_image_Q2=im2uint8(predicted_image_Q2);
mseR=(double(target(:,:,1))-double(predicted_image_Q2(:,:,1))).^2;
mseG=(double(target(:,:,2))-double(predicted_image_Q2(:,:,2))).^2;
mseB=(double(target(:,:,3))-double(predicted_image_Q2(:,:,3))).^2;
mR=sum(sum(mseR))/(s(1)*s(2));
mG=sum(sum(mseG))/(s(1)*s(2));
mB=sum(sum(mseB))/(s(1)*s(2));
mse=(mR+mG+mB)/3;
PSNR=10*log10(255^2/mse);
P=psnr(target,predicted_image_Q2);
%SHOW PSNR
figure('name',X{6},'numbertitle','off');
x = [1 2];
PSNR_full=[PSNR_full_8_8,0];
PSNR1=[PSNR,0];
plot(x, PSNR_full, x, PSNR1);
legend('Q1', 'Q2');
xticks(x);
xticklabels({'8, 8x8','0'});
title('Q2-PSNR');

%SHOW CPU TIME
figure('name',X{7},'numbertitle','off');
x = [1 2 3 4];
time_full=[tf_8_8,tf_16_8,tf_8_16,tf_16_16];
time_2d=[t2_8_8,t2_16_8,t2_8_16,t2_16_16];
plot(x,time_full, x,time_2d);
legend('full', '2D');
xticks(x);
xticklabels({'8, 8x8', '8, 16x16', '16, 8x8', '16, 16x16'});
title('CPU TIME');


