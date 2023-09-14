clear;
close all;

load eigenfaces;

% Tirage aleatoire d'une image de test :
personne = randi(nb_personnes_base)
posture = randi(nb_postures_base)
% si on veut tester/mettre au point, on fixe l'individu
% personne = 1
% posture = 3

ficF = strcat('./Data/', liste_personnes_base{personne}, liste_postures_base{posture}, '-300x400.gif')
img = imread(ficF);
image_test = double(transpose(img(:)));
 

% Pourcentage d'information 
per = 0.95;

% Nombre N de composantes principales a prendre en compte 
% [dans un second temps, N peut etre calcule pour atteindre le pourcentage
% d'information avec N valeurs propres (contraste)] :
N = 11;     % calculé d'après l'inertie
K = 1;
ListeClass = 1:nb_postures_base*nb_personnes_base;

C = X_centre*W;
c = (image_test-X_moyen)*W;


partition = kppv(C, ListeClass, c, 1, K, ListeClass);

% pour l'affichage (A CHANGER)
personne_proche = floor((partition-1)/nb_postures_base)+1
posture_proche = mod(partition-1,nb_postures_base)+1

figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.8*L,0.5*H]);

subplot(1, 2, 1);
% Affichage de l'image de test :
colormap gray;
imagesc(img);
title({['Individu de test : posture ' num2str(posture) ' de ', liste_personnes_base{personne}]}, 'FontSize', 10);
axis image;


ficF = strcat('./Data/', liste_personnes_base{personne_proche}, liste_postures_base{posture_proche}, '-300x400.gif')
img = imread(ficF);
        
subplot(1, 2, 2);
imagesc(img);
title({['Individu la plus proche : posture ' num2str(posture_proche) ' de ', liste_personnes_base{personne_proche}]}, 'FontSize', 10);
axis image;
saveas(gcf,"reconnaissance_sans_masque.png")

%% Test personne dans la base mais avec posture différente 
personne = 1
posture = 5

ficF = strcat('./Data/', liste_personnes{personne}, liste_postures{posture}, '-300x400.gif')
img = imread(ficF);
image_test = double(transpose(img(:)));
 

% Pourcentage d'information 
per = 0.95;

% Nombre N de composantes principales a prendre en compte 
% [dans un second temps, N peut etre calcule pour atteindre le pourcentage
% d'information avec N valeurs propres (contraste)] :
N = 11;     % calculé d'après l'inertie
K = 1;
ListeClass = 1:nb_postures_base*nb_personnes_base;

C = X_centre*W;
c = (image_test-X_moyen)*W;


partition = kppv(C, ListeClass, c, 1, K, ListeClass);

% pour l'affichage (A CHANGER)
personne_proche = floor((partition-1)/nb_postures_base)+1
posture_proche = mod(partition-1,nb_postures_base)+1

figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.8*L,0.5*H]);

subplot(1, 2, 1);
% Affichage de l'image de test :
colormap gray;
imagesc(img);
title({['Individu de test : posture ' num2str(posture) ' de ', liste_personnes_base{personne}]}, 'FontSize', 10);
axis image;


ficF = strcat('./Data/', liste_personnes_base{personne_proche}, liste_postures_base{posture_proche}, '-300x400.gif')
img = imread(ficF);
        
subplot(1, 2, 2);
imagesc(img);
title({['Individu la plus proche : posture ' num2str(posture_proche) ' de ', liste_personnes_base{personne_proche}]}, 'FontSize', 10);
axis image;
saveas(gcf,"reconnaissance_sans_masque_posture.png")

%% Test personne pas dans la base d'apprentissage
personne = 5
posture = 4

ficF = strcat('./Data/', liste_personnes{personne}, liste_postures{posture}, '-300x400.gif')
img = imread(ficF);
image_test = double(transpose(img(:)));
 

% Pourcentage d'information 
per = 0.95;

% Nombre N de composantes principales a prendre en compte 
% [dans un second temps, N peut etre calcule pour atteindre le pourcentage
% d'information avec N valeurs propres (contraste)] :
N = 11;     % calculé d'après l'inertie
K = 1;
ListeClass = 1:nb_postures_base*nb_personnes_base;

C = X_centre*W;
c = (image_test-X_moyen)*W;


partition = kppv(C, ListeClass, c, 1, K, ListeClass);

% pour l'affichage (A CHANGER)
personne_proche = floor((partition-1)/nb_postures_base)+1
posture_proche = mod(partition-1,nb_postures_base)+1

figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.8*L,0.5*H]);

subplot(1, 2, 1);
% Affichage de l'image de test :
colormap gray;
imagesc(img);
title({['Individu de test : posture ' num2str(posture) ' de ', liste_personnes{personne}]}, 'FontSize', 10);
axis image;


ficF = strcat('./Data/', liste_personnes_base{personne_proche}, liste_postures_base{posture_proche}, '-300x400.gif')
img = imread(ficF);
        
subplot(1, 2, 2);
imagesc(img);
title({['Individu la plus proche : posture ' num2str(posture_proche) ' de ', liste_personnes_base{personne_proche}]}, 'FontSize', 10);
axis image;
saveas(gcf,"reconnaissance_sans_masque_pasbase.png")