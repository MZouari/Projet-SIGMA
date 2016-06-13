P=33;%largeur PSF
p=floor(P/2);
mu = [0 0];
Sigma = [10 0; 0 10];
x1 = -p:1:p; x2 = -p:1:p;
k_1=floor(length(x1)/2);
[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],mu,Sigma); % calcul de B_syn (profil gaussien)
F=F/max(F);
B_syn = reshape(F,length(x1),length(x2)); 
%B_syn = reshape(F,length(x1),length(x2)); 

figure
mesh(B_syn)