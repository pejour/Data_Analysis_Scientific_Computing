clear;
close all;

load Data_Exo_2/SG1;
load Data_Exo_2/ImSG1;

[alpha,beta] = MCT(Data,DataMod);
I_chapeau = (beta - log(ImMod))/alpha;
figure(1)
imshow(I_chapeau);

figure(2)
imshow(ImMod);

RMSE = sqrt(mean((I(:) - I_chapeau(:)).^2))