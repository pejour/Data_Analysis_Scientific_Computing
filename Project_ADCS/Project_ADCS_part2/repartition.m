close all;
clear;
format long;

%%%%%%%%%%%%
% PARAMÈTRES
%%%%%%%%%%%%

Ws = [];

% taille de la matrice symétrique
n = 200;

figure('Position',[100,100,1200/1.5,1200/1.5])
hold on;
for imat = 1:4
    % type de la matrice (voir matgen_csad)
    % imat == 1 valeurs propres D(i) = i
    % imat == 2 valeurs propres D(i) = random(1/cond, 1) avec leur logarithmes
    %                                  uniformément répartie, cond = 1e10
    % imat == 3 valeurs propres D(i) = cond**(-(i-1)/(n-1)) avec cond = 1e5
    % imat == 4 valeurs propres D(i) = 1 - ((i-1)/(n-1))*(1 - 1/cond) avec cond = 1e2

    % on génère la matrice (1) ou on lit dans un fichier (0)
    % si vous avez déjà généré la matrice d'une certaine taille et d'un type donné
    % vous pouvez mettre cette valeur à 0
    genere = 1;


    % nombre maximum de couples propres calculés
    m = 20;
    percentage = 0.4;

    % on génère la matrice (1) ou on lit dans un fichier (0)
    genere = 1;

    % tolérance
    eps = 1e-8;
    % nombre d'itérations max pour atteindre la convergence
    maxit = 10000;

    % méthode de calcul
    v = 11; % power 11
    [W, V, flag] = eigen_2021(imat, n, v, m, eps, maxit, percentage, [], genere);
    load(['A_' num2str(n) '_' num2str(imat)]);
    plot(log(D), '.');
end
title('Répartition des valeurs propres selon les types de matrice');
lgd = legend({'D(i) = i , cond = n','D(i) = random(1/cond, 1), cond = 1e10','D(i) = cond**(-(i-1)/(n-1)), cond = 1e5','D(i) = 1 - ((i-1)/(n-1))*(1 - 1/cond), cond = 1e2'},'Location','southwest');
lgd.FontSize = 10;
xlabel("Numéro de la valeur propre");
ylabel("Valeurs propres (en échelle log)");
%saveas(gcf,'repartition.png')