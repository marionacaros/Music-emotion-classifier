%%Pitch Extraction

close all
clear all
tic

directori ='/Users/marionacaros/Desktop/musica/';
%source = dir(directori);
%% Variables declaration
Fs2=44100;
t1=10;
t2=50;
numfeat=8;

files = dir( fullfile(directori,'*.mp3') );   % list all *.mp3 audio files
files = {files.name}';                      % file names
nfiles = length(files);    % Number of files found
features=zeros(numfeat,nfiles);


addpath directori
for i=1:nfiles
    
    name=files(i);%Name of song under analysis
    var=name{1};
    %if(source(i).name==var)
    [x,Fs]=audioread(var);
    
    x=x(1:Fs2*60,:);
    if size(x,2)==2
        x = (x(:,1)+x(:,2))/2'; %stereo into mono
    end
    wavwrite(x,Fs2,'music.wav'); %Convert audio from mp3 into .wav for the Toolbox
    song = miraudio('music','Extract',t1,t2);
    secs=t2-t1;
    %mirplay(song);
    
    
    %% Melody / harmony analysis
    
    % But it might get more sense to first decompose the signal into notes, using the commands:
    % (The 'Attacks' option enables to segment at the beginning of each note
    % attack phase, i.e., where the energy is minimum, instead of segmenting where the energy is maximum.)
    o = mironsets(song,'Attacks','Contrast',.1); %Peaks of song
    sg = mirsegment(song,o);
    
    p = mirpitch(sg,'mono');
    pitch=mirgetdata(p);
    
    maxP=max(pitch);
    minP=min(pitch);
    pitch2=pitch-((maxP-minP)/2);
    t=0:length(pitch2)-1;
    signum = sign(pitch2);	% get sign of data
    signum(pitch2==0) = 1;	% set sign of exact data zeros to positiv
    zcPitch=length(t(diff(signum)~=0))/secs;	% get zero crossings by diff ~= 0
    % figure
    % hold on
    % plot(t,pitch2,'b-o')
    % y=zeros(length(pitch));
    % plot(t,y,'r--')
    % title('ZeroCross of Titanic Pitch')
    % xlabel('samples')
    % ylabel('Moved Frequency (Hz)')
    % hold off
    
    [k c s] = mirkey(song,'Frame');
    keyClarity = mean(mirgetdata(c));
    
    % Mode
    m=mirmode(s);
    mode=mirgetdata(m);
    
    %% Temporal
    
    envelope=mirenvelope(song);
    envCentroid = mircentroid(envelope);
    envelopeCentroid = mirgetdata(envCentroid);
    zc = mirzerocross(song,'Per','Second');
    
    
    %% Rythm / BPM
    % [tmp p1]=mirtempo(song, 'Frame');
    % h1 = mirhisto(tmp)
    
    autocor=mirautocor(o);
    peaks=mirgetdata(o);
    peakRate=length(peaks)/secs;
    
    [pks, locs]=findpeaks(mirgetdata(autocor),'MinPeakHeight',0.15,'MinPeakDistance',10)
    if isempty(pks)
        periodicity=0;
    else
        periodicity=length(pks);
    end
    
    [tmp p1]=mirtempo(song, 'Max');
    tempoMax = mirgetdata(tmp);
    p1Max = mirgetdata(p1);
    
    
    spec= mirspectrum(song, 'Frame',0.023, 0.5, 'Terhardt', 'Bark', 'Mask', 'dB');
    peaksSpec= mirpeaks(spec);
    %         %Fluctuation - Manual!!
    %         f = mirspectrum(spec, 'AlongBands', 'Max', 10, 'Window', 0, 'Resonance', 'Fluctuation', 'NormalLength');
    %         sumFluctuation1=mirsum(f);
    
    %calculates the irregularity of a spectrum, i.e.,
    %the degree of variation of the successive peaks of the spectrum.
    %Specification of the definition of irregularity:
    peaksRegularity = mirregularity(peaksSpec);
    
    %% Spectral / Energy
    
    %spCentroid = mircentroid(spec)
    %spectralCentroid = mirgetdata(spCentroid); %novelty
    
    %MFCC
    m = mirmfcc(song,'Rank',1:3);
    MFCC=mirgetdata(m);
    
    
    % f = mirflux(x) measures distance between successive frames.
    %     First argument:
    %         If x is a spectrum, this corresponds to spectral flux.
    %         But the flux of any other data can be computed as well.
    %         If x is an audio file or audio signal, the spectral flux is
    %             computed by default.
    %    spectral change
    
    fl = mirflux(spec);
    flux=mirgetdata(fl);
    
    %rms = Root Mean Square Energy
    rms=mirrms(sg);
    
    
    % Brightness
    %A dual method consists in fixing this time the cut-off frequency, and measuring the amount of
    %energy above that frequency (Juslin, 2000). The result is expressed as a
    %number between 0  1
    br= mirbrightness(song,'CutOff',1000);
    
    rolloff = mirrolloff(sg);
    %rolloff = mirrolloff(s1);
    % disp('Ascending order of spectral roll-off...')
    % %mirplay(a,'Increasing',r,'Every',5)
    
    
    
    %% FEATURES:
    features(1,i) = zcPitch;
    features(2,i) = keyClarity; %->Info of Valence;
    features(3,i) = mirgetdata(zc);
    features(4,i) = mean(flux);
    features(5,i) = mean(mirgetdata(rms));
    features(6,i) =periodicity;
    features(7,i) = MFCC(1);
    features(8,i) =mean(mirgetdata(rolloff));
    
    features(9,i) =mirgetdata(br);
    features(10,i) = mean(mode); %->Info of Valence
    features(11,i) = peakRate;
    features(12,i) = envelopeCentroid;
    features(13,i) =std(mirgetdata(rms)); %Standard deviation of RMS along frames ->Info of Valence
    features(14,i) =mean(mirgetdata(peaksRegularity));
    features(15,i) =p1Max;%peaks
    %features(16,i) =max(mirgetdata(sumFluctuation1));%->Info of Valence
    %end
    
end
elapsedTime=toc
