% méthode de la puissance itérée avec déflation

% Données
% A          : matrice dont on cherche des couples propres
% m          : nombre maximum de valeurs propres que l'on veut calculer
% percentage : pourcentage recherché de la trace
% eps        : seuil pour déterminer si un couple propre a convergé (méthode de la puissance itérée)
% maxit      : nombre maximum d'itérations pour calculer une valeur propre (méthode de la puissance itérée)

% Résultats
% W : vecteur contenant les valeurs propres (ordre décroissant)
% V : matrice des vecteurs propres correspondant
% n_ev : nombre de couples propres calculés
% itv : nombre d'itérations pour chaque couple propre
% flag : indicateur sur la terminaison de l'algorithme
%  flag = 0  : on a convergé (on a calculé le pourcentage voulu de la trace)
%  flag = 1  : on a atteint le nombre maximum de valeurs propres sans avoir atteint le pourcentage
%  flag = -3 : on n'a pas convergé en maxit itérations pour calculer une valeur propre
function [ W, V, n_ev, itv, flag ] = puissance_iteree( A, m, percentage, eps, maxit )
    
    n = size(A,1);

    % initialisation des résultats
    W = [];
    it = [];
    n_ev = 0;

    % trace de A
    tA = trace(A);
 
    % somme des valeurs propres
    eig_sum = 0.0;

    % indicateur de la convergence (pourcentage atteint)
    convg = 0;
    
    
    % méthode de la puissance itérée
    V = randn(n,m);
    Z = A*V;
    beta = V'*Z;
    

    % conv = || beta * v - A*v||/|beta| < eps
    % voir section 2.1.2 du sujet
    norme = norm(V*beta - Z, 2)/norm(beta,2);
    nb_it = 1;

    while([norme>eps nb_it<maxit])
      V = Z / norm(Z,2);
      Z = A*V;
      beta = V'*Z;
      norme = vecnorm(V*beta - Z, 2)./vecnorm(beta,2);
      nb_it = nb_it + 1;
    end

    % la calcul de ce couple propre a échoué => échec global
    if(nb_it == maxit)
      flag = -3;
      % on sort de la fonction en plein milieu
      % ce n'est pas très bien structuré
      % pardon aux enseignants de PIM
      return;
    end

    % on sauvegarde le couple propre
    W = beta;
    itv = nb_it * ones(1,m);
    eig_sum = eig_sum + beta;

    
    % on a atteint le pourcentage
    if (convg)
      n_ev = m;
      flag = 0;
      W = W';
    else
      % ce n'est pas le cas
      flag = 1;
    end
    
end
