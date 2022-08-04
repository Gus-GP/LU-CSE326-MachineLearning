% --------------------------------------------------------------------
% Lehigh University - CSE
% CSE 326 - Machine Learning
% Gustavo Grins
% --------------------------------------------------------------------
function [Clusters] = clusterInit(A,k)
        
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
                
                
            end
        
        
       end
    
    end
    



