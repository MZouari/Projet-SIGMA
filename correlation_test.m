%% critère 
biais = abs(x-y);
biais = mean(biais(:));



%% correlation residu
b=randn(256);
r = xcorr2(b);

r_2=xcorr2(data);

image(r_2,'CDataMapping','scaled')
colorbar

close all
figure
z=fft2(res);
image(log(abs(z)),'CDataMapping','scaled')
colorbar
title('fft residu')
figure
z_d=fft2(data);
image(log(abs(z_d)),'CDataMapping','scaled')
colorbar
title('fft data')

figure
v=filter([1 1],1,b);
plot(v)

% (egalisation histogramme), (valeurs faible amplitude)
% correlation2d non trop lourd
% blanchiment fft ? régularité fftn
% idée => moyenne et variance histogramme 

plot(e)
title('Evolution de l entropie du residu')

%% idée fft 

z=abs(fft2(res));
zlog10=log10(z);
zd=abs(fft2(data));
zd=log10(zd);
figure
image(bf,'CDataMapping','scaled')
colorbar
title('fft data')

var=mean((z(:)-mean(z(:))).^2)
varlog=mean((zlog10(:)-mean(z(:))).^2)

bf=abs(fft2(b));
bf=log10(bf);
var=mean((bf(:)-mean(bf(:))).^2)
