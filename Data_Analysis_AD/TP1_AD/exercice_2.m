clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Separation des canaux RVB','Position',[0,0,0.67*L,0.67*H]);
figure('Name','Nuage de pixels dans le repere RVB','Position',[0.67*L,0,0.33*L,0.45*H]);

% Lecture et affichage d'une image RVB :
I = imread('ishihara-6.png');
figure(1);				% Premiere fenetre d'affichage
subplot(2,2,1);				% La fenetre comporte 2 lignes et 2 colonnes
imagesc(I);
axis off;
axis equal;
title('Image RVB','FontSize',20);

% Decoupage de l'image en trois canaux et conversion en doubles :
R = double(I(:,:,1));
V = double(I(:,:,2));
B = double(I(:,:,3));

% Affichage du canal R :
colormap gray;				% Pour afficher les images en niveaux de gris
subplot(2,2,2);
imagesc(R);
axis off;
axis equal;
title('Canal R','FontSize',20);

% Affichage du canal V :
subplot(2,2,3);
imagesc(V);
axis off;
axis equal;
title('Canal V','FontSize',20);

% Affichage du canal B :
subplot(2,2,4);
imagesc(B);
axis off;
axis equal;
title('Canal B','FontSize',20);

% Affichage du nuage de pixels dans le repere RVB :
figure(2);				% Deuxieme fenetre d'affichage
plot3(R,V,B,'b.');
axis equal;
xlabel('R');
ylabel('V');
zlabel('B');
rotate3d;

% Matrice des donnees :
X = [R(:) V(:) B(:)];			% Les trois canaux sont vectorises et concatenes

% Matrice de variance/covariance :

Xc = X - mean(X,2);      % matrice centrée
n = length(R);
sigma = (Xc'*Xc)/n;

% Coefficients de correlation lineaire :

Rxy = sigma(1,2)/(sqrt(sigma(1,1)*sigma(2,2)));
Ryz = sigma(2,3)/(sqrt(sigma(3,3)*sigma(2,2)));
Rxz = sigma(1,3)/(sqrt(sigma(1,1)*sigma(3,3)));

% Proportions de contraste :

Cr = sigma(1,1)/(sigma(1,1) + sigma(2,2) + sigma(3,3));
Cv = sigma(2,2)/(sigma(1,1) + sigma(2,2) + sigma(3,3));
Cb = sigma(3,3)/(sigma(1,1) + sigma(2,2) + sigma(3,3));

fprintf('Rxy = %3f\nRyz = %3f\nRxz = %3f\nCr = %3f\nCv = %3f\nCb = %3f\n',Rxy,Ryz,Rxz,Cr,Cv,Cb)

% Calcul des valeurs propres et des vecteurs propres

[W,D] = eig(sigma);
[valprop,indices] = sort(diag(D), 'descend');
W_tri = W(:,indices);
C = X*W_tri;
C_bis = reshape(C,size(I));

figure()
imagesc(C_bis)


% Nouvelle matrice de covariance :

Cc = C - mean(C,2);      % matrice centrée
sigma_ = (Cc'*Cc)/n;


% Nouveaux coefficients de correlation lineaire :

Rxy_ = sigma_(1,2)/(sqrt(sigma_(1,1)*sigma_(2,2)));
Ryz_ = sigma_(2,3)/(sqrt(sigma_(3,3)*sigma_(2,2)));
Rxz_ = sigma_(1,3)/(sqrt(sigma_(1,1)*sigma_(3,3)));

% Proportions de contraste :

Cr_ = sigma_(1,1)/(sigma_(1,1) + sigma_(2,2) + sigma_(3,3));
Cv_ = sigma_(2,2)/(sigma_(1,1) + sigma_(2,2) + sigma_(3,3));
Cb_ = sigma_(3,3)/(sigma_(1,1) + sigma_(2,2) + sigma_(3,3));

fprintf('Rxy_ = %3f\nRyz_ = %3f\nRxz_ = %3f\nCr_ = %3f\nCv_ = %3f\nCb_ = %3f\n',Rxy_,Ryz_,Rxz_,Cr_,Cv_,Cb_)
