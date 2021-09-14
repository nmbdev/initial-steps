%Señales discretas
function varargout = SENALES_DISCRETAS(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SENALES_DISCRETAS_OpeningFcn, ...
                   'gui_OutputFcn',  @SENALES_DISCRETAS_OutputFcn, ...
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
%___________________________________________________________________________

% --- Executes just before SENALES_DISCRETAS is made visible.
function SENALES_DISCRETAS_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;


guidata(hObject, handles);

function varargout = SENALES_DISCRETAS_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

botonAtras=uicontrol('Style','pushbutton', ...
'Units','normalized', ...
'Position',[.9 .015 .08 .05], ...
'String','Atras',...
'Callback','clear all; close;clc; TiposDeSenales;');

% SEÑALES BASICAS
%___________________________________________________________________________

%RAMPA
function Rampa_Callback(hObject, eventdata, handles)
x = -5:1:5;
b=str2num(get(handles.n3,'String'));
n=str2num(get(handles.n2,'String'));
c=str2num(get(handles.n4,'String'));
d=str2num(get(handles.n1,'String'));

y = (0.*((x*n) < b)+((x*n)+b).*((x*n) >= -b));
f=d*y+c;

if b <= -5 | b >= 5    
    errordlg('Por favor digite valores entre -5 y 5, En la casilla 3');
    return
end;
if c <= -5 | c >= 5    
    errordlg('Por favor digite valores entre -5 y 5, En la casilla 4');
    return
end;

pAp=' ';
set(handles.PAP,'String',pAp);

stem(x,f);
xlabel('n');
ylabel('X[n]');
title('Señal Rampa');
axis([-5 5 -5 5]);

hold on 
hold off


%___________________________________________________________________________
% ESCALON UNITARIO
function Escalon_Callback(hObject, eventdata, handles)
x = -5:1:5;

b=str2num(get(handles.n3,'String'));
n=str2num(get(handles.n2,'String'));
c=str2num(get(handles.n4,'String'));
d=str2num(get(handles.n1,'String'));

y = (0.*((x*n) < b)+1.*((x*n) >= -b));
f=d*y+c;

if b <= -5 | b >= 5    
    errordlg('Por favor digite valores entre -5 y 5, En la casilla 3');
    return
end;
if c <= -5 | c >= 5    
    errordlg('Por favor digite valores entre -5 y 5, En la casilla 4');
    return
end;

pAp=' ';
set(handles.PAP,'String',pAp);

stem(x,f);
xlabel('n');
ylabel('X[n]');
title('Señal Escalon');
axis([-5 5 -5 5]);

hold on 
hold off


%___________________________________________________________________________

%PULSO UNITARIO
function Pulso_Callback(hObject, eventdata, handles)
x = -5:1:5;

b=str2num(get(handles.n3,'String'));
n=str2num(get(handles.n2,'String'));
c=str2num(get(handles.n4,'String'));
d=str2num(get(handles.n1,'String'));

y = (0.*((x*n) < -b)+1.*(((x*n) >= -b)&((x*n) <= (-b+1))) +0.*((x*n) > (-b+1)));
f=d*y+c;

if b <= -5 | b >= 5    
    errordlg('Por favor digite valores entre -5 y 5, En la casilla 3');
    return
end;
if c <= -5 | c >= 5    
    errordlg('Por favor digite valores entre -5 y 5, En la casilla 4');
    return
end;

pAp=' ';
set(handles.PAP,'String',pAp);

stem(x,f);
xlabel('n');
ylabel('X[n]');
title('Señal Pulso');
axis([-5 5 -5 5]);

hold on 
hold off

%___________________________________________________________________________

% SINUSOIDAL
function Sinusoidal_Callback(hObject, eventdata, handles)
t = -20:1:20;
W1=str2num( get(handles.w1,'String'));
W2=str2num(get(handles.w2,'String'));
P1=str2num(get(handles.p1,'String'));
P2=str2num(get(handles.p2,'String'));
A1=str2num(get(handles.a1,'String'));
A2=str2num(get(handles.a2,'String'));

y1=A1*sin((W1.*t)+P1);
y2=A2*sin((W2.*t)+P2);

V1=get(handles.sumaSeno,'value');
V2=get(handles.restaSeno,'value');

if V1==1
y = y1+y2;
end; 
if V2==1
y = y1-y2;
end;

T1=(2*pi)/W1;
T2=(2*pi)/W2;

[F1,F2]=rat(T1);
[F3,F4]=rat(T2);
M=F1*F4;
N=F2*F3;
[m,n]=rat(M/N);

i=0;
ti=0:.1:m*T2;

Tt=m*T2;
Npi=Tt/pi;

if (m*T2)==(n*T1)
    if y==0
    pAp='La señal resultante es APERIODICA';
    else
        pAp = sprintf('(en proceso de reforma) \n    La señal resultante es PERIODICA y  el periodo (T) es %f' ,Tt);

plot(ti,i,'.y');
hold on

text(0,-2,...
           ['    \uparrow      '...
            sprintf('\n\n'),...
            '  T=',sprintf('%i',Npi),...
            '\pi']);

end; 
end;

if (m*T2)~=(n*T1)
pAp='La señal resultante es APERIODICA';
end;

set(handles.PAP,'String',pAp);

stem(t,y1,'r');
hold on 
stem(t,y2,'b');
hold on 
stem(t,y,'g');
hold on 


xlabel('n');
ylabel('X(n)');
title('Señal Sinusoidal');
axis([-20 20 -5 5]);

hold off

%___________________________________________________________________________

function n1_Callback(hObject, eventdata, handles)
% hObject    handle to n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n1 as text
%        str2double(get(hObject,'String')) returns contents of n1 as a double


% --- Executes during object creation, after setting all properties.
function n1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function n2_Callback(hObject, eventdata, handles)
% hObject    handle to n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n2 as text
%        str2double(get(hObject,'String')) returns contents of n2 as a double


% --- Executes during object creation, after setting all properties.
function n2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n3_Callback(hObject, eventdata, handles)
% hObject    handle to n3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n3 as text
%        str2double(get(hObject,'String')) returns contents of n3 as a double


% --- Executes during object creation, after setting all properties.
function n3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n4_Callback(hObject, eventdata, handles)
% hObject    handle to n4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n4 as text
%        str2double(get(hObject,'String')) returns contents of n4 as a double


% --- Executes during object creation, after setting all properties.
function n4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a1_Callback(hObject, eventdata, handles)
% hObject    handle to a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a1 as text
%        str2double(get(hObject,'String')) returns contents of a1 as a double


% --- Executes during object creation, after setting all properties.
function a1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function w1_Callback(hObject, eventdata, handles)
% hObject    handle to w1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of w1 as text
%        str2double(get(hObject,'String')) returns contents of w1 as a double


% --- Executes during object creation, after setting all properties.
function w1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to w1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p1_Callback(hObject, eventdata, handles)
% hObject    handle to p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p1 as text
%        str2double(get(hObject,'String')) returns contents of p1 as a double


% --- Executes during object creation, after setting all properties.
function p1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n1 as text
%        str2double(get(hObject,'String')) returns contents of n1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a2_Callback(hObject, eventdata, handles)
% hObject    handle to a2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a2 as text
%        str2double(get(hObject,'String')) returns contents of a2 as a double


% --- Executes during object creation, after setting all properties.
function a2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p2_Callback(hObject, eventdata, handles)
% hObject    handle to p2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p2 as text
%        str2double(get(hObject,'String')) returns contents of p2 as a double


% --- Executes during object creation, after setting all properties.
function p2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function w2_Callback(hObject, eventdata, handles)
% hObject    handle to w2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of w2 as text
%        str2double(get(hObject,'String')) returns contents of w2 as a double


% --- Executes during object creation, after setting all properties.
function w2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to w2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
