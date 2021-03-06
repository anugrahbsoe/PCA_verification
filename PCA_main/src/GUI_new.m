% Copyright 2014 RaviTeja Peddi and Theja Kanumury
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>. 

function varargout = GUI_new(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 27-Jun-2014 11:43:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axes(handles.axes1);
imshow('logo.jpg')

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global product_number revision_number take_front take_back
front_image = strcat('C:\PCA_Verification\',product_number,'\',revision_number,'_front','.jpg');
back_image = strcat('C:\PCA_Verification\',product_number,'\',revision_number,'_back','.jpg');
im_front = imread(front_image);
im_back = imread(back_image);
close all;

% ip-imr,imc op-imc changed to allign with imr
imr = im_front; 
imc = take_front;
figure, imagesc(imr);
[x1,y1]=ginput(2); % give 2 mouse clicks at same points on different images
figure, imagesc(imc);
[x2,y2] = ginput(2); % give 2 mouse clicks at same points on different images
diffx = x1-x2;
diffy = y1-y2;
dx = mean(diffx);
dy = mean(diffy);
nrow = round(dy);
ncol = round(dx);
take_front = circshift(imc,[nrow ncol]);

% ip-imr,imc op-imc changed to allign with imr
imr = im_back; 
imc = take_back;
figure, imagesc(imr);
[x1,y1] = ginput(2); % give 2 mouse clicks at same points on different images
figure, imagesc(imc);
[x2,y2] = ginput(2); % give 2 mouse clicks at same points on different images
diffx = x1-x2;
diffy = y1-y2;
dx = mean(diffx);
dy = mean(diffy);
nrow = round(dy);
ncol = round(dx);
take_back = circshift(imc,[nrow ncol]);

figure, imshowpair(im_front,take_front);
figure, imshowpair(im_back,take_back);


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global take_front
% vid = videoinput('winvideo',1);
% set(vid,'ReturnedColorSpace','RGB');
% take_front = getsnapshot(vid);
[r,t] = uigetfile('*.jpg;*.png;*.jpeg;*.gif;*.tif');
front = strcat(t,r);
take_front = imread(front);
b = .85; % auto contrast set to .85 later change according to room
take_front = imadjust(take_front,[0 0 0; b b b],[]);
take_front = imsharpen(take_front); % image Sharpen


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global take_back
% vid = videoinput('winvideo',1);
% set(vid,'ReturnedColorSpace','RGB');
% take_back = getsnapshot(vid);
[r,t] = uigetfile('*.jpg;*.png;*.jpeg;*.gif;*.tif');
back = strcat(t,r);
take_back = imread(back);
b = .85; % auto contrast set to .85 later change according to room
take_back = imadjust(take_back,[0 0 0; b b b],[]);
take_back = imsharpen(take_back); % image Shapen


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
global product_number
product_number = get(hObject,'String');


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


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
global revision_number
revision_number = get(hObject,'String');


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
