function varargout = recover(varargin)
% RECOVER MATLAB code for recover.fig
%      RECOVER, by itself, creates a new RECOVER or raises the existing
%      singleton*.
%
%      H = RECOVER returns the handle to a new RECOVER or the handle to
%      the existing singleton*.
%
%      RECOVER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECOVER.M with the given input arguments.
%
%      RECOVER('Property','Value',...) creates a new RECOVER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before recover_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to recover_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help recover

% Last Modified by GUIDE v2.5 06-Jul-2022 09:44:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @recover_OpeningFcn, ...
                   'gui_OutputFcn',  @recover_OutputFcn, ...
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


% --- Executes just before recover is made visible.
function recover_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to recover (see VARARGIN)
setappdata(handles.sample_recover, 'sample_freq', 1600);

% Choose default command line output for recover
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% ±»³éÐÅºÅ
axes(handles.axes1);
dt = 0.0001;
x = 0 : dt : 0.06;
y = cos(320 * x);
line(x, y, 'linewidth', 1);
% ±»³éÐÅºÅÆµÆ×
axes(handles.axes2);
signalFreqN = -2000 : 2000;
signalFreq = zeros(1, 4001);
plot(signalFreqN, signalFreq, ':');
hold on;
signalFreq([1681 2321]) = [1/2 1/2];

stem1 = stem(signalFreqN(1681), signalFreq(1681), 'm');
stem1.Marker = '^';
stem1.MarkerSize = 4;
stem1.MarkerFaceColor = 'm';
stem1.LineWidth = 1;
stem2 = stem(signalFreqN(2321), signalFreq(2321), 'b');
stem2.Marker = '^';
stem2.MarkerSize = 4;
stem2.MarkerFaceColor = 'b';
stem2.LineWidth = 1;

figOtherPic(handles, 1600);

% --- Outputs from this function are returned to the command line.
function varargout = recover_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function sample_freq_slider_Callback(hObject, eventdata, handles)
% hObject    handle to sample_freq_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(hObject, 'Value');
set(handles.sample_freq_edit, 'String', num2str(round(val)));
figOtherPic(handles, val);


% --- Executes during object creation, after setting all properties.
function sample_freq_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sample_freq_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function sample_freq_edit_Callback(hObject, eventdata, handles)
% hObject    handle to sample_freq_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(hObject, 'String');
set(handles.sample_freq_slider, 'Value', str2double(val));
figOtherPic(handles, str2double(val));
% Hints: get(hObject,'String') returns contents of sample_freq_edit as text
%        str2double(get(hObject,'String')) returns contents of sample_freq_edit as a double


% --- Executes during object creation, after setting all properties.
function sample_freq_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sample_freq_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in play2.
function play2_Callback(hObject, eventdata, handles)
% hObject    handle to play2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
signalFreqN = getappdata(handles.sample_recover, 'signalFreqN');
recoverFreq = getappdata(handles.sample_recover, 'recoverFreq');
dt = 0.001;
x = 0 : dt : 2;
% »æÖÆ»Ö¸´ÐÅºÅ
recover_y = recoverFreq(1) * exp(1i * signalFreqN(1) * x);
for index = 2 : 4001
    if recoverFreq(index) > 0
        recover_y = recover_y + recoverFreq(index) * exp(1i * signalFreqN(index) * x);
    end
end
sound(real(recover_y));


% --- Executes on button press in play1.
function play1_Callback(hObject, eventdata, handles)
x = 0 : 0.001 : 2;
sound(cos(320 * x));

function figOtherPic(handles, val)
axes(handles.axes3);
hold off
dt = 0.0001;
x = 0 : dt : 0.06;
y = cos(320 * x);
sampleLine = line(x, y, 'linewidth', 1);
set(sampleLine, 'LineStyle', '--');
set(sampleLine, 'color', 'k');
hold on
sampleStem = getappdata(handles.sample_recover, 'sampleStem');
delete(sampleStem);
ws = val;
fs = ws / (2 * pi);
t = 0 : 1/fs : 0.06;
A = cos(320 * t);
N = length(t);
sampleStem = zeros(1, N);
for index = 1 : N
    tmpStem = stem(t(index), A(index), 'r');
    if A(index) > 0
        tmpStem.Marker = '^';
    else
        tmpStem.Marker = 'v';
    end
    tmpStem.MarkerSize = 4;
    tmpStem.MarkerFaceColor = 'r';
    tmpStem.LineWidth = 1;
    sampleStem(index) = tmpStem;
end
setappdata(handles.sample_recover, 'sampleStem', sampleStem);

% ³éÑùÐÅºÅµÄÆµÆ×
axes(handles.axes4);
hold off
signalFreqN = -2000 : 2000;
signalFreq = zeros(1, 4001);
plot(signalFreqN, signalFreq, ':');
hold on;
sampleFreq = zeros(1, 4001);
stem1s = zeros(1, 21);
index = 1;
for k = -10 : 10
    freq1 =  1681 + k * ws;
    if freq1 < 0 || freq1 > 4001
        continue
    end
    freq1 = round(freq1);
    sampleFreq(freq1) = sampleFreq(freq1) + 1/2;
    stem1 = stem(signalFreqN(freq1), sampleFreq(freq1), 'm');
    stem1.Marker = '^';
    stem1.MarkerSize = 4;
    stem1.MarkerFaceColor = 'm';
    stem1.LineWidth = 1;
    stem1s(index) = stem1;
    index = index + 1;
end
for k = -10 : 10
    freq2 =  2321 + k * ws;
    if freq2 < 0 || freq2 > 4001
        continue
    end
    freq2 = round(freq2);
    if sampleFreq(freq2) > 0 && ~isempty(stem1s)
        delete(stem1s);
        stem1s = [];
    end
    sampleFreq(freq2) = sampleFreq(freq2) + 1/2;
    stem2 = stem(signalFreqN(freq2), sampleFreq(freq2), 'b');
    stem2.Marker = '^';
    stem2.MarkerSize = 4;
    stem2.MarkerFaceColor = 'b';
    stem2.LineWidth = 1;
end

% LP = heaviside(signalFreqN + 750) - heaviside(signalFreqN - 750);
LP = RealLp(350, 650);
plot(signalFreqN, LP, '--', 'linewidth', 1);
axis([-2000 2000 0 1.2]);

% »Ö¸´ÐÅºÅÆµÆ×
axes(handles.axes6);
hold off;
signalFreq = zeros(1, 4001);
plot(signalFreqN, signalFreq, ':');
hold on;
recoverFreq = sampleFreq .* LP;
for index = 1 : 4001
    if (recoverFreq(index) > 0)
        stem2 = stem(signalFreqN(index), recoverFreq(index), 'b');
        stem2.Marker = '^';
        stem2.MarkerSize = 4;
        stem2.MarkerFaceColor = 'b';
        stem2.LineWidth = 1;
    end 
end
setappdata(handles.sample_recover, 'signalFreqN', signalFreqN);
setappdata(handles.sample_recover, 'recoverFreq', recoverFreq);
% »Ö¸´ÐÅºÅ
axes(handles.axes5);
hold off
dt = 0.0001;
x = 0 : dt : 0.06;
% »æÖÆ»Ö¸´ÐÅºÅ
recover_y = recoverFreq(1) * exp(1i * signalFreqN(1) * x);
for index = 2 : 4001
    if recoverFreq(index) > 0
        recover_y = recover_y + recoverFreq(index) * exp(1i * signalFreqN(index) * x);
    end
end
reLine = getappdata(handles.sample_recover, 'reLine');
sLine = getappdata(handles.sample_recover, 'sLine');
delete(reLine);
delete(sLine);

reLine = line(x, real(recover_y), 'linewidth', 1);
set(reLine, 'color', 'k');
hold on;
y = cos(320 * x);
sLine = line(x, y, 'linewidth', 1);
set(sLine, 'LineStyle', '--');
set(sLine, 'color', 'r');
legend('»Ö¸´ÐÅºÅ', '±»³éÐÅºÅ');
setappdata(handles.sample_recover, 'reLine', reLine);
setappdata(handles.sample_recover, 'sLine', sLine);


function window = RealLp(wp, ws)
Rp = 2;
As = 30;
[N,wc] = buttord(wp,ws,Rp,As,'s');
[B,A] = butter(N,wc,'s');
k = 0:511;
wk = 0  : 2000;
Hk = freqs(B,A,wk);

abs_HK = abs(Hk);
OK_HK = zeros(1, 4001);
for i = 1 :4001
    index = abs(2002 - i);
    if i >= 2002
        index = index + 2;
    end
    OK_HK(i) = abs_HK(index);
end
window = OK_HK;
