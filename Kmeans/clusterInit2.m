% --------------------------------------------------------------------
% Lehigh University - CSE
% CSE 326 - Machine Learning
% Gustavo Grins
% --------------------------------------------------------------------

function [Clusters] = clusterInit2(A,k,method)
    %initialize cluster
    %Clusters = zeros(k,size(A,2));

    if method == 0
    
    for j = 1:1:size(A,2)
        %Generate random numbers
        for i = 1:1:k
            %make a random cluster 
            %each pixel is a column
            Clusters(i,j) = min(A(i,:)) + (range(A(i,:))*rand(1,1));
            
        end
        
    end
    
    
    else
        
        %Farthest-first-traversal
        %initialize algorithm
        popo = randi([1 size(A,1)],1,1);
        Clusters(1,:) = A(popo,:);
        
         %delete
         A(popo,:) = [];
        
        %repeat the furthest algorithm by the number of clusters we want
        for indec = 2:1:k
        clear dist;
            %calculate the distances of all the values to that point
            for i = 1:1:size(A,1) %for all the x and y values in A

                for j = 1:1:(indec-1)
                %Calculate the disctances to rand X and rand y
                dist(i,j) = sqrt(((Clusters(j,:) - A(i,:))*((Clusters(j,:) - A(i,:))')));
                
%                 %check for zero values, points that are the same as
%                 %centroids
%                 if dist(i,j) == 0 
%                     dist(i,j) = NaN; 
%                 end
                
                end
                
            end
            
            %assign the second centroid
            if indec == 2
                %obtain the max distance
                [Y,index] = max(dist);
                
                %put this value in the cluster array
                Clusters(indec,:) = A(index,:);
                
                %delete
                A(index,:) = [];
            
            %the fun starts at the third point
            else
                
                %calculate the sum of each row of the array
                sumClustDist = sum(dist,2);

                %obtain the max distance
                [Y,index] = max(sumClustDist);

                %put this value in the cluster array
                Clusters(indec,:) = A(index,:);
                
                %delete
                A(index,:) = [];
                
%                 %the other way I tried (max the mins)
%                 
%                 %Calculate the min of each cluster distance
%                 %returns a row vector with min of each column
%                 minDistances = min(dist,[],1);
% 
%                 %obtain the max distance
%                 [Y,index] = max(minDistances);
% 
%                 %put this value in the cluster array
%                 Clusters(indec,:) = A(index,:);
%                 
%                 %delete
%                 A(index,:) = [];
                
            end
        
        
       end
    
    end
    

end


