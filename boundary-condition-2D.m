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
sam=M\H;

% Translate isi dari [sam] ke u(x,y)
for j=1:Ny
    for i=1:Nx
        k=(j-1)*Nx+i;
        sol(j,i)=sam(k);
    end
end

% Plot
surfc(x,y,sol);
hcb=colorbar;
title(hcb,'u(x,y)');
xlabel('X'); ylabel('Y'); zlabel('u(x,y)')
title('∂^2u/∂x^2 + ∂^2u/∂y^2 = 4');

function [A,B]=CreateMatrix(x,y,a,b,Nx,Ny)
% untuk atas, bawah, samping nilainya diketahui
B=zeros(Nx*Ny,1);
A=eye(Nx*Ny);
for j=1:Ny
    for i=1:Nx
        k=(j-1)*Nx+i;
        if j==1
            B(k,1)=x(i)^2;
        elseif i==1
            B(k,1)=y(j)^2;
        elseif i==Nx
            B(k,1)=(x(Nx)-1)^2;
        elseif j==Ny
            B(k,1)=(x(Nx)-2)^2;
        else
            A(k,k)=b;
            A(k,k-1)=a;
            A(k,k+1)=a;
            A(k,k-Nx)=a;
            A(k,k+Nx)=a;
        end   
    end
end
end