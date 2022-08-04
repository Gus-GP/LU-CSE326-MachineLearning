% --------------------------------------------------------------------
% Lehigh University - CSE
% CSE 326 - Machine Learning
% Gustavo Grins
% --------------------------------------------------------------------

function [Clusters] = clusterInit(A,k,method)
    %initialize cluster
    Clusters = zeros(k,size(A,2));

    if method == 0
        
    %Generate random numbers
    for i = 1:1:k
        %enter the random clusters into 2D array
        
        %x
        Clusters(i,1) = min(A(:,1)) + (range(A(:,1)))*rand(1,1);
        %y
        Clusters(i,2) = min(A(:,2)) + (range(A(:,2)))*rand(1,1);

    end
    
    else
        
        %Farthest-first-traversal
        popo = randi([1 size(A,1)],1,1);
        Clusters(1,:) = A(popo,:);
        
        
        %repeat the furthest algorithm by the number of clusters we want
        for indec = 2:1:k
        clear dist;
            %calculate the distances of all the values to that point
            for i = 1:1:size(A,1) %for all the x and y values in A

                for j = 1:1:(indec-1)
                %Calculate the disctances to rand X and rand y
                dist(i,j) = sqrt(((Clusters(j,1) - A(i,1)).^2) + ((Clusters(j,2) - A(i,2)).^2));
                
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
               
            end  
        
       end
    
    end
    

end


