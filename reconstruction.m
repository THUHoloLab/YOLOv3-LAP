close all;
clear all;clc;
addpath('./Functions');
load('mydata.mat')
%o = imread('USAF.png');
%o = rgb2gray(o);
%o = imresize(o,[500,500]);
%o = 1-im2double(o);

%  diffracted field
g=imread('MO-CCD_15cm_cut.png');
%g = rgb2gray(g);
%o = imresize(o,[500,500]);
%g = s./s1; % normalized 
g = im2double(g);

% inout signal f 
%f=o;
%figure;imshow(abs(f),[],'border','tight');


%% Paprameters (1)
nx=size(g,1);  % data size
ny=size(g,2);
nz=1;
lambda=0.532;  % wavelength (um)
k = 2*pi/lambda;
detector_size=4;  % pixel pitch (um)
sensor_size=nx*detector_size;  % detector size (um)
z=1780;  % distance from detector to first reconstructed plane (um)
deltaX=detector_size;
deltaY=detector_size;
Nx=nx;
Ny=ny*nz*2;
Nz=1;

%% Propagation kernel (2)
%Phase=U1;
Phase=MyMakingPhase(nx,ny,z,lambda,deltaX,deltaY);
figure;imagesc(plotdatacube(angle(Phase)));title('Phase of kernel');axis image;drawnow;
axis off; colormap(hot); colorbar;
E0=ones(nx,ny);  % illumination light
E=MyFieldsPropagation(E0,nx,ny,nz,Phase);  % propagation of illumination light

%% Field measurement and backpropagation (3)

%  diffracted field
g=imread('MO-CCD_15cm_cut.png');
%g = rgb2gray(g);
%o = imresize(o,[500,500]);
%g = s./s1; % normalized 
g = im2double(g);
figure;imshow(abs(g),[]);title('Diffracted field')
g=MyC2V(g(:));
transf=MyAdjointOperatorPropagation(g,E,nx,ny,nz,Phase);
transf=reshape(MyV2C(transf),nx,ny,nz);
figure;imshow(plotdatacube(abs(transf)),[],'border','tight')   


%lap(ii)=LAP(rec);%用LAP来评估图像清晰度
%var(ii)=VAR(rec);%用VAR评估图像清晰度
%gra(ii)=GRA(rec);