%% Convolution
y=imfilter(data,h);
y=mat2gray(y);

%% SNR
SNR=input('Entrer la valeur desiree du rapport SNR :');
var=sum(sum(y.^2))/(numel(y)*10^(SNR/10));
bruit=sqrt(var)*randn(size(y));
RSB=10*log10(sum(sum(y.^2))/sum(sum(bruit.^2)));
fprintf('Estimated SNR=%f\n',RSB); 
y_b = y+ abs(bruit);

%% Deconvolution
[x,res]=CLEAN_simple(y_b,h,0.3,10000);

%% moindre carres
%H= ;
%y=y(:);
%x_mcr=1/(H.'*H)*H.'*y
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
title('residu CLEAN')
% figure
% plot(cond)
% title('variance fft residu')

%% histo
figure
hist(data);
title('Data')
xlim([-0.2 1.2])
figure
hist(res);
title('Residu')
xlim([-0.2 1.2])
figure
hist(x);
title('Clean')
xlim([-0.2 1.2])

