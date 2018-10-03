function [ features ] = songAnalyser( fileName,directory )
%f = songAnalyser(x , dir) return the features f of the song x stored in dir 
numfeat=7;
%Load database
if(exist('savedFeaturesDB.mat')~=0)
    load('savedFeaturesDB.mat');
    numFeatures=size(features,1)
    numFiles=size(features,2)
    j=numFiles
else
    features=zeros(numfeat,nfiles);
    j=0;
end

%featuresExtraction function call
features(:,j+1)=featuresExtraction(fileName,directory);
%Normalization of features to enable the comparison between them
features=normalization_compactation(features);
save('savedFeaturesDB.mat','features')
end

