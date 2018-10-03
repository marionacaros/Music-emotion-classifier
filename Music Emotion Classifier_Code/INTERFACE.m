function varargout = INTERFACE(varargin)
% INTERFACE MATLAB code for INTERFACE.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE.M with the given input arguments.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before INTERFACE_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to INTERFACE_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help INTERFACE

% Last Modified by GUIDE v2.5 24-Dec-2016 02:52:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @INTERFACE_OpeningFcn, ...
                   'gui_OutputFcn',  @INTERFACE_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before INTERFACE is made visible.
function INTERFACE_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to INTERFACE (see VARARGIN)

% Choose default command line output for INTERFACE
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%Buttons send and delete disabled
set(handles.aggressiveBt,'enable','on');
set(handles.sadBt,'enable','on');
set(handles.happyBt,'enable','on');
set(handles.chillBt,'enable','on');

set(handles.analyseAllBt,'enable','off');
set(handles.plotBt,'enable','off');
set(handles.playBt,'enable','off');
set(handles.stopBt,'enable','off');
set(handles.analyseBt,'enable','off');
set(handles.findBt,'enable','off');


% UIWAIT makes INTERFACE wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = INTERFACE_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function editTextURL_Callback(hObject, eventdata, handles)
% hObject    handle to editTextURL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.addBt,'enable','on');
% Hints: get(hObject,'String') returns contents of editTextURL as text
%        str2double(get(hObject,'String')) returns contents of editTextURL as a double


% --- Executes during object creation, after setting all properties.
function editTextURL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTextURL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in addBt.
function addBt_Callback(hObject, eventdata, handles)
% hObject    handle to addBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path=get(handles.editTextURL,'String');

if(~isempty(path))
    set(handles.analyseAllBt,'enable','on');
    set(handles.playBt,'enable','on');
    set(handles.stopBt,'enable','on');
    
    %Show music files in Listbox
    musicFiles = dir( fullfile(path,'*.mp3') );
    musicFiles = {musicFiles.name}';                      % file names
    set(handles.listSongs, 'string', musicFiles);
end


% --- Executes on button press in analyseAllBt.
function analyseAllBt_Callback(hObject, eventdata, handles)
% hObject    handle to analyseAllBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
features= musicFromFolder(get(handles.editTextURL,'String'));
[iterations,centroids, labels, featuresDB]=kmeans(features);
save('labels1','labels')
set(handles.plotBt,'enable','on');
set(handles.sadBt,'enable','on');
set(handles.happyBt,'enable','on');
set(handles.aggressiveBt,'enable','on');
set(handles.chillBt,'enable','on');
set(handles.analyseBt,'enable','on');
handles.output = hObject;
handles.featuresDB=featuresDB;
handles.labels=labels;
handles.centroids=centroids;
guidata(hObject, handles);


% --- Executes on button press in plotBt.
function plotBt_Callback(hObject, eventdata, handles)
% hObject    handle to plotBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clustersPlot( handles.centroids,handles.labels,handles.featuresDB,'');

% --- Executes on selection change in listSongs.
function listSongs_Callback(hObject, eventdata, handles)
% hObject    handle to listSongs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listSongs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listSongs


% --- Executes during object creation, after setting all properties.
function listSongs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listSongs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in playBt.
function playBt_Callback(hObject, eventdata, handles)
% hObject    handle to playBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
numFile=get(handles.listSongs,'Value') %Return number of file
musicFiles = cellstr(get(handles.listSongs,'String'));
PathName=get(handles.editTextURL,'String');
addpath(PathName);
song=musicFiles{numFile};
[x,Fs] = audioread(song);
sound(x,Fs);


% --- Executes on button press in stopBt.
function stopBt_Callback(hObject, eventdata, handles)
% hObject    handle to stopBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear sound;


% --- Executes on button press in happyBt.
function happyBt_Callback(hObject, eventdata, handles)
% hObject    handle to happyBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path=get(handles.editTextURL,'String');
if(~isempty(path))
    set(handles.analyseAllBt,'enable','on');
    set(handles.playBt,'enable','on');
    set(handles.stopBt,'enable','on');
    musicFiles = dir( fullfile(path,'*.mp3') );
    musicFiles = {musicFiles.name}';                      % file names
end
    nfiles=length(musicFiles);
    j=1;
for i=1:nfiles   
    if(handles.labels(i)==2)
    songs(j)=musicFiles(i);
    j=j+1;
    end
end
if(isempty(songs))==0
    list=get(handles.listSongs,'String');
    new_list = setdiff(list,songs)
    new_list_size = size(new_list)
    new_val = new_list_size(1,1)
    set(handles.listSongs,'Value',new_val)    
    set(handles.listSongs, 'string', songs);
end

% --- Executes on button press in sadBt.
function sadBt_Callback(hObject, eventdata, handles)
% hObject    handle to sadBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path=get(handles.editTextURL,'String');
if(~isempty(path))
    set(handles.analyseAllBt,'enable','on');
    set(handles.playBt,'enable','on');
    set(handles.stopBt,'enable','on');
    musicFiles = dir( fullfile(path,'*.mp3') );
    musicFiles = {musicFiles.name}';                      % file names
end
    nfiles=length(musicFiles);
    j=1;
for i=1:nfiles   
    if(handles.labels(i)==1)
    songs(j)=musicFiles(i);
    j=j+1;
    end
end
if(isempty(songs))==0
    list=get(handles.listSongs,'String');
    new_list = setdiff(list,songs)
    new_list_size = size(new_list)
    new_val = new_list_size(1,1)
    set(handles.listSongs,'Value',new_val)    
    set(handles.listSongs, 'string', songs);
end

    


% --- Executes on button press in aggressiveBt.
function aggressiveBt_Callback(hObject, eventdata, handles)
% hObject    handle to aggressiveBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path=get(handles.editTextURL,'String');
if(~isempty(path))
    set(handles.analyseAllBt,'enable','on');
    set(handles.playBt,'enable','on');
    set(handles.stopBt,'enable','on');
    musicFiles = dir( fullfile(path,'*.mp3') );
    musicFiles = {musicFiles.name}';                      % file names
end
    nfiles=length(musicFiles);
    j=1;
for i=1:nfiles   
    if(handles.labels(i)==4)
    songs(j)=musicFiles(i);
    j=j+1;
    end
end
if(isempty(songs))==0
    list=get(handles.listSongs,'String');
    new_list = setdiff(list,songs)
    new_list_size = size(new_list)
    new_val = new_list_size(1,1)
    set(handles.listSongs,'Value',new_val)    
    set(handles.listSongs, 'string', songs);
end


% --- Executes on button press in happyBt.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to happyBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in chillBt.
function chillBt_Callback(hObject, eventdata, handles)
% hObject    handle to chillBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path=get(handles.editTextURL,'String');
if(~isempty(path))
    set(handles.analyseAllBt,'enable','on');
    set(handles.playBt,'enable','on');
    set(handles.stopBt,'enable','on');
    musicFiles = dir( fullfile(path,'*.mp3') );
    musicFiles = {musicFiles.name}';                      % file names
end
    nfiles=length(musicFiles);
    j=1;
for i=1:nfiles   
    if(handles.labels(i)==3)
    songs(j)=musicFiles(i);
    j=j+1;
    end
end
if(isempty(songs))==0
    list=get(handles.listSongs,'String');
    new_list = setdiff(list,songs)
    new_list_size = size(new_list)
    new_val = new_list_size(1,1)
    set(handles.listSongs,'Value',new_val)    
    set(handles.listSongs, 'string', songs);
end



% --- Executes on button press in analyseBt.
function analyseBt_Callback(hObject, eventdata, handles)
% hObject    handle to analyseBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
numFile=get(handles.listSongs,'Value') %Return number of file
musicFiles = cellstr(get(handles.listSongs,'String'));
PathName=get(handles.editTextURL,'String');
addpath(PathName);
song=musicFiles{numFile};
features = songAnalyser( song,PathName );
[iterations,centroids, labels, DB]=kmeans(features);
set(handles.findBt,'enable','on');
handles.output = hObject;
handles.song=song;
handles.labels=labels;
handles.centroid=centroid;
guidata(hObject, handles);





% --- Executes on button press in findBt.
function findBt_Callback(hObject, eventdata, handles)
% hObject    handle to findBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
numFile=get(handles.listSongs,'Value') %Return number of file
musicFiles = cellstr(get(handles.listSongs,'String'));
PathName=get(handles.editTextURL,'String');
addpath(PathName);
song=musicFiles{numFile};
featuresExtractionShow(song,PathName)

