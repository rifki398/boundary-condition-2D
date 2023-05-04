close all;
clear;
clc;

ybawah=0; yatas=2;
xbawah=0; xatas=1;
h=1e-2;

a=1/(4*h^2);
b=-2/(4*h^2);

x=[xbawah:h:xatas];
y=[ybawah:h:yatas];

Nx=length(x);
Ny=length(y);

[M,H]=CreateMatrix(x,y,a,b,Nx,Ny);
u_sementara=M\H;

% Translate isi dari [sam] ke u(x,y)
for j=1:Ny
    for i=1:Nx
        k=(j-1)*Nx+i;
        U(i,j)=u_sementara(k);
    end
end

% Plot
surfc(y,x,U);
hcb=colorbar;
title(hcb,'u(x,y)');
xlabel('X'); ylabel('Y'); zlabel('u(x,y)')
title('∂^2u/∂x^2 + ∂^2u/∂y^2 = 4');

function [M,H]=CreateMatrix(x,y,a,b,Nx,Ny)
% untuk atas, bawah, samping nilainya diketahui
H=ones(Nx*Ny,1);
M=eye(Nx*Ny);
for j=1:Ny
    for i=1:Nx
        k=(j-1)*Nx+i;
        if j==1
            H(k,1)=x(i)^2;
        elseif i==1
            H(k,1)=y(j)^2;
        elseif i==Nx
            H(k,1)=(x(Nx)-1)^2;
        elseif j==Ny
            H(k,1)=(x(i)-2)^2;
        else
            M(k,k)=b;
            M(k,k-1)=a;
            M(k,k+1)=a;
            M(k,k-Nx)=a;
            M(k,k+Nx)=a;
        end   
    end
end
end