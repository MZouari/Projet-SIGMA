% utiliser matrice B carré de longeur impaire

function [I_clean,A,delta] = CLEAN_delta(I_d,B,gamma,iter)
B_0=B(floor(numel(B)/2)+1);
dim=size(I_d);
k=floor(length(B)/2);

mu = [0 0];
Sigma = [1 0; 0 1];
x1 = -5:1:5; x2 = -5:1:5;
k_1=floor(length(x1)/2);
[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],mu,Sigma); % calcul de B_syn (profil gaussien)
F=F/max(F);
B_syn = reshape(F,length(x1),length(x2)); 

I_clean = zeros(length(I_d)+k_1*2);
A=zeros(length(I_d)+k_1*2);
A(k_1+1:k_1+dim(1),k_1+1:k_1+dim(1))=I_d;
dimA=size(A);

v=0;v2=0;
D=zeros(iter,1);
for i=1:iter
    v=v2;
    [M,p] = max(A(:));
    if(M==0) 
        break
    end
    var= M/B_0;
    [x,y]=ind2sub(dimA,p);

    A(x-k:x+k,y-k:y+k)=A(x-k:x+k,y-k:y+k)-gamma*var*B;  % Maj I_d
    A(x-k:x+k,y-k:y+k)=max(A(x-k:x+k,y-k:y+k),0);
        
    I_clean(x-k_1:x+k_1,y-k_1:y+k_1)=I_clean(x-k_1:x+k_1,y-k_1:y+k_1)+ ...
       gamma*var*B_syn;%moins aberant : lobe gaussien 
    v2=var(A);
    delta(i)=abs(v-v2)
end
I_clean=I_clean(k_1+1:k_1+dim(1),k_1+1:k_1+dim(1));
A=A(k_1+1:k_1+dim(1),k_1+1:k_1+dim(1));
end



