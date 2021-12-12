function varargout = proba1(varargin)
% PROBA1 MATLAB code for proba1.fig
%      PROBA1, by itself, creates a new PROBA1 or raises the existing
%      singleton*.
%
%      H = PROBA1 returns the handle to a new PROBA1 or the handle to
%      the existing singleton*.
%
%      PROBA1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROBA1.M with the given input arguments.
%
%      PROBA1('Property','Value',...) creates a new PROBA1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before proba1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to proba1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help proba1

% Last Modified by GUIDE v2.5 08-Feb-2019 18:36:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @proba1_OpeningFcn, ...
                   'gui_OutputFcn',  @proba1_OutputFcn, ...
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


% --- Executes just before proba1 is made visible.
function proba1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to proba1 (see VARARGIN)


% Choose default command line output for proba1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes proba1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = proba1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(instrfind);
inicijaliziranje();
ugao = 0;
x0=0;
y0=0;
smjer = 1;
s='p';
axis(handles.axes1, [-50 50 -50 50])
hold on;
while (1) 
    d=0;
    a = fread(s1,1)
        if (a==65) 
            a = fread(s1,1)
            if (a==66) 
                smjer = smjer *(-1);
                if(smjer==-1)
                    s='n';
                else
                    s='p';
                end
                %clf(handles.axes1);
                
                hold off;
                a = fread(s1,1)
            end
            
            a = fread(s1,1)
            d=a;
            a = fread(s1,1)
            d=d+a/10.0;
            if (d>50)
                d=50;
            elseif(isempty(d))
                continue;
            end
            set(handles.edit2,'String', s); 
            x=x0+d*cos(ugao);
            y=y0+d*sin(ugao);
            if (x<50 || y<50)
                plot(handles.axes1, x, y, 'LineWidth', 25)
                set(handles.edit1,'String', d)
            else
                set(handles.edit1,'String', 50)
                plot(handles.axes1, 50, 50, 'LineWidth', 25)
            end
            axis(handles.axes1, [-50 50 -50 50])
            hold on;
            
            pause(0.1) 
            d=0;
            if (ugao>=360) 
                ugao=0;
            else
                ugao=ugao+12;
            end
        end
end 



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 set(handles.pushbutton1,'Visible','off');
%fclose(s1);




function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


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


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
