%clc

%image = USAF;
function out = gaussian_pulse(image)

%image = double(reshape(image,length(image),length(image)));
g = im2double(image);
z_start=800;%start source-to-sample distance in meter
z_end=2848;%end source-to-sample distance in meter
z_step=128;%step source-to-sample distance in meter
S=round(2048/z_step);
nx=size(g,1) ; % data size
ny=size(g,2);
nz=1;
lambda=0.532;  % wavelength (um)
k = 2*pi/lambda;
detector_size=5;  % pixel pitch (um)
sensor_size=nx*detector_size;  % detector size (um)
%z=1780;  % distance from detector to first reconstructed plane (um)
deltaX=detector_size;
deltaY=detector_size;
Nx=nx;
Ny=ny*nz*2;
Nz=1;
%figure;imshow(abs(g),[]);title('Diffracted field')
%% Propagation kernel (2)
%Phase=U1;
maxlistense = z_start;
LAP_max = 0;
VAR_max = 0;
for ii=1:S
    z=z_start + ii*z_step;
    
Phase=MyMakingPhase(nx,ny,z,lambda,deltaX,deltaY);
E0=ones(nx,ny);  % illumination light
E=MyFieldsPropagation(E0,nx,ny,nz,Phase) ; % propagation of illumination light
k=MyC2V(g(:));
transf=MyAdjointOperatorPropagation(k,E,nx,ny,nz,Phase);
transf=reshape(MyV2C(transf),nx,ny,nz);
figure;
imshow(plotdatacube(abs(transf)),[],'border','tight')

if (LAP(abs(transf)) > LAP_max)
    LAP_max = LAP(abs(transf));
    maxlistense =  z;
end
lap(ii)=LAP(abs(transf));
%var(ii)=VAR(abs(transf));
pause(0.5);
transf=0;
end
out = maxlistense;

%{
MappedData1 = mapminmax(lap,0,1); %Normalized distribution
%MappedData2 = mapminmax(var,0,1);
tt=linspace(z_start+z_step,z_end,S);
%xx=[z_start:100:z_end+z_step];
%yy=spline(tt,MappedData1,xx);
plot(tt,MappedData1,'r','Linewidth',3);
xlabel('reconstruction distance');
ylabel('focus value');%Draw the curve of autofocusing metric
%[c,d]=max(MappedData1);% Find extreme points
%filename_d=['./VOCdevkit/MID_IMG/',"1_",'.txt'];
dlmwrite("1.txt",MappedData1,'delimiter','\t');
%}
end