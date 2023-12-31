clear all;
format long;

%%%%%%%%%%%%
% PARAMÈTRES
%%%%%%%%%%%%

% taille de la matrice symétrique
n = 100;

% type de la matrice (voir matgen_csad)
% imat == 1 valeurs propres D(i) = i
% imat == 2 valeurs propres D(i) = random(1/cond, 1) avec leur logarithmes
%                                  uniformément répartie, cond = 1e10
% imat == 3 valeurs propres D(i) = cond**(-(i-1)/(n-1)) avec cond = 1e5
% imat == 4 valeurs propres D(i) = 1 - ((i-1)/(n-1))*(1 - 1/cond) avec cond = 1e2
imat = 2;

% on génère la matrice (1) ou on lit dans un fichier (0)
% si vous avez déjà généré la matrice d'une certaine taille et d'un type donné
% vous pouvez mettre cette valeur à 0
genere = 1;

% méthode de calcul
v = 10; % eig

[W, V, flag] = eigen_2021(imat, n, v, [], [], [], [], [], genere);


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

[W, V, flag] = eigen_2021(imat, n, v, m, eps, maxit, percentage, [], genere);


% méthode de calcul
v = 12; % power 12

[W, V, flag] = eigen_2021(imat, n, v, m, eps, maxit, percentage, [], genere);


% méthode de calcul
v = 13; % puissance itérée

[W, V, flag] = eigen_2021(imat, n, v, m, eps, maxit, percentage, [], genere);

% méthode de calcul
v = 0; % subspace 0

[W, V, flag] = eigen_2021(imat, n, v, m, eps, maxit, percentage, [], genere);


% méthode de calcul
v = 1; % subspace 1

[W, V, flag] = eigen_2021(imat, n, v, m, eps, maxit, percentage, [], genere);


% méthode de calcul
v = 2; % subspace 2

[W, V, flag] = eigen_2021(imat, n, v, m, eps, maxit, percentage, n/20, genere);

% méthode de calcul
v = 3; % subspace 3

[W, V, flag] = eigen_2021(imat, n, v, m, eps, maxit, percentage, n/20, genere);
