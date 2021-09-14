function varargout = operacionesSenales(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @operacionesSenales_OpeningFcn, ...
                   'gui_OutputFcn',  @operacionesSenales_OutputFcn, ...
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

% --- Executes just before operacionesSenales is made visible.
function operacionesSenales_OpeningFcn(hObject, eventdata, handles, varargin)


handles.output = hObject;

guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = operacionesSenales_OutputFcn(hObject, eventdata, handles) 


% Get default command line output from handles structure
varargout{1} = handles.output;

% Modificar la amplitud de la señal

function n1_Callback(hObject, eventdata, handles) 

function n1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Escalonamiento en el tiempo o inversion

function n2_Callback(hObject, eventdata, handles) 

function n2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Desplazamiento en el tiempo

function n3_Callback(hObject, eventdata, handles)

function n3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Desplazamiento en la variable dependiente

function n4_Callback(hObject, eventdata, handles)

function n4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% Frecuencia angular para la señal 1

function w1_Callback(hObject, eventdata, handles)


function w1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Desfase señal 1

function p1_Callback(hObject, eventdata, handles)

function p1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Frecuencia angular señal 2

function w2_Callback(hObject, eventdata, handles)

function w2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% Desfase señal 2 

function p2_Callback(hObject, eventdata, handles)

function p2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

botonAtras=uicontrol('Style','pushbutton', ...
'Units','normalized', ...
'Position',[.9 .015 .08 .05], ...
'String','Atras',...
'Callback','clear all; close;clc; TiposDeSenales;');

% SEÑALES BASICAS

%___________________________________________________________________________

% RAMPA
% --- Executes on button press in Rampa.
function Rampa_Callback(hObject, eventdata, handles)
x = linspace(-5,5);
b=str2num(get(handles.n3,'String'));
n=str2num(get(handles.n2,'String'));
c=str2num(get(handles.n4,'String'));
d=str2num(get(handles.n1,'String'));

y = (0.*((x*n) < b)+((x*n)+b).*((x*n) >= -b));
f=d*y+c;

if b < -5 | b > 5.1    
    errordlg('Por favor digite valores entre -5 y 5, En la casilla 3');
    return
end;
if c < -5 | c > 5    
    errordlg('Por favor digite valores entre -5 y 5, En la casilla 4');
    return
end;

pAp=' ';
set(handles.PAP,'String',pAp);

plot(x,f);
xlabel('t');
ylabel('X(t)');
title('Señal Rampa');
axis([-5 5 -5 5]);

hold on 
hold off

%___________________________________________________________________________

% SINUSOIDAL
function Sinusoidal_Callback(hObject, eventdata, handles)
t = -15*pi:0.001:15*pi;
W1=str2num( get(handles.w1,'String'));
W2=str2num(get(handles.w2,'String'));
P1=str2num(get(handles.p1,'String'));
P2=str2num(get(handles.p2,'String'));
A1=str2num(get(handles.a1,'String'));
A2=str2num(get(handles.a2,'String'));

%Señal sinusoidal 1
y1=A1*sin((W1.*t)+P1);

%Señal sinusoidal 2
y2=A2*sin((W2.*t)+P2);

V1=get(handles.sumaSeno,'value');
V2=get(handles.restaSeno,'value');

% Operación suma
if V1==1
y = y1+y2;
end; 

%Operacion resta
if V2==1
y = y1-y2;
end;

%Periodo señal 1
T1=(2*pi)/W1;

%Periodo señal 2
T2=(2*pi)/W2;

%Conversion de los periodos a numeros fraccionarios
[F1,F2]=rat(T1);
[F3,F4]=rat(T2);

%Calculo de periocidad
M=F1*F4;
N=F2*F3;
[m,n]=rat(M/N);

i=0;
ti=0:.01:m*T2;

Tt=m*T2;
Npi=Tt/pi;
if (m*T2)==(n*T1)
    if y==0
    pAp='La señal resultante es APERIODICA';
    else
        pAp = sprintf('    La señal resultante es PERIODICA y  el periodo (T) es %f' ,Tt);

plot(ti,i,'.y');
hold on

% Indca el periodo dentro de la grafica
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

plot(t,y1,'r');
hold on 
plot(t,y2,'b');
hold on 
plot(t,y,'.m');
hold on 

xlabel('t');
ylabel('X(t)');
title('Señal Sinusoidal');
axis([-30 30 -5 5]);

hold off

%___________________________________________________________________________

%PULSO UNITARIO
function Pulso_Callback(hObject, eventdata, handles)
x = linspace(-5,5);

b=str2num(get(handles.n3,'String'));
n=str2num(get(handles.n2,'String'));
c=str2num(get(handles.n4,'String'));
d=str2num(get(handles.n1,'String'));

y = (0.*((x*n) < -b)+1.*(((x*n) >= -b)&((x*n) <= (-b+1))) +0.*((x*n) > (-b+1)));
f=d*y+c;

if b < -5 | b > 5    
    errordlg('Por favor digite valores entre -5 y 5, En la casilla 3');
    return
end;
if c < -5 | c > 5    
    errordlg('Por favor digite valores entre -5 y 5, En la casilla 4');
    return
end;

pAp=' ';
set(handles.PAP,'String',pAp);

plot(x,f);
xlabel('t');
ylabel('X(t)');
title('Señal Pulso');
axis([-5 5 -5 5]);

hold on 
hold off

%___________________________________________________________________________
% ESCALON UNITARIO

function Escalon_Callback(hObject, eventdata, handles)
x = linspace(-5,5);

b=str2num(get(handles.n3,'String'));
n=str2num(get(handles.n2,'String'));
c=str2num(get(handles.n4,'String'));
d=str2num(get(handles.n1,'String'));

y = (0.*((x*n) < b)+1.*((x*n) >= -b));
f=d*y+c;

if b <= -5 | b >= 5    
    errordlg('Por favor digite valores entre -4.99 y 4.99, En la casilla 3');
    return
end;
if c <= -5 | c >= 5    
    errordlg('Por favor digite valores entre -5 y 5, En la casilla 4');
    return
end;

pAp=' ';
set(handles.PAP,'String',pAp);

plot(x,f);
xlabel('t');
ylabel('X(t)');
title('Señal Escalon');
axis([-5 5 -5 5]);

hold on 
hold off
%___________________________________________________________________________

% --- Executes during object creation, after setting all properties.
function restaSeno_CreateFcn(hObject, eventdata, handles)

handles.restaSeno=hObject;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function sumaSeno_CreateFcn(hObject, eventdata, handles)

handles.sumaSeno=hObject;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function panelSR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to panelSR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



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
