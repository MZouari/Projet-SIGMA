%Prendre PSF pair
psf=H;%PSF mehdi
dim=length(psf);
mu_lass=10;
% zero padding psf
if(dim~=256)
    k=dim/2;
    psf_0=zeros(256);   
    psf_0(128-k+1,128+k)=psf;
else
    psf_0=psf;
end
dir=fft2(ones(256));    
zd=fft2(psf_0.')./(fft2(psf_0.'*psf_0)+mu_lass*dir).*fft2(y_b);
xd=ifft2(zd);
%xd=real(xd);
%xd=fftshift(xd);

%xd(xd<0)=0;
close all
figure
image(xd,'CDataMapping','scaled')
title('Deconvolué')
colorbar
figure
image(y_b,'CDataMapping','scaled')
title('Convolué')
colorbar