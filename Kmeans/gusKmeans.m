% --------------------------------------------------------------------
% Lehigh University - CSE
% CSE 326 - Machine Learning
% Gustavo Grins
% --------------------------------------------------------------------

function [Centroids] = gusKmeans(Data,k)

%initialize the clusters
Centroids = clusterInit2(Data,k,1);

for N = 1:1:20
%while ~ismembertol(Centroids,oldCentroids)
    
    %clear values for the new assignments
    clear Clusters
    
    %initialize indeces
    indeces = zeros(1,size(Data,2)); 
    
    %first for loop will select all rows of data
    for i = 1:1:size(Data,1)
          
        %second for loop will get the centroids difference to all points
        %initialize the matrix with distances
        dist = zeros(1,k);
        
        for j = 1:1:k
           
           %calculate the distance of the specific point to all centroids
           dist(j) = sqrt(((Centroids(j,:) - Data(i,:))*((Centroids(j,:) - Data(i,:))')));

        end

        %Find the index of the min value of all the cluster calculations
        %to that point
        [Y,index] = min(dist);
        
        %store all the indeces from the results
        indeces(i) = index;

    end

    for i=1:1:k
        
        %select all the values row index numbers where indeces = i
        %and put it in a temporary MATRIX
        clusterValues = Data(indeces==i,:);
        
        %number of values in this temporary MATRIX
        Ncluster = size(clusterValues,1);
        
        if Ncluster == 0
            
        else
            %assign the new centroids by calculating the mean of the x and
            %y values in the cluster
            Centroids(i, :) = (1/Ncluster) * sum(clusterValues,1);
        end
        
    end
    
end
end