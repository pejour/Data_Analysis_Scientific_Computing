function [alpha,beta] = MCO2(Data,DataMod)

    % On vectorise Data et DataMod
    
    O = log(DataMod);
    B = O(:);
    [n,m] = size(Data);
    A = [-Data(:) ones(n*m,1)];
    X = A \ B;
     
    alpha = X(1);
    beta = X(2);

end

