% %Proves
% % %
% tic
numFeatures=15;
 for i=1:numFeatures
%
%% Normalitzar

    if(max(features(i,:))>1)
        max1=max(features(i,:));
        min1=min(features(i,:));
        features(i,:)=(features(i,:)-min1) / (max1-min1);
    end
end
% % % % Positivitzar
% % %     min2=min(features(4,:));
% % %     features(4,:)=(features(4,:)+abs(min2))+100;
% % %
% % % end
% %
% %
% %
% % % Correlation
% features_t=features';
% cor=corrplot(features_t(:,1:8));
% %
% % features(9,:)=(features(5,:)+features(8,:))/2;
features(9,:)=(features(4,:)+features(5,:)+features(6,:))/3; %flux + periodicity + rms

% % %% Comparasion between features
% % close all;
figure
hold on
title('Features')
xlabel('songs')
ylabel('Coeficient')
% plot(features(1,1:20),'m-o') %diff arousal
% plot(features(2,1:20),'r-o')
% plot(features(3,1:20),'g-*')
% plot(features(4,1:20),'b-o')
% plot(features(4,1:20),'b-o')
% plot(features(5,1:20),'c-*')
% plot(features(6,1:20),'g-+')
plot(features(7,1:20),'b-*')
plot(features(8,1:20),'r-+')
plot(features(9,1:20),'g--o')
% plot(features(10,:),'k-o')
%
%
hold off
legend('MFCC(1)','Rolloff','flux+RMS+Period')
%legend('flux','periodicity','rms','sum')
% toc
% legend('ZC Pitch', 'Key clarity','ZC rate','MFCC 1','flux');
% %
% legend('k','flux','mean(RMS)','rolloff','periodicity')

%     features(1,i) = zcPitch;
%     features(2,i) = keyClarity; %->Info of Valence;
%     features(3,i) = mirgetdata(zc);
%     features(4,i) = mean(flux);
%     features(5,i) = mean(mirgetdata(rms));
%     features(6,i) =periodicity;
%     features(7,i) = MFCC(1);
%     features(8,i) =mean(mirgetdata(rolloff));


