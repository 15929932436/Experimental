function varargout = signalprocess(varargin)
% SIGNALPROCESS MATLAB code for signalprocess.fig
%      SIGNALPROCESS, by itself, creates a new SIGNALPROCESS or raises the existing
%      singleton*.
%
%      H = SIGNALPROCESS returns the handle to a new SIGNALPROCESS or the handle to
%      the existing singleton*.
%
%      SIGNALPROCESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIGNALPROCESS.M with the given input arguments.
%
%      SIGNALPROCESS('Property','Value',...) creates a new SIGNALPROCESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before signalprocess_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to signalprocess_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help signalprocess

% Last Modified by GUIDE v2.5 01-Jul-2022 17:19:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @signalprocess_OpeningFcn, ...
                   'gui_OutputFcn',  @signalprocess_OutputFcn, ...
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


% --- Executes just before signalprocess is made visible.
function signalprocess_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to signalprocess (see VARARGIN)

% Choose default command line output for signalprocess
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes signalprocess wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global b key
b = 0;
key = 1;
figurePic(handles, b, key)

function gt = RC(t_Ts,a)    %a代表滚降系数
%RC generate raised-cosine pulse shape     %产生升余弦脉冲信号
sinc_t=sinc(t_Ts);         %sinc函数
rc_tnum=cos(pi*a*t_Ts);    %产生分子分母
rc_tden=1-(2*a*t_Ts).^2;
pn= abs(rc_tden)<1e-8;
rc_tden(pn)=inf;
rc_t=rc_tnum./rc_tden;
gt=sinc_t.*rc_t;

function figurePic(handles, b, key)
global tmpLine1  tmpLine area
axes(handles.axes1);
delete(tmpLine1);
delete(tmpLine);
delete(area);
x=-2:0.001:2;
fs = 1/ 0.001;
y=sin(2*pi*b.*x);
tmpLine1 = line(x, y, 'linewidth', 1);
set(tmpLine1, 'color', 'k');
axis([-2 2 -1.5 1.5]);
grid on;
hold on;

% 方波信号或升余弦信号
if key == 1
    window = heaviside(x + 1) - heaviside(x - 1);
    tmpLine = line(x, window, 'linewidth', 1);
    set(tmpLine, 'LineStyle', '--');
    set(tmpLine, 'color', 'b');
    window2 = 0 - window;
    area = fill([x fliplr(x)],[window fliplr(window2)],'b','edgealpha', '0', 'facealpha', '.1');
else
    window = RC(x, 1.1);
    tmpLine = line(x, window, 'linewidth', 1);
    set(tmpLine, 'LineStyle', '--');
    set(tmpLine, 'color', 'r');
    window2 = 0 - window;
    area = fill([x fliplr(x)],[window fliplr(window2)],'r','edgealpha', '0', 'facealpha', '.1');
end
hold off;

% 窗函数频谱
axes(handles.axes2);
N = 10240;
window_fft_result = fftshift(abs(fft(window, N)));
max_window_fft_result = max(window_fft_result);
freq = linspace(-fs/2, fs/2, N);
plot(freq, window_fft_result ./ max_window_fft_result, 'linewidth', 1);
axis([-20, 20, 0, 1.2]); 
grid on;

% 调制信号频谱
axes(handles.axes3);
fft_result = fftshift(abs(fft(y .* window, N)));
max_fft_result = max(fft_result);
if max_fft_result == 0
    fft_result = window_fft_result;
    max_fft_result = max_window_fft_result;
end
plot(freq, fft_result ./ max_fft_result, 'linewidth', 1);
axis([-20, 20, 0, 1.2]); 
grid on;

% --- Outputs from this function are returned to the command line.
function varargout = signalprocess_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when selected object is changed in uipanel2.
function uipanel2_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel2 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
Tag=get(hObject,'tag');
global key b
switch Tag
    case 'radiobutton1'
        key=1;
    case 'radiobutton2'
        key=2;
end
figurePic(handles, b, key);

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%time band

global key b
b=get(handles.slider2,'value');
text = num2str(b);
set(handles.edit2,'string', text);
figurePic(handles, b, key);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
global key b
b=str2double(get(hObject,'String'));
set(handles.slider2,'Value', b);
figurePic(handles, b, key);


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
