function [ features ] = normalization_compactation( features )
%%f = normalization(f) returns the features normalized to values between 0 and 1

numFiles=size(features,2)
numFeatures=size(features,1)

%% Normalization
% if(numFiles>1)
for i=1:numFeatures
    if(max(features(i,:))>1)
        if(i==2)
            max1=16.970;
            min1=9.5;
        end
        if(i==4)
            max1=12;
            min1=1;
        end
        if(i==5)
            max1=4.1;
            min1=0.8;
        end
        if(i==6)
            max1=10700;
            min1=1500;
        end
        if(max(features(i))>max1)
            max1=max(features(i));
        end
        if(min(features(i)<min1))
            min1=min(features(i));
        end
        features(i,:)=(features(i,:)-min1) / (max1-min1);
    end
end

%% Feature compactation

% Valence features

% Rolloff
features(1,:)=features(6,:);
% MFC
features(2,:)=features(5,:).*0.6+ features(1,:)+0.2+ features(7,:).*0.2;

% Arousal features
features(3,:)=features(2,:).*0.4+features(3,:).*0.2+features(4,:).*0.4; %flux + rhythm + rmse

features=features(1:3,:);

end