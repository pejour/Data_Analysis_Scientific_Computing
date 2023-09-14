%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de donnees
% TP4 - Reconnaissance de chiffres manuscrits par k plus proches voisins
% fonction kppv.m
%
% Données :
% DataA      : les données d'apprentissage (connues)
% LabelA     : les labels des données d'apprentissage
%
% DataT      : les données de test (on veut trouver leur label)
% Nt_test    : nombre de données tests qu'on veut labelliser
%
% K          : le K de l'algorithme des k-plus-proches-voisins
% ListeClass : les classes possibles (== les labels possibles)
%
% Résultat :
% Partition : pour les Nt_test données de test, le label calculé
%
%--------------------------------------------------------------------------
function [tx_erreur,Confusion,Partition] = kppv(labelT,DataA, labelA, DataT, Nt_test, K, ListeClass)

[Na,~] = size(DataA);

% Initialisation du vecteur d'étiquetage des images tests
Partition = zeros(Nt_test,1);

disp(['Classification des images test dans ' num2str(length(ListeClass)) ' classes'])
disp(['par la methode des ' num2str(K) ' plus proches voisins:'])

% Boucle sur les vecteurs test de l'ensemble de l'évaluation
for i = 1:Nt_test
    
    disp(['image test n°' num2str(i)])

    % Calcul des distances entre les vecteurs de test 
    % et les vecteurs d'apprentissage (voisins)
    
    distance = sqrt(sum((DataT(i,:) - DataA).^2,2));
    
    % On ne garde que les indices des K + proches voisins
    
    [~,indice] = sort(distance);
    k_tri = indice(1:K,:);
    label_tri = labelA(k_tri);
    
    % Comptage du nombre de voisins appartenant à chaque classe
    for j = 1:10
        classe(j,:) = length(find(label_tri == j));
    end
    
    % Recherche de la classe contenant le maximum de voisins
    nb_max = max(classe);
    classe_max = find(classe == nb_max);
    
    % [classe_max,~,all_classes_max] = mode(classes_kppv);
    
    % Si l'image test a le plus grand nombre de voisins dans plusieurs  
    % classes différentes, alors on lui assigne celle du voisin le + proche,
    % sinon on lui assigne l'unique classe contenant le plus de voisins 
    if length(classe_max) > 1
        Partition(i,1) = min(label_tri);
    else
        Partition(i,1) = classe_max;
    end
    
    Confusion(Nt_test,Nt_test);
    abs = labelT(i,1);
    ord = Partition(i,1);
    Confusion(abs,ord) = Confusion(abs,ord) + 1;
    tx_erreur = (1-trace(Confusion)/Nt_test)*100
    
    % Assignation de l'étiquette correspondant à la classe trouvée au point 
    % correspondant à la i-ème image test dans le vecteur "Partition" 
    % À COMPLÉTER
    
    
end

