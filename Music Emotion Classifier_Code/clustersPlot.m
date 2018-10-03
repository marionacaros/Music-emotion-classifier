function clustersPlot( centroids,labels,BD,name )
%Plot of classification

lastVector=size(BD,1);


figure
%% Tridimensional
hold on
pos_vec_k1=find(labels==1);
pos_vec_k2=find(labels==2);
pos_vec_k3=find(labels==3);
pos_vec_k4=find(labels==4);

plot3(BD(pos_vec_k1,1),BD(pos_vec_k1,2),BD(pos_vec_k1,3),'c.','Markersize',50)
plot3(BD(pos_vec_k2,1),BD(pos_vec_k2,2),BD(pos_vec_k2,3),'g.','Markersize',50)
plot3(BD(pos_vec_k3,1),BD(pos_vec_k3,2),BD(pos_vec_k3,3),'b.','Markersize',50)
plot3(BD(pos_vec_k4,1),BD(pos_vec_k4,2),BD(pos_vec_k4,3),'m.','Markersize',50)
text(BD(lastVector,1)+0.03,BD(lastVector,2)+0.03,BD(lastVector,3),name)
legend('Sad','Happy','Chill out','Active')

plot3(centroids(1,1),centroids(1,2),centroids(1,3),'Marker','+','Color','k','MarkerSize',20)
plot3(centroids(2,1),centroids(2,2),centroids(2,3),'Marker','+','Color','k','MarkerSize',20)
plot3(centroids(3,1),centroids(3,2),centroids(3,3),'Marker','+','Color','k','MarkerSize',20)
plot3(centroids(4,1),centroids(4,2),centroids(4,3),'Marker','+','Color','k','MarkerSize',20)

title('Emotion Classification')
xlabel('MFCC(1)')
ylabel('Rolloff')
zlabel('flux + RMS Energy + Rhythm')

grid on
hold off

end

