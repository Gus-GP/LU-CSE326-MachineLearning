% --------------------------------------------------------------------
% Lehigh University - CSE
% CSE 326 - Machine Learning
% Gustavo Grins
% --------------------------------------------------------------------

%note that init is the initialization method

function [mu,classPi,z,si2,CLL,ILL,score] = gmm(X,K,init)
% input X is N*D data, K is number of clusters; numIter is the
% maximum number of iterations to run.  
% output: mu, which is K*D, the coordinates of the means; 
% classPi, which is K*1 and represents the class prior probabilities;
% z, which is N*K, stores in positions z(n,k) the probability
% that the nth data point belongs to cluster k. specifying the cluster
% associated with each data point; si^2 is the estimated (shared) variance of
% the data; CLL is a plot of the complete log likelihoods and ILL is a plot
% of the incomplete log likelihoods.
  
[N D] = size(X);

if K >= N
  error('gmm: you are trying to make too many clusters!');
end

numIter = 20;  % maximum number of iterations to run, please set your own parameter

% initialize the log likelihoods
CLL = zeros(numIter,1);
ILL = zeros(numIter,1);

% initialize si2 dumbly
si2 = eye(D); %create an identity matrix (1 on diagonal)

% initialize classPi uniformly
classPi = ones(K,1) / K; %column vector of percentages depending on how
%many clusters

% we initialize the means totally randomly

%nargin is the number of arguments in the function

if nargin < 3 || strcmp(init, 'random')
  % initialize by choosing K (distinct!) random points: we do this by
  % randomly permuting the examples and then selecting the first K
  
  perm = randperm(N); %random permutation of 1 to N numbers
  
  perm = perm(1:K); %select the first k values in the row vector
  
  % the centers are given by points
  mu = X(perm, :);
  
elseif strcmp(init, 'furthest')
  % initialize the centroids
  % run furthest-first initialization from your PS2
  mu = clusterInit(X,K);
  
else
  error('unknown initialization: use "furthest" or "random"');
end



for iter=1:numIter
  % in the first step, we do assignments: each point is probabilistically
  % assigned to each center
  
  invSI2 = inv(si2 + 0.1 * eye(D));
  
  logdetSI2 = logdet(si2 + 0.1 * eye(D));
  
  for n=1:N
    for k=1:K
      
      % compute z(n,k) = log probability that the nth data point belongs
      % to cluster k... this is just like prediction from the
      % classification case
      normalPdfval = -(D/2)*log(2*pi)...
          -(1/2)*logdetSI2...
          -(1/2)*(X(n,:)-mu(k,:))*invSI2*(X(n,:)-mu(k,:)).';

        z(n,k) = log(classPi(k)) + normalPdfval;
    end
    
    % "magically" turn log probabilities into actual probabilities
    maxZ   = max(z(n,:));
    z(n,:) = exp(z(n,:) - maxZ - log(sum(exp(z(n,:) - maxZ)))); %gamma of Z
    
    
  end
  
  %create the N-K value (Population of the cluster
  for k=1:K
      suma = 0;
      %this loop will perform the N sum
      for i = 1:N
        suma = suma + z(i,k);
      end
      
      %Assign to the Nk row vector
      Nk(k) = suma;  
  end
  
  % re-estimate classPi
  classPi = (Nk)/(N); %returns a percentage value
  
  % re-estimate the means
  for k=1:K
      val = 0; %place holder
      %perform the sum of the multiplication
      for i = 1:N
          val = val + z(i,k)*X(i,:);
      end
    mu(k,:) = (1/Nk(k))*(val); 
  end
   
  %make my own variance loop
  for k=1:K
      val = zeros(D); %place holder
      %perform the sum of the multiplication
      for i = 1:N
          val = val + (z(i,k)*(X(i,:)-mu(k,:)).'*(X(i,:)-mu(k,:)));
      end
    %store the Si2 value 
    si2(:,:,k) = (1/Nk(k))*(val);
  end
  
  %find the mean variance because is shared
  si2 = mean(si2,3);
  
  % compute *complete* and *incomplete* log likelihoods
  invSI2 = inv(si2 + 0.1 * eye(D));
  logdetSI2 = logdet(si2 + 0.1 * eye(D));
  cll = 0;
  ill = 0;
  for n=1:N
    for k=1:K
      % compute pnk = joint log probability of data point x and cluster
      % k... note that this is exactly the same as z(n,k) from
      % above... feel free to just copy!
      normalPdfval = -(D/2)*log(2*pi)...
          -(1/2)*logdetSI2...
          -(1/2)*(X(n,:)-mu(k,:))*invSI2*(X(n,:)-mu(k,:)).';
      
      %new way
      p(n,k) = log(classPi(k)) + normalPdfval;
      
      %cll equation
      cll = cll + z(n,k)*p(n,k);
      
    end
    
      %what i thik is correct
      ill = ill + log(sum(exp(p(n,:))));
    
  end
  
  % store values
  CLL(iter) = cll;
  ILL(iter) = ill;
end

score = CLL(end);

function y = logdet(A)
  U = chol(A);
  y = 2*sum(log(diag(U)));