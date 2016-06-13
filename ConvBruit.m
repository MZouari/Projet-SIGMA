%% Script Convolution +bruit
% 
%%
P=33;%largeur psf

load('data.mat')
y=conv2(data,B_syn,'full');
% SNR
SNR=input('Entrer la valeur désériée du rapport SNR :');
var=sum(sum(y.^2))/(numel(y)*10^(SNR/10));
bruit=sqrt(var)*randn(size(y));
RSB=10*log10(sum(sum(y.^2))/sum(sum(bruit.^2)));
fprintf('Estimated SNR=%f\n',RSB); 
y_b = y+(bruit);
% affichage
y_b=mat2gray(y_b);

y_b=y_b(p+1:288-p,p+1:288-p);

figure
image(y_b,'CDataMapping','scaled')
colorbar;title('Convolution+bruit');

