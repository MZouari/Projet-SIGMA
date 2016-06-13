%% Synthese du reseau d'antennes 
N = 80; %Nombre d'antennes entre 0 et 100km  
Nout = 40; %Nombre d'antennes au dela de 100k
ant1 = -50*(1+1i)+100*rand(N-Nout,1)+100*1i*rand(N-Nout,1); 
ant2 = -500*(1+1i)+1000*rand(Nout,1)+1000*1i*rand(Nout,1); 
ant = [ant1; ant2];
figure 
plot(ant, 'o'); 
title('reseau d"antennes');
%% Calcul du vecteur directionnel 
L = 2.5*9.4*10e+12; %Distance entre la terre et M31
alpha = 0.25; %Angle apparent 
Np = 256; %Nombre de points du vecteur p 
ang_vert = linspace(-0.25,0.25,256);
ang_hor = linspace(-0.25,0.25,256); 
p = zeros (Np,Np,3);
for j = 1: Np
    for k = 1 : Np
        p(k,j,1) = L*tan(ang_hor(j));
        p(k,j,2) = L*tan(ang_vert(k)); 
        p(k,j,3) = sqrt(L^2+p(k,j,1)^2+p(k,j,2)^2);
        p(k,j,:) = p(k,j,:)/sqrt(L^2+p(k,j,1)^2+p(k,j,2)^2);
    end
end
%% Calcul de la psf 
z = zeros(N,3); 
c = 3*10e+08; %Vitesse de la lumière
f = 10*10e+07; %Fréquence d'émission
for i = 1: N 
    z(i, 1) = real(ant(i)); 
    z(i, 2) = imag(ant(i));
    z(i, 3) = 0;
end 
z = (2*pi*f/c)*z; 
B = zeros(256); 

for k = 1 : Np 
    for m = 1 : Np
        for i = 1 : N
            for j = 1 : N
                B(k,m) = B(k,m) + exp(1i*(((z(i,1)-z(j,1))*p(k,m,1))+...
                ((z(i,2)-z(j,2))*p(k,m,2)))/(sqrt(p(k,m,1)^2+p(k,m,2)^2)...
                +p(k,m,3)^2));
            end
        end
    end
end
B = real(B); 
figure 
image(B,'CDataMapping','scaled')
colorbar
title('PSF')
