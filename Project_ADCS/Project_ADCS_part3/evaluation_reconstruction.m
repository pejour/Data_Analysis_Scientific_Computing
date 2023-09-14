clear all;
close all;

%%%%%%%% CHOIX DES DONNEES
%%%%%%%%%%%%%%%%%%%%%%%%%%

% liste des differentes personnes
liste_personnes = {
 'f01', 'f02', 'f03', 'f04', 'f05', 'f06', 'f07', 'f08', 'f09', 'f10', 'f11', 'f12', 'f13', 'f14', 'f15', 'f16', 'm01', 'm02', 'm03', 'm04', 'm05', 'm06', 'm07', 'm08', 'm09', 'm10', 'm11', 'm12', 'm13', 'm14', 'm15', 'm16'
                   };
nb_personnes = length(liste_personnes);

% liste des differentes postures 
liste_postures = {'v1e1','v3e1','v1e2','v3e2','v1e3','v3e3'};
nb_postures = length(liste_postures);

nb_lignes = 400;
nb_colonnes = 300;

% postures de la base d'apprentissage 
liste_postures_base = {'v1e1','v3e1','v1e2','v3e2'};
nb_postures_base = length(liste_postures_base);


%Validation croisée avec une base d'apprentissage de taille 4 que l'on peut
% tourner 8 fois 
% personnes constituant la base d'apprentissage 
S = 8;
for i =1:2:16
    
    
    % Construction base d'apprentissage
    if (i < 9)
        numero_1 = string(i);
        numero_2 = string(i+1);
        fille_1 = strcat('f0',numero_1);
        fille_2 = strcat('f0',numero_2);
        garcon_1 = strcat('m0',numero_1);
        garcon_2 = strcat('m0',numero_2);
        
    elseif (i ==9)
        numero_1 = string(i);
        numero_2 = string(i+1);
        fille_1 = strcat('f0',numero_1);
        fille_2 = strcat('f',numero_2);
        garcon_1 = strcat('m0',numero_1);
        garcon_2 = strcat('m',numero_2);
        
    else 
        numero_1 = string(i);
        numero_2 = string(i+1);
        fille_1 = strcat('f',numero_1);
        fille_2 = strcat('f',numero_2);
        garcon_1 = strcat('m',numero_1);
        garcon_2 = strcat('m',numero_2);
    end
    liste_personnes_base = {convertStringsToChars(fille_1), convertStringsToChars(fille_2), convertStringsToChars(garcon_1), convertStringsToChars(garcon_2)};
    nb_personnes_base = length(liste_personnes_base); 

    %Construction données de test 
    liste_personnes_test = setdiff(liste_personnes,liste_personnes_base);
    nb_personnes_test = length(liste_personnes_test);
    
    %%%%%%%% LECTURE DES DONNES SANS MASQUE
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    X = [];
    liste_base = [];


    % Affichage des images sous forme de planche-contact 
    % (une personne par ligne, une posture par colonne) :
    for j = 1:nb_personnes_base,
        no_posture = 0;
        for k = 1:nb_postures_base,
            no_posture = no_posture + 1;

            ficF = strcat('./Data/', liste_personnes_base{j}, liste_postures_base{k}, '-300x400.gif')
            liste_base = [liste_base ; ficF];
            img = imread(ficF);
            % Remplissage de la matrice X :
            X = [X ; double(transpose(img(:)))];

        end
    end
    
    %%%%%%%% CALCUL ET AFFICHAGE DES EIGENFACES SANS MASQUE
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Calcul de l'individu moyen :
    n = size(X,1);
    individu_moyen = ones(1,n)*X/n;

    % Calcul de la matrice X_moyen de meme taille que X, 
    % telle que chaque ligne contienne l'individu moyen :
    X_moyen = ones(n,1)*individu_moyen;

    % Centrage de la matrice X :
    X_centre = X - X_moyen;

    % Calcul de la matrice de covariance (impossible a calculer ainsi a cause de sa taille) :
    % Sigma = transpose(X_centre)*X_centre/n;

    % Calcul de la matrice resultant du calcul inverse :
    Sigma2 = X_centre*transpose(X_centre)/n;

    % Calcul des vecteurs/valeurs propres de la matrice Sigma2 :
    %%%%%%%%%%%%%%%
    % VOUS POUVEZ REMPLACER L'APPEL À EIG PAR UN APPEL À L'UNE DE VOS FONCTIONS
    % SUBSPACE ITERATION
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [V_2, D] = eig(Sigma2);

    % Les vecteurs propres de Sigma (les eigenfaces) se deduisent de ceux de Sigma2 :
    V = transpose(X_centre)*V_2;

    % Tri par ordre decroissant des valeurs propres de Sigma_barre :
    [lambda, ind] = sort(diag(D),'descend');

    % Tri des eigenfaces dans le meme ordre 
    % (on enleve la derniere eigenface, qui appartient au noyau de Sigma) :
    W = V(:, ind);
    W = W(:, 1:size(W,2)-1);

    % Normalisation des eigenfaces :
    normes_eigenfaces = ones(size(W,1), 1)*sqrt(sum(W.*W));
    W = W./normes_eigenfaces;


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % AVEC MASQUE
    %%%%%%%%%%%%%


    % Dimensions du masque
    ligne_min = 200;
    ligne_max = 350;
    colonne_min = 60;
    colonne_max = 290;

    %%%%%%%% LECTURE DES DONNES ET AJOUT DU MASQUE
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    X_masque = [];


    for j = 1:nb_personnes_base,
        no_posture = 0;
        for k = 1:nb_postures_base,
            no_posture = no_posture + 1;

            ficF = strcat('./Data/', liste_personnes_base{j}, liste_postures_base{k}, '-300x400.gif')
            img = imread(ficF);

            % Degradation de l'image
            img(ligne_min:ligne_max,colonne_min:colonne_max) = 0;
            % Remplissage de la matrice X_masque :
            X_masque= [X_masque; double(transpose(img(:)))];

        end
    end


    %%%%%% REFAIRE LE CALCUL ET L'AFFICHAGE DES EIGENFACES AVEC MASQUE

    % Calcul de l'individu moyen :
    n = size(X_masque,1);
    individu_moyen_masque = ones(1,n)*X_masque/n;

    % Calcul de la matrice X_moyen de meme taille que X, 
    % telle que chaque ligne contienne l'individu moyen :
    X_moyen_masque = ones(n,1)*individu_moyen_masque;

    % Centrage de la matrice X :
    X_centre_masque = X_masque - X_moyen_masque;

    % Calcul de la matrice de covariance (impossible a calculer ainsi a cause de sa taille) :
    % Sigma = transpose(X_centre)*X_centre/n;

    % Calcul de la matrice resultant du calcul inverse :
    Sigma2 = X_centre_masque*transpose(X_centre_masque)/n;

    m = 16;
    percentage = 1.000000001;
    p = 1;
    eps = 1e-5;
    maxit = 100000;

    [W_res, V_2] = subspace_iter_v3(Sigma2, m, percentage, p, eps, maxit);
    D = diag(W_res);

    % Les vecteurs propres de Sigma (les eigenfaces) se deduisent de ceux de Sigma2 :
    V = transpose(X_centre_masque)*V_2;

    % Tri par ordre decroissant des valeurs propres de Sigma_barre :
    [lambda, ind] = sort(diag(D),'descend');

    % Tri des eigenfaces dans le meme ordre 
    % (on enleve la derniere eigenface, qui appartient au noyau de Sigma) :
    W_masque = V(:, ind);
    W_masque = W_masque(:, 1:size(W_masque,2)-1);

    % Normalisation des eigenfaces :
    normes_eigenfaces = ones(size(W_masque,1), 1)*sqrt(sum(W_masque.*W_masque));
    W_masque = W_masque./normes_eigenfaces;

    
    % Reconstruction des images de test seulement ! 
    C = X_centre*W;
    
    ecart_quadratique = 0; 
    
    for numero_personne= 1:nb_personnes_test
        
        for numero_posture = 1:4


            personne = liste_personnes_test{numero_personne};   % liste_personnes{numero_personne}
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
            numero_personne_proche = floor((partition-1)/nb_postures_base)+1;
            numero_posture_proche = mod(partition-1,nb_postures_base)+1;



            ficF = strcat('./Data/', liste_personnes_base{numero_personne_proche}, liste_postures_base{numero_posture_proche}, '-300x400.gif')
            img_retrouve = imread(ficF);

            img_masque(ligne_min:ligne_max,colonne_min:colonne_max) = img_retrouve(ligne_min:ligne_max,colonne_min:colonne_max);
            ecart_quadratique = ecart_quadratique + sum(sum((img_masque(ligne_min:ligne_max,colonne_min:colonne_max)-img_base(ligne_min:ligne_max,colonne_min:colonne_max)).^2));

        end

    end

end

nb_posture = length(liste_postures_base);
nb_total_test = nb_posture*nb_personnes_test *S;
ecart_quadratique_moyen = ecart_quadratique/nb_total_test/ (ligne_max-ligne_min) / (colonne_max-colonne_min)

