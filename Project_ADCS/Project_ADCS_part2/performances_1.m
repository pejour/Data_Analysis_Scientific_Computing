clear all;
format long;

%%%%%%%%%%%%
%ce script permet générer les matrices de tests pour répondre à la question 15
% sur la comparaison des méthodes selon les divers paramètres
% il fait appel à performances_2 pour générer les couples propres
% performances 3 explote les données produites dans le fichier
% question15.mat pour obtenir les tracés du rapport
%%%%%%%%%%%%

% taille de la matrice symétrique
i=1;

for n =[100:100:700]

    % type de la matrice (voir matgen_csad)
    % imat == 1 valeurs propres D(i) = i
    % imat == 2 valeurs propres D(i) = random(1/cond, 1) avec leur logarithmes
    %                                  uniformément répartie, cond = 1e10
    % imat == 3 valeurs propres D(i) = cond**(-(i-1)/(n-1)) avec cond = 1e5
    % imat == 4 valeurs propres D(i) = 1 - ((i-1)/(n-1))*(1 - 1/cond) avec cond = 1e2
    for imat = [1:1:4]

        % on génère la matrice (1) ou on lit dans un fichier (0)
        % si vous avez déjà généré la matrice d'une certaine taille et d'un type donné
        % vous pouvez mettre cette valeur à 0
        if (n < 700)
            genere = 0;
        else 
            genere = 1;
        end
        % méthode de calcul
        v = 10; % eig

        [precision_couple,temps,W, V, flag] = performances_2(imat, n, v, [], [], [], [], [], genere);
        graph_precision_couple1(imat,i) = precision_couple;
        graph_temps1(imat,i) = temps;
        
        % nombre maximum de couples propres calculés
        m = 20;
        percentage = 0.4;

        % on génère la matrice (1) ou on lit dans un fichier (0)
        genere = 0;

        % tolérance
        eps = 1e-8;
        % nombre d'itérations max pour atteindre la convergence
        maxit = 10000;

        % méthode de calcul
        v = 11; % power 11

        [precision_couple,temps,W, V, flag] = performances_2(imat, n, v, m, eps, maxit, percentage, [], genere);
        graph_precision_couple2(imat,i) = precision_couple;
        graph_temps2(imat,i) = temps;

        % méthode de calcul
        v = 12; % power 12

        [precision_couple,temps,W, V, flag] = performances_2(imat, n, v, m, eps, maxit, percentage, [], genere);
        graph_precision_couple3(imat,i) = precision_couple;
        graph_temps3(imat,i) = temps;

        % méthode de calcul
        v = 13; % puissance itérée

        [precision_couple,temps,W, V, flag] = performances_2(imat, n, v, m, eps, maxit, percentage, [], genere);
        graph_precision_couple4(imat,i) = precision_couple;
        graph_temps4(imat,i) = temps;
        
        % méthode de calcul
        v = 0; % subspace 0

        [precision_couple,temps,W, V, flag] = performances_2(imat, n, v, m, eps, maxit, percentage, [], genere);
        graph_precision_couple5(imat,i) = precision_couple;
        graph_temps5(imat,i) = temps;

        % méthode de calcul
        v = 1; % subspace 1

        [precision_couple,temps,W, V, flag] = performances_2(imat, n, v, m, eps, maxit, percentage, [], genere);
        graph_precision_couple6(imat,i) = precision_couple;
        graph_temps6(imat,i) = temps;

        % méthode de calcul
        v = 2; % subspace 2

        [precision_couple,temps,W, V, flag] = performances_2(imat, n, v, m, eps, maxit, percentage, n/20, genere);
        graph_precision_couple7(imat,i) = precision_couple;
        graph_temps7(imat,i) = temps;
        % méthode de calcul
        v = 3; % subspace 3

        [precision_couple,temps,W, V, flag] = performances_2(imat, n, v, m, eps, maxit, percentage, n/20, genere);
        graph_precision_couple8(imat,i) = precision_couple;
        graph_temps8(imat,i) = temps;
    end
    i = i+1;
end

save("question15", 'graph_temps1', 'graph_temps2', 'graph_temps3', 'graph_temps4','graph_temps5','graph_temps6','graph_temps7','graph_temps8','graph_precision_couple1','graph_precision_couple2','graph_precision_couple3','graph_precision_couple4','graph_precision_couple5','graph_precision_couple6','graph_precision_couple7','graph_precision_couple8');
