function [ features ] = musicFromFolder( directory )
%f = musicFromFolder(dir) returns a matrix of features f of all songs stored  in dir
tic

%dir ='/Users/marionacaros/Desktop/musica/';
numfeat=7;
files = dir( fullfile(directory,'*.mp3') );   % list all *.mp3 audio files
files = {files.name}';                      % file names
nfiles = length(files);    % Number of files found
features=zeros(numfeat,nfiles);
 j=0;
%Load database
% if(exist('savedFeatures2DB.mat')~=0)
%     load('savedFeatures2DB.mat');
%     numFeatures=size(features,1)
%     numFiles=size(features,2)
%     j=numFiles
% else
%     features=zeros(numfeat,nfiles);
%     j=0;
% end

for i=1:nfiles
    name=files(i);%Name of song under analysis
    fileName=name{1};
    
    %Call featuresExtraction function
    features(:,i+j)=featuresExtraction(fileName,directory);
     save('savedFeaturesDB','features')
end
%Normalization of features to enable the comparison between them
features = normalization_compactation(features);

toc
end

