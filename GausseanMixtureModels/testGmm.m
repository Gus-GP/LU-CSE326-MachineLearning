% --------------------------------------------------------------------
% Lehigh University - CSE
% CSE 326 - Machine Learning
% Gustavo Grins
% --------------------------------------------------------------------

clc;
clear;
close;

%declare an call functions

load mnist.mat;

%lastval = 16;

%for k = 1:1:lastval

k = 5;

[mu,classPi,z,si2,CLL,ILL,score] = gmm(testX,k,'random');

%ill(k) = ILL(end);

%Plot for the P1 
figure(1)
plot(1:size(CLL),CLL,'-r')
title('CLL and ILL vs. Expectation Maximization iterations')
xlabel('EM iterations')
ylabel('values')
hold on
plot(1:size(ILL),ILL,'-b')
legend('CLL','ILL')

%test the MNIST data
%plot the eigen vectors

%check if k is even or not 
% if mod(sqrt(k), 1) == 0
%     
%     ro = sqrt(k);
%     col = sqrt(k);
%     
% else
%     
%     %find all divisors get the greatest
%         K2=1:1:k;
%         D = K2(rem(k,K2)==0);
%         ro = D(length(D)-1);
%         col = k./ro;
%     
% end

% figure(k)                                          % plot images
% %colormap(gray)                                  % set to grayscale
% for i = 1:1:k                                    % preview first 25 samples
%     subplot(col,ro,i)                              % plot them in 6 x 6 grid
%     digit = reshape(mu(i,:), [28,28])';    % row = 28 x 28 image
%     imagesc(digit)                              % show the image
% end

%end

% %Plot the ill(end) vs. k
% figure(1);
% plot(1:1:lastval,ill)
% title('ILL vs. k-value')
% xlabel('k-value')
% ylabel('ILL value')


