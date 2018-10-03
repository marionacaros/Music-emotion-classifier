function [ features ] = featuresExtraction( fileName, directori )
% f = featuresExtraction(file,dir) returns a vector f of features of the 
% audio file stored  in dir.
%
%Features output:
%
% features(1) = keyClarity; %->Info of Valence;
% features(2) = mean(flux);%->Info of Arousal & Valence
% features(3) = mean(mirgetdata(rmse));%->Info of Arousal
% features(4) =rhythmPeriod;%->Info of Arousal
% features(5) = MFCC(1);%->Info of Valence
% features(6) =mean(mirgetdata(rolloff));%->Info of Valence
% features(7) =mean(mirgetdata(roughness));%->Info of Valence

addpath(directori)

%% Variables declaration
Fs2=44100;
t1=10;
t2=50;
secs=t2-t1;

%% Segmentation
  [x,Fs]=audioread(fileName);
    
    x=x(1:Fs2*60,:);
    if size(x,2)==2
        x = (x(:,1)+x(:,2))/2'; %stereo into mono
    end
    wavwrite(x,Fs2,'music.wav'); %Convert audio from mp3 into .wav for the Toolbox

%Extract 40 seconds to the song
song = miraudio('music','Extract',t1,t2);
clear 'music.wav'
%mirplay(song);

% Segmentation of the signal into notes
% 'Attacks' option enables to segment at the beginning of each note, where
% energy is maximum
o = mironsets(song,'Attacks','Contrast',.1); %Peaks of song
sg = mirsegment(song,o);

%% Tonality

% Pitch Feature discarted
% p = mirpitch(sg,'mono');
% pitch=mirgetdata(p);
%zcPitch=PitchTemporalChanges(pitch)

[k, c, s] = mirkey(song,'Frame');
keyClarity = mean(mirgetdata(c));

% Mode Feature discarted
% m=mirmode(s);
% mode=mirgetdata(m);

%% Temporal Analysis

%Envelope centroid feature discarted
% envelope=mirenvelope(song);
% envCentroid = mircentroid(envelope);
% envelopeCentroid = mirgetdata(envCentroid);



%% Ennergy

% Root Mean Square Energy
rmse=mirrms(sg);

% Low energy feature discarted computes the percentage of frames showing a RMS 
% energy that is lower than a given threshold. 
%le=mirlowenergy(sg)

%% Rythm / BPM

%Zero Crossing Temporal Rate
zc = mirzerocross(song,'Per','Second');
%BPM Histogram of tempo discarted
[tmp p1]=mirtempo(song, 'Frame');
h1 = mirhisto(tmp);

%Autocorrelation of onsets (temporal attack peaks of energy)
autocor=mirautocor(o);

%Peak rate feature discarted
% peaks=mirgetdata(o);
% peakRate=length(peaks)/secs;

%Find rhythm by detection of peaks in autocorrelation
[pks, locs]=findpeaks(mirgetdata(autocor),'MinPeakHeight',0.15,'MinPeakDistance',10);
if isempty(pks)
    rhythmPeriod=0;
else
    rhythmPeriod=length(pks);
end

%% Timbre

% MFCC
m = mirmfcc(song,'Rank',1:3);
MFCC=mirgetdata(m);

% Dissonance
roughness = mirroughness(song);

% Spectrum using Bark filter
spec= mirspectrum(song, 'Frame',0.023, 0.5, 'Terhardt', 'Bark', 'Mask', 'dB');


% Spectral change by measuring  distance between successive frames
fl = mirflux(spec);
flux=mirgetdata(fl);

% Feature discarted
% Brightness: cut-off frequency fixedat 1000 Hz, and measuring the amount of
% energy above that frequency. 
%br= mirbrightness(song,'CutOff',1000);

% Frequency (Hz) such that 85% of total energy is contained below that 
% frequency, threshold can be modified
rolloff = mirrolloff(sg);

%% FEATURES:
features(1) = keyClarity; %->Info of Valence;
features(2) = mean(flux);%->Info of Arousal & Valence
features(3) = mean(mirgetdata(rmse));%->Info of Arousal
features(4) =rhythmPeriod;%->Info of Arousal
features(5) = MFCC(1);%->Info of Valence
features(6) =mean(mirgetdata(rolloff));%->Info of Valence
features(7) =mean(mirgetdata(roughness));%->Info of Valence

%features(3) = mirgetdata(zc);
%features(1) = zcPitch;
% features(9) =mirgetdata(br);
% features(10) = mean(mode);
% features(11) = peakRate;
% features(12) = envelopeCentroid;
% features(13) =std(mirgetdata(rmse)); %Standard deviation of RMS along frames
% features(15) =mirgetdata(tmp);%tempo
%features(16,i) =max(mirgetdata(sumFluctuation1));

end