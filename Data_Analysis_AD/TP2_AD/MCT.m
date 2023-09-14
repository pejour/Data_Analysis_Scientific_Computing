function [alpha,beta] = MCT(Data,DataMod)

    O = log(DataMod);
    B = O(:);
    [n,m] = size(Data);
    A = [-Data(:) ones(n*m,1)];
    
    C = [A B];
    [~,~,V] = svd(C);

    
    X = V(1:2,3)/(-V(3,3));
     
    alpha = X(1);
    beta = X(2);
end

