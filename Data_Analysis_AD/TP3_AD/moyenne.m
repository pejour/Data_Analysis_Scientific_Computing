function X_barre = moyenne(I)
    I = single(I);
    R = I(:,:,1);
    V = I(:,:,2);
    B = I(:,:,3);
    
    % Normalisation
    M_normRVB = max(1,R+V+B);
    r = R./M_normRVB;
    v = V./M_normRVB;
    r_ = mean(r(:));
    v_ = mean(v(:));
    X_barre = [r_,v_];
end

