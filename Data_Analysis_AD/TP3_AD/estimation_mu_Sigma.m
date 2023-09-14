function [mu, Sigma] = estimation_mu_Sigma(X)
    [n,~] = size(X);
    mu = mean(X)';
    Xc = X - mu';
    Sigma = 1/n*(Xc')*Xc;
    
end

