% --------------------------------------------------------------------
% Lehigh University - CSE
% CSE 326 - Machine Learning
% Gustavo Grins
% --------------------------------------------------------------------

clc;
clear;

%declare an call functions

load mnist.mat;

load ORL_32x32.mat;

%normalize the data from 0 to 1
X = (fea - min(min(fea)))/(max(max(fea))-min(min(fea)));

%change this value
k = 1000;

%test PCA
[Z,vecs,vals] = pca(X,k);

%% First Problem (Assumed to be run at k = 10)

% %sort for greatest to least
% vals = sort(vals,'descend');

% %plot the eigen values
% figure(1)
% plot(1:k,vals)
% title('Plot of all Eigenvalues')
% ylabel('Eigenvalue')
% xlabel('Index')
% 
% % 90% question
figure(2)
plot(1:k,cumsum(vals)./sum(vals)) %about the first 70 high eigen values
%give 90% of variance
title('Data variance vs. Principal Component of Facial Recognition')
ylabel('Data variance')
xlabel('Principal Components')
% 
% 
% %plot the 10 eigen vectors
% figure(3)                                          % plot images
% %colormap(gray)                                  % set to grayscale
% for i = 1:1:10                                    % preview first 25 samples
%     subplot(1,10,i)                              % plot them in 6 x 6 grid
%     digit = reshape(vecs(:,i), [28,28])';    % row = 28 x 28 image
%     imagesc(digit)                              % show the image
% end
%% Second problem assumed to be run at k = 20, 50 , etc...
% k = 5;
% 
% %plot for the gmm section
% [mu,classPi,z,si2,CLL,ILL,score] = gmm(Z,k,'furthest');
% %test the MNIST data
% %plot the eigen vectors
% 
% %reconstruction
% %mean of the whole data
% dataMean = mean(testX);
% 
% %reconstruction of the higher dimention value
% Recon = (mu*vecs.') + dataMean;
% 
% figure(1)
% title('Plots of means k = 5')
% % plot images
% %colormap(gray)                                  % set to grayscale
% for i = 1:1:k                                    % preview first 25 samples
%     subplot(2,3,i)                              % plot them in 6 x 6 grid
%     digit = reshape(Recon(i,:), [28,28])';    % row = 28 x 28 image
%     imagesc(digit)                              % show the image
% end
% 
% figure(2)
% bar(1:k,classPi)
% title('mixing coefficients dimensions reduced to 300')
% xlabel('k values')
% ylabel('mixture coefficients')
