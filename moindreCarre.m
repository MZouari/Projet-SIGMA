%% Déconvolution image
% methode des moindres carrés
%%

P=33;%largeur PSF
N=256;%largeur image

%% Dégradation données (convolution +bruit)
load('data.mat') %mesure d'origine

%Synthèse PSF gaussienne
mu = [0 0];
Sigma = [10 0; 0 10]; %variance gaussienne
p=floor(P/2);
x1 = -p:1:p; x2 = -p:1:p;
k_1=floor(length(x1)/2);
[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],mu,Sigma); % calcul de psf (profil gaussien)
F=F/max(F);
psf = reshape(F,length(x1),length(x2)); 

%convolution image*psf
y=conv2(data,psf,'full');

%bruit addiftif
%SNR=input('Entrer la valeur désériée du rapport SNR :');
SNR=20;
var=sum(sum(y.^2))/(numel(y)*10^(SNR/10));
bruit=sqrt(var)*randn(size(y));
RSB=10*log10(sum(sum(y.^2))/sum(sum(bruit.^2)));
fprintf('Estimated SNR=%f\n',RSB); 
y_b = y+(bruit);
y_b=mat2gray(y_b);
y_b=y_b(17:288-16,17:288-16); % mesure bruité

%% Déconvolution 
psf_T=rot90(psf,2); 

% zero données voisinage des mesures y_b (pas de contribution des voisins)
k=floor(P/2);
y_0=padarray(y_b,[k,k]);%N+P-1

%H^T*Y
conv=conv2(psf_T,y_0,'full'); %N+2P-2

%H^T*H
psf_adap=conv2(psf,psf_T,'full');%2P-1

%zero pading psf_adap
E=zeros(N+2*P-2);
E(1:2*P-1,1:2*P-1)=psf_adap;

F=conv;

zd=fft2(F)./fft2(E);
xd=ifft2(zd);
xd=real(xd);
xd(xd<0)=0;

%% affichage données
figure
image(xd,'CDataMapping','scaled')
title('Image deconvoluée');colorbar



