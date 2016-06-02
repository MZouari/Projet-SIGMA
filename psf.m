%% Synthese du reseau d'antennes 
N = 10; %Nombre d'antennes entre 0 et 100km  
Nout = 0; %Nombre d'antennes au dela de 100km
ant1 = -50*(1+1i)+100*rand(N-Nout,1)+100*1i*rand(N-Nout,1); 
ant2 = -500*(1+1i)+1000*rand(Nout,1)+1000*1i*rand(Nout,1); 
ant = [ant1; ant2];
figure 
plot(ant, 'o'); 
title('reseau d"antennes');
%% Calcul du vecteur directionnel 
L = 2.5*9.4*10e+12; %Distance entre la terre et M31
alpha = 0.25; %Angle apparent 0,5 / 2 et pas 0,5 !!!!!!!!
Np = 256; %Nombre de points du vecteur p 
ang = -alpha; %Angle vise par le vecteur p
ang2=-alpha;
p = zeros (Np,Np,3);
for j = 1: Np
    for i=1:Np
    p(j,i,1) = %f(ang,ang2)
    p(j,i,2) = %...
    p(j,i,3) = %...
    ang = ang + %... varie entre _0,25 et 0,25
    end
    ang2=ang2+%...idem
end 
%p = p / norm(p); pas bon : chaque vecteur ne p(i,j,:) ne sera pas de norme
%1, le normaliser à chaque calcul après
%% Calcul de la psf 
z = zeros(N,3); 
for i = 1: N 
    z(i, 1) = real(ant(i)); 
    z(i, 2) = imag(ant(i));
    z(i, 3) = 0;
end 
B = zeros(256); 

for k = 1 : Np 
    for h = 1 : Np
        for i = 1 : N
            for j = 1 : N
                B(k,h) = B(k,h) + exp(1i*dot((z(i,:)-z(j,:)),p(k,h,:)/norm(p(k,h,:))));
            end
        end
    end
end
B = real(B); 
figure 
image(B,'CDataMapping','scaled')
colorbar
title('PSF') 