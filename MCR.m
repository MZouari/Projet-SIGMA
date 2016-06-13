psf=B_syn;%Prendre PSF pair

% dim=length(psf);
% if(dim~=256) %zero padding psf
%     k=dim/2;
%     psf_0=zeros(256);   
%     psf_0(128-k+1,128+k+1)=psf;
%     psf=psf_0;  
% end    

psf_T=rot90(psf,2);

% % calcul HHT
% zadap=fft2(psf).*fft2(psf_T);
% psf_adap=ifft2(zadap);
% psf_adap=fftshift(psf_adap);

%calcul HHT
%psf_adap=conv2(psf_T,psf,'full');

%HHT zero-padd
% A=zeros(512);
% A(1:256,1:256)=psf;
% B=zeros(512);
% B(1:256,1:256)=psf_T;
% zadap=fft2(A).*fft2(B);
% psf_adap=ifft2(zadap);
% %psf_adap=fftshift(psf_adap);

N=256;
P=33;

% y_b
k=(P-1)/2; 
C=padarray(y_b,[k,k]);

%H^T Y

conv=conv2(psf_T,C,'full'); 
% D=zeros(512);
% D(1:k,1:k)=conv;

%H^T H
psf_adap=conv2(psf,psf_T,'full');
E=zeros(N+2*P-2);
E(1:2*P-1,1:2*P-1)=psf_adap;

%
zd=fft2(conv)./fft2(E);
xd=ifft2(zd);

% zd=fft2(A)./(fft2(psf_adap)+ones(512)/100000).*fft2(C);
% %zd=fft2(psf_T)./(fft2(psf_T*psf)+ones(256)/100000).*fft2(y_b);
% xd=ifft2(zd);
xd=real(xd);
%xd=fftshift(xd);
%xd(xd<0)=0;

close all
image(psf,'CDataMapping','scaled')
title('PSF');colorbar
figure
image(y_b,'CDataMapping','scaled')
title('Convolué');colorbar
figure
image(xd,'CDataMapping','scaled')
title('Deconvolué');colorbar
