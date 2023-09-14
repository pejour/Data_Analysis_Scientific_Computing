function [precision_couple,temps, W, V, flag] = performances_2(imat, n, v, m, eps, maxit, percentage, p, genere)

%%%%%%%%%%%%%%%%%%%

%ce script est tiré de eigen2021 et renvoie la précision minimale ainsi que
%le temps pris par chaque calcul de couples propres

%%%%%%%%%%%%%%%%

% si on veut que d'une expérience à l'autre la graine de l'aléatoire soit la même
rng('default');

fprintf('\nMatrice %d x %d - type %d\n', n, n, imat);

if(genere == 1)
    % Génération d'une matrice rectangulaire aléatoire symétrique définie
    % positive A de taille (n x n)
    
    % A matrice
    % D ses valeurs propres
    fprintf('\n******* création de la matrice ******\n');
    % appel à eig de matlab : calcul de toutes les valeurs propres
    t_v =  cputime;
    [A, D, ~] = matgen_csad(imat,n);
    t_v = cputime-t_v;
    fprintf('\nTemps de création de la matrice = %0.3e\n',t_v)
    save(['A_' num2str(n) '_' num2str(imat)], 'A', 'D', 'imat', 'n');
    
else
    load(['A_' num2str(n) '_' num2str(imat)]);
end

switch v
    case 10
        fprintf('\n******* calcul avec eig ******\n');
        % appel à eig de matlab : calcul de toutes les valeurs propres
        t_v =  cputime;
        % WA valeurs propres
        % VA vecteurs propres
        [VA, DA] = eig(A);
        temps = cputime-t_v;
        
        [WA, indices] = sort(diag(DA), 'descend');
        VA = VA(:, indices);
        
        [qA, qvA] = verification_qualite(A, D, WA, VA, n);
        precision_valeur = max(qA);
        precision_couple = max(qvA);
        
        
        W = WA;
        V = VA;
        flag = 0;
        
    case 11
        t_v =  cputime;
        % WA valeurs propres
        % VA vecteurs propres
        [ WB, VB, n_evB, itvB, flagB ] = power_v11( A, m, percentage, eps, maxit );
        temps = cputime-t_v;
        
        if(flagB == 0)

            [qB, qvB] = verification_qualite(A, D, WB, VB, n_evB);
            precision_valeur = max(qB);
            precision_couple = max(qvB);
            
                       
            W = WB;
            V = VB;
        else
            if(flagB == 1)
                precision_valeur = -1;
                precision_couple = -1;
            else
                precision_valeur = -1;
                precision_couple = -1;
            end
            
            W = 0;
            V = 0;
        end
        
        flag = flagB;
        
    case 12
 
        t_v =  cputime;
        % WA valeurs propres
        % VA vecteurs propres
        [ WB, VB, n_evB, itvB, flagB ] = power_v12( A, m, percentage, eps, maxit );
        temps = cputime-t_v;
        
        if(flagB == 0)

            [qB, qvB] = verification_qualite(A, D, WB, VB, n_evB);
            
            precision_valeur = max(qB);
            precision_couple = max(qvB)
                       
            W = WB;
            V = VB;
        else
            if(flagB == 1)
                precision_valeur = -1;
                precision_couple = -1;
            else
                precision_valeur = -1;
                precision_couple = -1;
            end
            
            W = 0;
            V = 0;
        end
        
        flag = flagB;
        
    case 13
        t_v =  cputime;
        % WA valeurs propres
        % VA vecteurs propres
        [ WB, VB, n_evB, itvB, flagB ] = puissance_iteree( A, m, percentage, eps, maxit );
        temps = cputime-t_v;
        
        if(flagB == 0)

            [qB, qvB] = verification_qualite(A, D, WB, VB, n_evB);
            
            precision_valeur = max(qB);
            precision_couple = max(qvB)
           
            W = WB;
            V = VB;
        else
            if(flagB == 1)
                precision_valeur = -1;
                precision_couple = -1;
            else
                precision_valeur = -1;
                precision_couple = -1;
            end
            
            W = 0;
            V = 0;
        end
        
        flag = flagB;
        
    case 0
 
        t_v0 =  cputime;
        % W0 valeurs propres
        % V0 vecteurs propres
        [W0, V0, it0, flag0] = subspace_iter_v0(A, m, eps, maxit);
        temps = cputime-t_v0;
        
        if(flag0 == 0)
            
            [q0, qv0] = verification_qualite(A, D, W0, V0, m);
            precision_valeur = max(q0);
            precision_couple = max(qv0);
            
            W = W0;
            V = V0;
        else
            precision_valeur = -1;
            precision_couple = -1;
            W = 0;
            V = 0;
        end
        
        flag = flag0;
        
    case 1
        fprintf('\n******* calcul avec subspace iteration v1 ******\n');        
        % appel à la version 1 de la subspace iteration method
        
        t_v1 =  cputime;
        % W1 valeurs propres
        % V1 vecteurs propres
        [ W1, V1, n_ev1, it1, itv1, flag1 ] = subspace_iter_v1( A, m, percentage, eps, maxit );
        temps = cputime-t_v1;
        
        if(flag1 == 0)
            
            [q1, qv1] = verification_qualite(A, D, W1, V1, n_ev1);
            
            precision_valeur = max(q1);
            precision_couple = max(qv1);
            
            W = W1;
            V = V1;
            
        else
            if(flag1 == 1)
                precision_valeur = -1;
                precision_couple = -1;
            else
                precision_valeur = -1;
                precision_couple = -1;
            end
            
            W = 0;
            V = 0;
        end
        
        flag = flag1;
        
    case 2 
        
        t_v2 =  cputime;
        % W2 valeurs propres
        % V2 vecteurs propres
        [ W2, V2, n_ev2, it2, itv2, flag2 ] = subspace_iter_v2( A, m, percentage,p, eps, maxit );
        temps = cputime-t_v2;
        
        if(flag2 == 0)
           
            [q2, qv2] = verification_qualite(A, D, W2, V2, n_ev2);
            
            precision_valeur = max(q2);
            precision_couple = max(qv2);
            
            W = W2;
            V = V2;
            
        else
            if(flag2 == 1)
                precision_valeur = -1;
                precision_couple = -1;
            else
                precision_valeur = -1;
                precision_couple = -1;
            end
            
            W = 0;
            V = 0;
        end
        
        flag = flag2;
        
    case 3
        
        t_v3 =  cputime;
        % W3 valeurs propres
        % V3 vecteurs propres
        [ W3, V3, n_ev3, it3, itv3, flag3 ] = subspace_iter_v3( A, m, percentage,p, eps, maxit );
        temps = cputime-t_v3;
        
        if(flag3 == 0)
           
            [q3, qv3] = verification_qualite(A, D, W3, V3, n_ev3);
            
            precision_valeur = max(q3);
            precision_couple = max(qv3);
            
            W = W3;
            V = V3;
            
        else
            if(flag3 == 1)
                precision_valeur = -1;
                precision_couple = -1;
            else
                precision_valeur = -1;
                precision_couple = -1;
            end
            
            W = 0;
            V = 0;
        end
        
        flag = flag3;
    otherwise
        
        fprintf('\n il n''existe pas (encore) de méthode avec ce numéro\n');
        
end

end
