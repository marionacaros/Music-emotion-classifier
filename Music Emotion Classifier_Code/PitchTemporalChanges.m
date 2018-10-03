function [ zcPitch ] = PitchTemporalChanges( pitch )
%Temporal change of pitch (Fundamental frequency)

maxP=max(pitch);
minP=min(pitch);
pitch2=pitch-((maxP-minP)/2);
t=0:length(pitch2)-1;
signum = sign(pitch2);	% get sign of data
signum(pitch2==0) = 1;	% set sign of exact data zeros to positiv
zcPitch=length(t(diff(signum)~=0))/secs;	% get zero crossings by diff ~= 0

figure
hold on
plot(t,pitch2,'b-o')
y=zeros(length(pitch));
plot(t,y,'r--')
title('ZeroCross of Titanic Pitch')
xlabel('samples')
ylabel('Moved Frequency (Hz)')
hold off

end

