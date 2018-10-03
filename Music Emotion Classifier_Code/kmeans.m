function [iterations,centroids, labels,DB]= kmeans(features)
%Programació del métode de classificació Kmeans
%
% Paràmetres d'entrada:
% k = nombre de clusters --> nombre de centroides per determinar
% BD = base de dades que pot ser la gaussina normal o una imatge
% Paràmetres de sortida:
% labels: vector amb base de dades etiquetada
% centroides: matriu tants centroides com clusters d'entrada
% iterations: iteracions que ha realitzat l'algoritme fins que ha convergit
tic
%Number of clusters
k=4;
clear centroids;
%Data Base dimensions
DB=features'
n_feat = size(DB,2)
n_vec = size(DB,1)

%Initialization of centroids with values obtained from training

centroids(1,:)=[0.159060652409537 0.782544170564883 0.314762762136173];%
centroids(2,:)=[0.879633473450928 1.33695898692330 0.683857906763188];%
centroids(3,:)=[0.480475848500501 1.05088981599278 0.512559242997633];%
centroids(4,:)=[0.461187733581158 0.854798491464106 0.551271622356624];%
% centroids(1,:)=(DB(1,:)+DB(2,:)+DB(3,:)+DB(4,:)+DB(5,:))/5;
% centroids(2,:)=(DB(6,:)+DB(7,:)+DB(8,:)+DB(9,:)+DB(10,:))/5;
% centroids(3,:)=(DB(11,:)+DB(12,:)+DB(13,:)+DB(14,:)+DB(15,:))/5;
% centroids(4,:)=(DB(16,:)+DB(17,:)+DB(18,:)+DB(19,:)+DB(20,:))/5;


save('centroids_3feat','centroids')

% Variables initialization
no_convergence=true;
iterations=0;
vectordist=zeros(1,k,2);

while(no_convergence)
    
    %Initialization the counter and the variable that accumulates 
    %the vectors of each cluster to zero  
    cumulative_centroids=zeros(k,n_feat);
    cont=zeros(k,1);

    %Iteration for each vector of Data Base
    for i=1:n_vec
 
        %To optimize the code we copy each vector of the DB into an array
        %With the same dimensions as the centroid matrix to find
        %The distance between the vector and the centroids. This way
        %We avoid using a loop
        vector=DB(i,:)
        V=vector(ones(k,1),:)
        
        %euclidian distance between each centroid and the vector
        dif=((V-centroids).^2).';
        dist=sqrt(abs(sum(dif)));
        
        %The neares centroid is saved whic is the minimu distance
        [aux,nearest_centroid]=min(dist);
        %labels vector which saves the neares centroid
        labels(i)=nearest_centroid;
        
        %ERROR
        %error(i,:)=abs(centroids(1,:)-vector)
        
        %We will add vectors and then divide the number of vectors to obtain the mean
        cumulative_centroids(nearest_centroid,:) = cumulative_centroids(nearest_centroid,:) + vector;
        cont(nearest_centroid)=cont(nearest_centroid)+1;
    end
    %totalError(1,:)=sum(error);
    %J=sqrt(totalError(1,1)+totalError(1,2))*(totalError(1,1)+totalError(1,2));
    
    %Position of centorids saved
    previous_centroids=centroids;
    %Calculation of the centroids mean by dividing the sum of vectors from each
    %Cluster between the number of vectors there are (variable cont, 
    %using the same function ones as in the previous case)
    centroids=cumulative_centroids./cont(:,ones(1,n_feat));
    
    %movement of centroid
    mov=abs(previous_centroids-centroids)
    
    if(max(mov)<0.01)
        no_convergence=false;
    end
    iterations= iterations+1;
end

timeKmeans=toc

end

