%Plots

%% Correlation
% 
 features_t=features';
cor=corrplot(features_t(:,:));
% %
features(9,:)=(features(4,:)+features(5,:)+features(6,:))/3; %flux + rhythm + rmse
features(16,:)=(features(2,:).*0.2+features(7,:).*0.4+features(14,:).*0.4); %keyClarity + MFCC + roughness

% % Features comparison
% figure
% hold on
% title('Features of arousal')
% xlabel('songs')
% ylabel('Coeficient')
% plot(features(1,1:20),'m-o') %diff arousal
% plot(features(2,1:20),'r-o')
% plot(features(3,1:20),'g-*')
% plot(features(4,1:20),'b-o')
% 
% % plot(features(7,1:20),'m-*')
% % plot(features(8,1:20),'r-+')
% %plot(features(15,1:20),'k--o')
% % plot(features(10,:),'k-o')
% %
% %
% hold off
% legend('flux', 'rmse','rhythm','zc','flux + rhythm + rmse')

% legend('ZC Pitch', 'Key clarity','ZC rate','MFCC 1','flux');
% %
% legend('k','flux','mean(RMS)','rolloff','periodicity')

% features(1) = zcPitch;
% features(2) = keyClarity; %->Info of Valence;
% features(3) = ZC(;
% features(4) = mean(flux);
% features(5) = mean(mirgetdata(rms));
% features(6) =rhythm;
% features(7) = MFCC(1);
% features(8) =mean(mirgetdata(rolloff));
% features(9) =mirgetdata(br);
% features(10) = mean(mode); %->Info of Valence
% features(11) = peakRate;
% features(12) = envelopeCentroid;
% features(13) =std(mirgetdata(rms)); %Standard deviation of RMS along frames ->Info of Valence
% features(14) =mean(mirgetdata(roughness));
% features(15) =p1Max;%tempoMAX
