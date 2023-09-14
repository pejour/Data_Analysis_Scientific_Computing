function Beta_chapeau = MCO(x, y)
    % MCO avec 6 paramètres
    n = length(x);
    B = [zeros(n,1);1];
    
    A = zeros(n+1,6);
    A(:,1) = [x.^2;1];
    A(:,2) = [x.*y;0];
    A(:,3) = [y.^2;1];
    A(:,4) = [x;0];
    A(:,5) = [y;0];
    A(:,6) = [ones(n,1);0];
    
    Beta_chapeau = pinv(A)*B;
    
    % Avec 5 paramètres
    A_bis = zeros(n,5);
    A_bis = [x.*y y.^2-x.^2 x y ones(n,1)];
    B_bis = -x.*x;
    Beta_chapeau_bis = pinv(A_bis)*B_bis;
    
    Rapport = Beta_chapeau_bis./Beta_chapeau(2:6)
    
    % Exo 2
    
    
    
end

