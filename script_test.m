%% syn!m:thèse PSF
H=zeros(256,256);
H(123:133,123:133)=h;
zh=fft2(H);

%% Convolution
y=imfilter(data,h);
y=mat2gray(y);

%% convolution fft
zdata=fft2(data);
zc=zdata.*zh;
y = fftshift(ifft2(zc));

%% SNR
SNR=input('Entrer la valeur désirée du rapport SNR :');
var=sum(sum(y.^2))/(numel(y)*10^(SNR/10));
bruit=sqrt(var)*randn(size(y));
RSB=10*log10(sum(sum(y.^2))/sum(sum(bruit.^2)));
fprintf('Estimated SNR=%f\n',RSB); 

y_b = y+ abs(bruit);

%% Déconvolution CLEAN for
close all
[x,res]=CLEAN_simple(y_b,h,0.3,10000);
figure
image(x,'CDataMapping','scaled')
colorbar

biais = abs(x-data);
biais = mean(biais(:));

eqm=mean(mean((x-data).^2));

str=num2str(biais);
str2=num2str(eqm);
str=strcat('biais=',str,' eqm=',str2);

title(str);
%% Deconvolution CLEAN bruit
[x,res,delta]=CLEAN_delta(y_b,h,0.1,50000);
figure
loglog(delta)
%% MCR fft
zhe=zh+ones(256)/1000;
zd=fft2(y_b)./zhe;
xd=ifft2(zd);
xd=real(xd);
xd=fftshift(xd);
xd(xd<0)=0;
close all
figure
image(xd,'CDataMapping','scaled')
title('Deconvolu�')
colorbar
figure
image(y_b,'CDataMapping','scaled')
title('Convolu�')
%marche pour des SNR de 70db...
%% MCR mat
z=fft2(y);
zx=z./zh;
test=ifft2(zx);
image(H,'CDataMapping','scaled');
% calcul mat H cf script 2
y=y(:);
x_mcr=1/(H.'*H)*H.'*y
%% Trace
close all

image(data,'CDataMapping','scaled')
colorbar
title('Original')

figure
image(y_b,'CDataMapping','scaled')
colorbar
title('Convolution+bruit')

figure
image(x,'CDataMapping','scaled')
colorbar
title('CLEAN')

figure
image(res,'CDataMapping','scaled')
colorbar
title('résidu CLEAN')

% figure
% plot(cond)
% title('variance fft résidu')

%% histo
figure
histogram(data);
title('Data')
xlim([-0.2 1.2])
figure
histogram(res);
title('Residu')
xlim([-0.2 1.2])
figure
histogram(x);
title('Clean')
xlim([-0.2 1.2])

