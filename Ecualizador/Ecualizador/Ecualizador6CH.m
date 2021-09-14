function varargout = Ecualizador6CH(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Ecualizador6CH_OpeningFcn, ...
                   'gui_OutputFcn',  @Ecualizador6CH_OutputFcn, ...
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

function Ecualizador6CH_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);
%__________________________________________________________________________
[Fondo map] = imread('fondo.jpg','jpg');
axes(handles.imgFondoEcualizador)
image(Fondo),colormap(map);
axis off

text(280,17,'Ecualizador Pasa-Bandas de 6 Canales','Fontname', ...
'Times New Roman','Fontangle','normal','Fontweight','Bold', ...
'Fontsize',30,'color',[1 1 1]);

botonAtras = uicontrol('Style','pushbutton', ...
'Units','normalized', ...
'Position',[.91 .02 .08 .03], ...
'String','ATRÁS',...
'Callback','clear all; close;clc; InicioE6CH;');
%__________________________________________________________________________

function varargout = Ecualizador6CH_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


%0dB____________________________________________________________________________________________________________________________________________
function cero_dB_Callback(hObject, eventdata, handles)

set(handles.SliderSubwoofer,'Value',0);
set(handles.SliderBass,'Value',0);
set(handles.SliderLowerhalf,'Value',0);
set(handles.SliderMidhigh,'Value',0);
set(handles.SliderPresence,'Value',0);
set(handles.SliderGloss,'Value',0);


%Cargar Sonido___________________________________________________________________________________________________________________________________

function CargarSonido_Callback(hObject, eventdata, handles)

global SOriginal Fsd
[msgC mMSC] = imread('cter.jpg','jpg');

axes(handles.imgEspectroOriginal),title(' '),xlabel(' ');
cla;
axis on;
set(gca,'xtick',[],'ytick',[]);

axes(handles.imgEspectroModificado),title(' '),xlabel(' ');
cla;
axis on;
set(gca,'xtick',[],'ytick',[]);
 
nombreAudio=uigetfile('*.wav','Selección de una señal de audio');
%[SOriginal,Fsd]=wavread(nombreAudio); %MatLab 2012
[SOriginal,Fsd]=audioread(nombreAudio); %MatLab 2015
if nombreAudio == 0;
    return
else
    if nombreAudio ~= 0;
        set(handles.nombreSonido,'String',nombreAudio);
        axes(handles.imgEspectroOriginal);    
        plot(SOriginal);
        title(sprintf('Señal de Sonido Original\n'),'Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
        xlabel('Tiempo (s)','Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
        ylabel('Amplitud','Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
  
        grid on; 
        axis on;        
        msgbox({'                       ¡Sonido cargado exitosamene!'...
                   ,'Para reproducir, seleccione una opción del panel Reproducir sonido'...
                   ,'                     y posteriormente el botón Play.'...
                   ,'Para ecualizar la señal, modifique la ganancia de dBs con los slider'...
                   ,'           y posteriormente presione el boton Ecualizar.'}...
                   ,'Grabacion terminad','custom', msgC, mMSC);
            
    end;
end;

     
    

%Grabar Sonido___________________________________________________________________________________________________________________________________
function GrabarSonido_Callback(hObject, eventdata, handles)

global Fsd SOriginal
[msgG mMSG] = imread('gter.jpg','jpg');
t=str2double(get(handles.tiempoIn,'String'));
Fsd=44100;              %agragado MatLab 2015
SOrg=0;

if t <= 0;    
    errordlg('Por favor ingrese el tiempo entre 1 y 60 segundos.');
    return
else
    if t>600;
        errordlg('Por favor ingrese el tiempo entre 1 y 60 segundos.');
        return
    else
        if t>=1 && t<=600;
            axes(handles.imgEspectroOriginal),title(' '),xlabel(' ');
            cla;
            axis on;
            set(gca,'xtick',[],'ytick',[]);
            
            axes(handles.imgEspectroModificado),title(' '),xlabel(' ');
            cla;
            axis on;
            set(gca,'xtick',[],'ytick',[]);
            
           %SOrg = wavrecord(t*Fsd,Fsd,'int16');        %MatLab 2012
            SOrg = audiorecorder(Fsd,16,2);              %MatLab 2015
            recordblocking(SOrg,t);                     %agragado MatLab 2015
            SOriginal = getaudiodata(SOrg);             %agragado MatLab 2015
           %SOriginal = SOrg                            %MatLab 2012
           %wavwrite(SOriginal,Fsd,'AudioREC.wav');     %MatLab 2012
            audiowrite('AudioREC.wav',SOriginal,Fsd);   %Matlab 2015
            set(handles.nombreSonido,'String','AudioREC.wav ');
                                   
            
            axes(handles.imgEspectroOriginal);    
            plot(SOriginal);
            title(sprintf('Señal de Sonido Original\n'),'Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
            xlabel('Tiempo (s)','Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
            ylabel('Amplitud','Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
            
            grid on; 
            axis on;
           
            msgbox({'                       ¡Sonido grabado exitosamene!'...
                   ,'Para reproducir, seleccione una opción del panel Reproducir sonido'...
                   ,'                  y posteriormente presione el botón Play.'...
                   ,'Para ecualizar la señal, modifique la ganancia de dBs con los slider'...
                   ,'               y posteriormente presione el boton Ecualizar.'}...
                   ,'Grabacion terminad','custom', msgG, mMSG);
            %[SOriginal Fsd] = wavread('AudioREC.wav'); %MatLab 2012
            [SOriginal Fsd] = audioread('AudioREC.wav'); %MatLab 2015
                        
        end;
    end;
end;


%Play____________________________________________________________________________________________________________________________________________
function Play_Callback(hObject, eventdata, handles)
global P SOriginal SModificado
Fs = 44100;
switch P
    case 1        
        sound(SOriginal,Fs);
    case 2       
        sound(SModificado,Fs);             
end;
        

%Panel Reproducir Sonido___________________________________________________
function RepSonido_SelectionChangeFcn(hObject, eventdata, handles)
global P
switch get(eventdata.NewValue,'Tag');
    case 'RBSonidoOriginal'       
        P=1;        
    case 'RBSonidoModificado'
        P=2;
end;
         
%_________________________________________________________________________||_____________________________________________________________________
%Ecualizador_____________________________________________________________________________________________________________________________________
%_________________________________________________________________________||_____________________________________________________________________

function ecualizador_Callback(hObject, eventdata, handles)

global SOriginal SModificado EOriginal EModificado 

%se obtiene la posicion de cada slider
g1 = get(handles.SliderSubwoofer, 'value');
g2 = get(handles.SliderBass, 'value');
g3 = get(handles.SliderLowerhalf, 'value');
g4 = get(handles.SliderMidhigh, 'value');
g5 = get(handles.SliderPresence, 'value');
g6 = get(handles.SliderGloss, 'value');

%Ganancia en decibeles de cada slider
dB1 = 10^(g1/10);
dB2 = 10^(g2/10);
dB3 = 10^(g3/10);
dB4 = 10^(g4/10);
dB5 = 10^(g5/10);
dB6 = 10^(g6/10);

     
%_____Subwoofer(16-60Hz)___________________________________________________

Fs = 64000;  % Sampling Frequency

N   = 100;   % Order
Fc1 = 16;  % First Cutoff Frequency
Fc2 = 60;  % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
hSubwoofer  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
HdSubwoofer = design(hSubwoofer, 'butter');
filtradoSubwoofer = dB1*filter(HdSubwoofer, SOriginal);

%_____Bass(60-250Hz)_______________________________________________________

Fs = 64000;  % Sampling Frequency

N   = 100;    % Order
Fc1 = 60;   % First Cutoff Frequency
Fc2 = 250;  % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
hBass  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
HdBass = design(hBass, 'butter');
filtradoBass = dB2*filter(HdBass, SOriginal);

%_____Lower Half(250-2000Hz)_______________________________________________

Fs = 64000;  % Sampling Frequency

N   = 100;     % Order
Fc1 = 250;   % First Cutoff Frequency
Fc2 = 2000;  % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
hLowerHalf  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
HdLowerHalf = design(hLowerHalf, 'butter');
filtradoLowerHalf = dB3*filter(HdLowerHalf, SOriginal);


%_____Mid-High(2-4KHz)_____________________________________________________

Fs = 64000;  % Sampling Frequency

N   = 100;     % Order
Fc1 = 2000;  % First Cutoff Frequency
Fc2 = 4000;  % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
hMidHigh  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
HdMidHigh = design(hMidHigh, 'butter');
filtradoMidHigh = dB4*filter(HdMidHigh, SOriginal);

%_____Presence(4-6KHz)_____________________________________________________

Fs = 64000;  % Sampling Frequency

N   = 100;     % Order
Fc1 = 4000;  % First Cutoff Frequency
Fc2 = 6000;  % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
hPresence  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
HdPresence = design(hPresence, 'butter');
filtradoPresence = dB5*filter(HdPresence, SOriginal);

%_____Gloss(6-16KHz)_______________________________________________________

Fs = 64000;  % Sampling Frequency

N   = 100;      % Order
Fc1 = 6000;   % First Cutoff Frequency
Fc2 = 16000;  % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
hGloss  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
HdGloss = design(hGloss, 'butter');
filtradoGloss = dB6*filter(HdGloss, SOriginal);
%__________________________________________________________________________

SModificado = filtradoSubwoofer + filtradoBass ...
             +filtradoLowerHalf + filtradoMidHigh ...
             +filtradoPresence  + filtradoGloss;
         
         
EOriginal = fft(SOriginal);
PSenalO = EOriginal.*conj(EOriginal);
FBandO = (1:20000);
axes(handles.imgEspectroOriginal);
plot(FBandO,PSenalO(1:20000));
title(sprintf('Espectro Original\n'),'Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
xlabel('Frecuencia (Hz)','Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
grid on;


EModificado = fft(SModificado);
PSenalM = EModificado.*conj(EModificado);
FBandM = (1:20000);
axes(handles.imgEspectroModificado);
plot(FBandM,PSenalM(1:20000));
title(sprintf('Espectro Modificado\n'),'Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
xlabel('Frecuencia (Hz)','Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
grid on;      
     



%________________________________________________________________________________________________________________________________________________

%--------------------------------------------------------------------------Slider----------------------------------------------------------------
function SliderSubwoofer_Callback(hObject, eventdata, handles)


function SliderSubwoofer_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%__________________________________________________________________________

function SliderBass_Callback(hObject, eventdata, handles)

function SliderBass_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%__________________________________________________________________________

function SliderGloss_Callback(hObject, eventdata, handles)

function SliderGloss_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%__________________________________________________________________________


function SliderLowerhalf_Callback(hObject, eventdata, handles)

function SliderLowerhalf_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%__________________________________________________________________________


function SliderMidhigh_Callback(hObject, eventdata, handles)

function SliderMidhigh_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%__________________________________________________________________________


function SliderPresence_Callback(hObject, eventdata, handles)

function SliderPresence_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%__________________________________________________________________________

%tiempo de entrada_______________________________________________________________________________________________________________________________
function tiempoIn_Callback(hObject, eventdata, handles)

function tiempoIn_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%__________________________________________________________________________
