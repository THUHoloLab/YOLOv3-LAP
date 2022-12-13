function [out]=RC(in)%�����ؽ���hologramͼ��512��512double���������
[Nx Ny]=size(in);
k1=0;
k2=0;
c=real(in);
m1=mean(c(:));
d=imag(in);
m2=mean(d(:));
for ii=1:Nx
    for jj=1:Ny
        k1=k1+(c(ii,jj)-m1)^2;
        k2=k2+(d(ii,jj)-m2)^2;
    end
end

out=k1/k2;