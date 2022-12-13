function eta=MyAdjointOperatorPropagation(S,E,Nx,Ny,Nz,phase)
Nx = double(Nx);
Ny = double(Ny);
S = double(S);
S=reshape(MyV2C(S),Nx,Ny);

eta=MyAdjointPropagation(S,E,Nx,Ny,Nz,phase);

eta=MyC2V(eta(:));
