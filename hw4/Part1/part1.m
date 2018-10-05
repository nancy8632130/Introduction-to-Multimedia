clear all; close all; clc;

rbImage = im2double(imread('img.png'));
[h, w, ~] = size(rbImage);
imshow(rbImage);
X = {'part1-a','part1-b-original','part1-b-scaling'};

%% Mouse input
xlabel ('Select at most 36 points along the outline', 'FontName', '微軟正黑體', 'FontSize', 14);
[ ctrlPointX, ctrlPointY ] = ginput(36);
ctrlPointList_36 = [ctrlPointX ctrlPointY];
clicked_N_36 = size(ctrlPointList_36,1);

promptStr = sprintf('%d points selected', clicked_N_36);
xlabel (promptStr, 'FontName', '微軟正黑體', 'FontSize', 14);

%------------------------------------------------------
xlabel ('Select at most 72 points along the outline', 'FontName', '微軟正黑體', 'FontSize', 14);
[ ctrlPointX, ctrlPointY ] = ginput(72);
ctrlPointList_72 = [ctrlPointX ctrlPointY];
clicked_N_72 = size(ctrlPointList_72,1);

promptStr = sprintf('%d points selected', clicked_N_72);
xlabel (promptStr, 'FontName', '微軟正黑體', 'FontSize', 14);

%% Calculate Bazier Curve (Your efforts here)
%rate=36
LoD_low=0.2; 
LoD_high=0.01;
outlineVertexList36_low=ComputeBezier(ctrlPointList_36, clicked_N_36, LoD_low,1); 
outlineVertexList36_high=ComputeBezier(ctrlPointList_36,clicked_N_36,LoD_high,1); 

%rate=72
outlineVertexList72_low=ComputeBezier(ctrlPointList_72, clicked_N_72, LoD_low,1); 
outlineVertexList72_high=ComputeBezier(ctrlPointList_72,clicked_N_72,LoD_high,1); 

%% Draw and fill the polygon  Last 3 input arguments: (ctrlPointScattered, polygonPlotted, filled)
%figure; result = drawAndFillPolygon( rbImage, ctrlPointList, outlineVertexList, true, true, true );
%imwrite(result, 'result.png');

figure('name',X{1},'numbertitle','off');
subplot(2, 2, 1);
result36_low=drawAndFillPolygon(rbImage,ctrlPointList_36,outlineVertexList36_low,true,true,true);
title('sampling rate=36,level=Low'); 

subplot(2, 2, 2);
result36_high= drawAndFillPolygon(rbImage,ctrlPointList_36,outlineVertexList36_high,true,true,true);
title('sampling rate=36,level=High'); 

subplot(2, 2, 3);
result72_low=drawAndFillPolygon(rbImage,ctrlPointList_72,outlineVertexList72_low,true,true,true);
title('sampling rate=72,level=Low'); 

subplot(2, 2, 4);
result72_high= drawAndFillPolygon(rbImage,ctrlPointList_72,outlineVertexList72_high,true,true,true);
title('sampling rate=72,level=High'); 

imwrite(result36_low,'result_SamplingRate_36_low.png');
imwrite(result36_high,'result_SamplingRate_36_high.png');

imwrite(result72_low,'result_SamplingRate_72_low.png');
imwrite(result72_high,'result_SamplingRate_72_high.png');

%scaling
figure('name',X{2},'numbertitle','off');
result_high= drawAndFillPolygon(rbImage,ctrlPointList_72,outlineVertexList72_high,true,true,true);

result_scaling=imresize(result72_high, 4, 'nearest');
 for i = 1 :clicked_N_72
        ctrlPointList_72(i,1)=4*ctrlPointList_72(i,1);
        ctrlPointList_72(i,2)=4*ctrlPointList_72(i,2);
 end
 outlineVertexList_s=ComputeBezier(ctrlPointList_72,clicked_N_72,LoD_high,1);
 figure('name',X{3},'numbertitle','off');
 result_s= drawAndFillPolygon(result_scaling,ctrlPointList_72,outlineVertexList_s,true,true,true);
    
 imwrite(result_s, 'partb_scaling_result_SamplingRate_72_high.png');
