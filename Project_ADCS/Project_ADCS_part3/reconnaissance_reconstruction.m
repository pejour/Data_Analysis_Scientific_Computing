clear;
close all;

load eigenfaces;



C = X_centre*W;



n = 10;
ecart_quadratique = 0;
for i = 1:n
    % Tirage aleatoire d'une image de test :
    numero_personne = randi(nb_personnes_base)  % randi(nb_personnes)
    numero_posture = randi(nb_postures_base)
    % si on veut tester/mettre au point, on fixe l'individu
    % personne = 1
    % posture = 3

    personne = liste_personnes_base{numero_personne};   % liste_personnes{numero_personne}
    posture = liste_postures_base{numero_posture};

    ficF = strcat('./Data/', personne, posture, '-300x400.gif')
    img_base = imread(ficF);

    % Degradation de l'image
    img_masque = img_base;
    img_masque(ligne_min:ligne_max,colonne_min:colonne_max) = 0;

    image_test = double(transpose(img_masque(:)));


    % Pourcentage d'information 
    per = 0.95;

    % Nombre N de composantes principales a prendre en compte 
    % [dans un second temps, N peut etre calcule pour atteindre le pourcentage
    % d'information avec N valeurs propres (contraste)] :
    N = 11;
    K = 1;
    ListeClass = 1:nb_postures_base*nb_personnes_base;

    c = (image_test-X_moyen)*W;

    partition = kppv(C, ListeClass, c, 1, K, ListeClass);

    % pour l'affichage (A CHANGER)
    numero_personne_proche = floor((partition-1)/nb_postures_base)+1
    numero_posture_proche = mod(partition-1,nb_postures_base)+1

    figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.8*L,0.5*H]);
    subplot(1, 2, 1);
    % Affichage de l'image de test :
    colormap gray;
    imagesc(img_masque);
    title({['Individu de test : posture ' num2str(numero_posture) ' de ', personne]}, 'FontSize', 10);
    axis image;


    ficF = strcat('./Data/', liste_personnes_base{numero_personne_proche}, liste_postures_base{numero_posture_proche}, '-300x400.gif')
    img_retrouve = imread(ficF);

    img_masque(ligne_min:ligne_max,colonne_min:colonne_max) = img_retrouve(ligne_min:ligne_max,colonne_min:colonne_max);
    
    ecart_quadratique = ecart_quadratique + sum(sum((img_masque(ligne_min:ligne_max,colonne_min:colonne_max)-img_base(ligne_min:ligne_max,colonne_min:colonne_max)).^2));

    subplot(1, 2, 2);
    imagesc(img_masque);
    title({['Individu la plus proche : posture ' num2str(numero_posture_proche) ' de ', liste_personnes_base{numero_personne_proche}]}, 'FontSize', 10);
    axis image;

end

ecart_quadratique_moyen = ecart_quadratique / n / (ligne_max-ligne_min) / (colonne_max-colonne_min);


%% Test personne dans la base mais avec posture différente 
numero_personne = 1; 
numero_posture = 5; 
personne = liste_personnes_base{numero_personne};   % liste_personnes{numero_personne}
posture = liste_postures{numero_posture};

ficF = strcat('./Data/', personne, posture, '-300x400.gif')
img_base = imread(ficF);

% Degradation de l'image
img_masque = img_base;
img_masque(ligne_min:ligne_max,colonne_min:colonne_max) = 0;

image_test = double(transpose(img_masque(:)));
 

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
imagesc(img_masque);
title({['Individu de test : posture ' num2str(numero_posture) ' de ', personne]}, 'FontSize', 10);
axis image;


ficF = strcat('./Data/', liste_personnes_base{numero_personne_proche}, liste_postures{numero_posture_proche}, '-300x400.gif')
img_retrouve = imread(ficF);

img_masque(ligne_min:ligne_max,colonne_min:colonne_max) = img_retrouve(ligne_min:ligne_max,colonne_min:colonne_max);

ficF = strcat('./Data/', liste_personnes_base{personne_proche}, liste_postures_base{posture_proche}, '-300x400.gif')
        
subplot(1, 2, 2);
imagesc(img_masque);
title({['Individu la plus proche : posture ' num2str(posture_proche) ' de ', liste_personnes_base{personne_proche}]}, 'FontSize', 10);
axis image;
saveas(gcf,"reconnaissance_recons_posture.png")

%% Test personne pas dans la base d'apprentissage
numero_personne = 9;
numero_posture = 4;

personne = liste_personnes{numero_personne};   % liste_personnes{numero_personne}
posture = liste_postures{numero_posture};

ficF = strcat('./Data/', personne, posture, '-300x400.gif')
img_base = imread(ficF);

% Degradation de l'image
img_masque = img_base;
img_masque(ligne_min:ligne_max,colonne_min:colonne_max) = 0;

image_test = double(transpose(img_masque(:)));
 

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
imagesc(img_masque);
title({['Individu de test : posture ' num2str(numero_posture) ' de ', personne]}, 'FontSize', 10);
axis image;


ficF = strcat('./Data/', liste_personnes{numero_personne_proche}, liste_postures{numero_posture_proche}, '-300x400.gif')
img_retrouve = imread(ficF);

img_masque(ligne_min:ligne_max,colonne_min:colonne_max) = img_retrouve(ligne_min:ligne_max,colonne_min:colonne_max);
        
subplot(1, 2, 2);
imagesc(img_masque);
title({['Individu la plus proche : posture ' num2str(posture_proche) ' de ', liste_personnes_base{personne_proche}]}, 'FontSize', 10);
axis image;
saveas(gcf,"reconnaissance_recons_pasbase.png")