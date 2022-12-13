function [out]=VAR(in)%输入重建的hologram图像（512×512double代表振幅）
[Nx Ny]=size(in);
k=0;        
m=mean(in(:));
for ii=1:Nx
    for jj=1:Ny
        k=k+(in(ii,jj)-m)^2;
    end
end
out=k/(Nx*Ny);