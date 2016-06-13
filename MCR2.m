psf=B_syn;%Prendre PSF pair
psf_T=rot90(psf,2);

N=256;
P=33;

% y_b
k=(P-1)/2; 
C=padarray(y_b,[k,k]);%N+P-1

%H^T Y
conv=conv2(psf_T,C,'full'); %N+2P-2

%H^T H
psf_adap=conv2(psf,psf_T,'full');%2P-1

%fft
E=zeros(N+2*P-2);
E(1:2*P-1,1:2*P-1)=psf_adap;

% F=zeros(N+4*P-3);
% F(1:N+2*P-2,1:N+2*P-2)=conv;
F=conv;

zd=fft2(F)./fft2(E);
xd=ifft2(zd);
xd=real(xd);
%xd=fftshift(xd);
%xd(xd<0)=0;

%affichage
close all
% image(psf,'CDataMapping','scaled')
% title('PSF');colorbar
% figure
% image(y_b,'CDataMapping','scaled')
% title('Convolué');colorbar
% figure
image(xd,'CDataMapping','scaled')
title('Deconvolué');colorbar
