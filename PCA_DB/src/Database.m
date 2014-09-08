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


function varargout = Database(varargin)
% DATABASE MATLAB code for Database.fig
%      DATABASE, by itself, creates a new DATABASE or raises the existing
%      singleton*.
%
%      H = DATABASE returns the handle to a new DATABASE or the handle to
%      the existing singleton*.
%
%      DATABASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATABASE.M with the given input arguments.
%
%      DATABASE('Property','Value',...) creates a new DATABASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Database_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Database_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Database

% Last Modified by GUIDE v2.5 27-Jun-2014 14:59:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Database_OpeningFcn, ...
                   'gui_OutputFcn',  @Database_OutputFcn, ...
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


% --- Executes just before Database is made visible.
function Database_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Database (see VARARGIN)

% Choose default command line output for Database
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axes(handles.axes2);
imshow('logo.jpg')

% UIWAIT makes Database wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Database_OutputFcn(hObject, eventdata, handles) 
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
global im_front
% vid = videoinput('winvideo',1);
% set(vid,'ReturnedColorSpace','RGB');
% im_front = getsnapshot(vid);
% imr = im_front; % input reference image
% b = .85; % auto contrast set to .85 later change according to room
% imr = imadjust(imr,[0 0 0; b b b],[]);
% im_front = imsharpen(imr); % image Shapen
[r,t] = uigetfile('*.jpg;*.png;*.jpeg;*.gif;*.tif');
i_front = strcat(t,r);
im_front = imread(i_front);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_back
% vid = videoinput('winvideo',1);
% set(vid,'ReturnedColorSpace','RGB');
% im_back = getsnapshot(vid);
% imr = im_back; % input reference image
% b = .85; % auto contrast set to .85 later change according to room
% imr = imadjust(imr,[0 0 0; b b b],[]); 
% im_back = imsharpen(imr); % image Shapen
[r,t] = uigetfile('*.jpg;*.png;*.jpeg;*.gif;*.tif');
i_back = strcat(t,r);
im_back = imread(i_back);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_front im_back product_number revision_number
f11 = strcat('C:\PCA_Database\',product_number,'/');
mkdir(f11);
f1 = strcat(f11,revision_number,'_front','.jpg');
f2 = strcat(f11,revision_number,'_back','.jpg');
imwrite(im_front,f1);
imwrite(im_back,f2);
close all;


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
global product_number
product_number = get(hObject,'String');


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


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
global revision_number
revision_number = get(hObject,'String');


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
