clear all; close all; clc; 
addpath('data');
topVInd = [ 1 2 3 4 5 6 7 ];
botVInd = [ 8 9 10 11 12 13 14 ];


%% Read OBJ file
obj = readObj('trump.obj');
tval = display_obj(obj,'tumpLPcolors.png');
vertex = obj.v;
faces = obj.f.v;
colors = tval;


%% Move the Center of OBJ to (0, 0, 0)
center = [(max(vertex(:, 1))+min(vertex(:, 1)))/2, (max(vertex(:, 2))+min(vertex(:, 2)))/2, (max(vertex(:, 3))+min(vertex(:, 3)))/2];
model_vertex(:, 1)=vertex(:, 1)-center(1);
model_vertex(:, 2)=vertex(:, 2)-center(2);
model_vertex(:, 3)=vertex(:, 3)-center(3);

%% Generate a HSV Hexagonal Prism onto the same world space as trump.obj, and then do some transformation
% (Hint) You can try to combine 2 objects' vertices, faces, colors together

vertsCos=cosd(30);
vertsSin=sind(30);

topVs = [ vertsSin 1 vertsCos ;0 1 0; -vertsSin 1 vertsCos; 0 1 vertsCos*2; 1 1 vertsCos*2; 1.5 1 vertsCos; 1 1 0 ]; 
botVs = [vertsSin 0 vertsCos ;  0 0 0; -vertsSin 0 vertsCos; 0 0 vertsCos*2; 1 0 vertsCos*2; 1.5 0 vertsCos; 1 0 0];

numVert = 6;
%top
hf = [];
f1 = topVInd(1);
f2 = topVInd(2);
f3 = topVInd(3);    
hf = [ hf ; f1 f2 f3 ]; 
f1 = topVInd(1);
f2 = topVInd(3);
f3 = topVInd(4);   
hf = [ hf ; f1 f2 f3 ]; 
f1 = topVInd(1);
f2 = topVInd(4);
f3 = topVInd(5);   
hf = [ hf ; f1 f2 f3 ]; 
f1 = topVInd(1);
f2 = topVInd(5);
f3 = topVInd(6);    
hf = [ hf ; f1 f2 f3 ]; 
f1 = topVInd(1);
f2 = topVInd(6);
f3 = topVInd(7);    
hf = [ hf ; f1 f2 f3 ]; 
hf = [ hf ; f1 f2 f3 ]; 
f1 = topVInd(1);
f2 = topVInd(7);
f3 = topVInd(2);   
hf = [ hf ; f1 f2 f3 ]; 
hf = [ hf ; f1 f2 f3 ]; 


%side 
f1 = topVInd(2);
f2 = topVInd(3);
f3 = botVInd(3);    
f4 = botVInd(2);
hf = [ hf ; f1 f2 f3 ];    
hf = [ hf ; f1 f3 f4 ];

f1 = topVInd(3);
f2 = topVInd(4);
f3 = botVInd(4);    
f4 = botVInd(3);
hf = [ hf ; f1 f2 f3 ];    
hf = [ hf ; f1 f3 f4 ];

f1 = topVInd(4);
f2 = topVInd(5);
f3 = botVInd(5);    
f4 = botVInd(4);
hf = [ hf ; f1 f2 f3 ];    
hf = [ hf ; f1 f3 f4 ];

f1 = topVInd(5);
f2 = topVInd(6);
f3 = botVInd(6);    
f4 = botVInd(5);
hf = [ hf ; f1 f2 f3 ];    
hf = [ hf ; f1 f3 f4 ];

f1 = topVInd(6);
f2 = topVInd(7);
f3 = botVInd(7);    
f4 = botVInd(6);
hf = [ hf ; f1 f2 f3 ];    
hf = [ hf ; f1 f3 f4 ];

f1 = topVInd(7);
f2 = topVInd(2);
f3 = botVInd(2);    
f4 = botVInd(7);
hf = [ hf ; f1 f2 f3 ];    
hf = [ hf ; f1 f3 f4 ];
 
%Bottom 
f1 = botVInd(1);
f2 = botVInd(2);
f3 = botVInd(3);    
hf = [ hf ; f1 f2 f3 ];   

f1 = botVInd(1);
f2 = botVInd(3);
f3 = botVInd(4);    
hf = [ hf ; f1 f2 f3 ];   

f1 = botVInd(1);
f2 = botVInd(4);
f3 = botVInd(5);    
hf = [ hf ; f1 f2 f3 ];   

f1 = botVInd(1);
f2 = botVInd(5);
f3 = botVInd(6);    
hf = [ hf ; f1 f2 f3 ];   

f1 = botVInd(1);
f2 = botVInd(6);
f3 = botVInd(7);    
hf = [ hf ; f1 f2 f3 ];   

f1 = botVInd(1);
f2 = botVInd(7);
f3 = botVInd(2);    
hf = [ hf ; f1 f2 f3 ];   

verts = [ topVs; botVs ];
%------------------------------------------------------------------------------------------------------
%hsv
Angle=linspace(0,2*pi,numVert+1)';
topColor=[0,0,1]; 
botColor=[0,0,0]; 
for i=1:numVert
     topColor=[topColor;Angle(i)/(2*pi),1,1]; 
     botColor=[botColor;Angle(i)/(2*pi),1,0]; 
 end     
 vertColors = [ topColor; botColor ]; 
 vertColors_final=hsv2rgb(vertColors); 

%shift to (0, -1.4, 0) 
cen= [(max(verts(:, 1))+min(verts(:, 1)))/2, (max(verts(:, 2))+min(verts(:, 2)))/2, (max(verts(:, 3))+min(verts(:, 3)))/2];
v(:, 1)=verts(:, 1)-cen(1);
v(:, 2)=verts(:, 2)-cen(2)-1.4;
v(:, 3)=verts(:, 3)-cen(3);

trisurf(hf,v(:,1),v(:,2),v(:,3),'FaceVertexCData', vertColors_final,'FaceColor','interp', 'EdgeAlpha', 0);
xlabel('X'); ylabel('Y'); zlabel('Z');


%combine 
s=size(tval);
figure;
model = [model_vertex; v];
f = [faces;hf+s(1)];
c = [colors; vertColors_final];
trisurf(f,model(:,1),model(:,2),model(:,3),'FaceVertexCData', c,'FaceColor','interp', 'EdgeAlpha', 0);
xlabel('X'); ylabel('Y'); zlabel('Z');
title('(2d) result');


%% Lighting (You may need to modify the lighting here)
figure;
direction = light('Position',[0.0,0.0,5.0]);
lighting phong;
trisurf(f,model(:,1),model(:,2),model(:,3),'FaceVertexCData', c,'FaceColor','interp', 'EdgeAlpha', 0);
xlabel('X'); ylabel('Y'); zlabel('Z');
title('direction light');

%----------------------------------------------
figure;
trisurf(f,model(:,1),model(:,2),model(:,3),'FaceVertexCData', c,'FaceColor','interp', 'EdgeAlpha', 0);
light('Position',[3.0,0.0,2.0],'Style','local');
xlabel('X'); ylabel('Y'); zlabel('Z');
title('position-light');
%----------------------------------------------------------
%I. (ka , kd , ks) = (1.0, 0.0, 0.0)
figure;
trisurf(f,model(:,1),model(:,2),model(:,3),'FaceVertexCData', c,'FaceColor','interp', 'EdgeAlpha', 0,'AmbientStrength',1.0,'DiffuseStrength',0.0,'SpecularStrength',0.0);
light('Position',[0.0,0.0,4.0],'Style','local');
xlabel('X'); ylabel('Y'); zlabel('Z');
title('I. (ka , kd , ks) = (1.0, 0.0, 0.0)');
%II. (ka , kd , ks) = (0.1, 1.0, 0.0)
figure;
trisurf(f,model(:,1),model(:,2),model(:,3),'FaceVertexCData', c,'FaceColor','interp', 'EdgeAlpha', 0,'AmbientStrength',0.1,'DiffuseStrength',1.0,'SpecularStrength',0.0);
light('Position',[0.0,0.0,4.0],'Style','local');
xlabel('X'); ylabel('Y'); zlabel('Z');
title('II. (ka , kd , ks) = (0.1, 1.0, 0.0)');
%III. (ka , kd , ks) = (0.1, 0.1, 1.0)
figure;
trisurf(f,model(:,1),model(:,2),model(:,3),'FaceVertexCData', c,'FaceColor','interp', 'EdgeAlpha', 0,'AmbientStrength',0.1,'DiffuseStrength',0.1,'SpecularStrength',1.0);
light('Position',[0.0,0.0,4.0],'Style','local');
xlabel('X'); ylabel('Y'); zlabel('Z');
title('III. (ka , kd , ks) = (0.1, 0.1, 1.0)');
%IV. (ka , kd , ks) = (0.1, 0.8, 1.0)
figure;
trisurf(f,model(:,1),model(:,2),model(:,3),'FaceVertexCData', c,'FaceColor','interp', 'EdgeAlpha', 0,'AmbientStrength',0.1,'DiffuseStrength',0.8,'SpecularStrength',1.0);
light('Position',[0.0,0.0,4.0],'Style','local');
xlabel('X'); ylabel('Y'); zlabel('Z');
title('IV. (ka , kd , ks) = (0.1, 0.8, 1.0)');

%% Lighting (You may need to modify the lighting here)
%light('Position',[0.0,0.0,5.0]);
%lighting phong;