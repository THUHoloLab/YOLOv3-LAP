function [out]=GRA(in)%输入重建的hologram图像（512×512double代表振幅）
[Nx Ny]=size(in);
k=0;        
for ii=2:Nx
    for jj=2:Ny
        k=k+((in(ii,jj)-in(ii-1,jj))^2+(in(ii,jj)-in(ii,jj-1))^2)^(1/2);
    end
end
out=k;