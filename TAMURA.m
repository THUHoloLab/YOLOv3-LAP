function [out]=TAMURA(in)%�����ؽ���hologramͼ��512��512double���������
[Nx Ny]=size(in);
k=0;        
m=mean(in(:));
for ii=1:Nx
    for jj=1:Ny
        k=k+(in(ii,jj)-m)^2;
    end
end
var=k/(Nx*Ny);
out=(var^(1/2)/m)^1/2;
