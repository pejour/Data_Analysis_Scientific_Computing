% Ce script permet de tracer les graphiques pour répondre à la question 15,
% il s'appuie sur le fichier question15.mat contenant les résultats des
% tests écrits pour la question 15

clear all 
close all

absc = [100:100:700];

load ('question15.mat')

for i = [1:1:4]
    figure('Position',[100,100,1200/1.5,1200/1.5])
    semilogy(absc,graph_temps1(i,:),'b',absc,graph_temps2(i,:),'g',absc,graph_temps3(i,:),'r',absc,graph_temps4(i,:),'m',absc,graph_temps5(i,:),'k',absc,graph_temps6(i,:),'y',absc,graph_temps7(i,:),'g+-',absc,graph_temps8(i,:),'b^-')
    titre = sprintf("Temps d'exécution des méthodes itératives pour\n la décomposition spectrale de A, imat %d",i);
    title(titre)
    xlabel("n")
    ylabel("temps en seconde (échelle log)")
    lgd = legend({"eig","power\_method\_v11","power\_method\_v12","puissance\_iteree","subspace\_iter\_v0","subspace\_iter\_v1","subspace\_iter\_v2","subspace\_iter\_v3"},'Location','southwest');
    %chaine = sprintf("temps %d.png",i)
    %saveas(gcf,chaine);
end

graph_precision_couple1(find(graph_precision_couple1 ==-1))=inf;
graph_precision_couple2(find(graph_precision_couple2 ==-1))=inf;
graph_precision_couple3(find(graph_precision_couple3 ==-1))=inf;
graph_precision_couple4(find(graph_precision_couple4 ==-1))=inf;
graph_precision_couple5(find(graph_precision_couple5 ==-1))=inf;
graph_precision_couple6(find(graph_precision_couple6 ==-1))=inf;
graph_precision_couple7(find(graph_precision_couple7 ==-1))=inf;
graph_precision_couple8(find(graph_precision_couple8 ==-1))=inf;

for i = [1:1:4]
    figure('Position',[100,100,1200/1.5,1200/1.5])
    semilogy(absc,graph_precision_couple1(i,:),'b',absc,graph_precision_couple2(i,:),'g',absc,graph_precision_couple3(i,:),'r',absc,graph_precision_couple4(i,:),'m',absc,graph_precision_couple5(i,:),'k',absc,graph_precision_couple6(i,:),'y',absc,graph_precision_couple7(i,:),'g+-',absc,graph_precision_couple8(i,:),'b^-')
    titre = sprintf("Précision minimale des couples propres obtenus selon la méthode utilisée\n en fonction de la taille n, imat %d",i);
    title(titre)
    xlabel("n")
    ylabel("précision en échelle log")
    lgd = legend({"eig","power\_method\_v11","power\_method\_v12","puissance\_iteree","subspace\_iter\_v0","subspace\_iter\_v1","subspace\_iter\_v2","subspace\_iter\_v3"},'Location','southwest');
    chaine = sprintf("precision %d.png",i);
    saveas(gcf,chaine)
end
