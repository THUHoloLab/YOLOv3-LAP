function [out]=VAR(in)%�����ؽ���hologramͼ��512��512double���������
[Nx Ny]=size(in);
k=0;        
m=mean(in(:));
for ii=1:Nx
    for jj=1:Ny
        k=k+(in(ii,jj)-m)^2;
    end
end
out=k/(Nx*Ny);