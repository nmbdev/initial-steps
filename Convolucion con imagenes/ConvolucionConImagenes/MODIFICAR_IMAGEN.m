function varargout = MODIFICAR_IMAGEN(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MODIFICAR_IMAGEN_OpeningFcn, ...
                   'gui_OutputFcn',  @MODIFICAR_IMAGEN_OutputFcn, ...
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

function MODIFICAR_IMAGEN_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);

%__________________________________________________________________________

[Fondo map] = imread('fondo.jpg','jpg');
axes(handles.imgFondo)
image(Fondo),colormap(map);
axis off

botonAtras = uicontrol('Style','pushbutton', ...
'Units','normalized', ...
'Position',[.91 .03 .08 .05], ...
'String','ATRÁS',...
'Callback','clear all; close;clc; INICIO_CONVOLUCION_DE_IMAGENES;');


%__________________________________________________________________________
function varargout = MODIFICAR_IMAGEN_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


%__________________________________________________________________________
%CARGAR IMAGEN
function cargarImagen_Callback(hObject, eventdata, handles)
global imgO ImgEscalaGrises ImgRuido ImgLimpia ImgLimpiaMatlab ImgBordes ImgBordesMatlab

imgO = 0;
ImgEscalaGrises = 0;
ImgRuido = 0;
ImgLimpia = 0;
ImgLimpiaMatlab = 0;
ImgBordes = 0;
ImgBordesMatlab = 0;


axes(handles.imagenM),title(' '),xlabel(' ');
cla;
axis on;
set(gca,'xtick',[],'ytick',[]);

axes(handles.imagenO),title(' ');
cla;
axis on;
set(gca,'xtick',[],'ytick',[]);


axes(handles.imagenMMatlab),title(' '),xlabel(' ');
cla;
axis on;
set(gca,'xtick',[],'ytick',[]);


[nombre,ubicacion] = uigetfile('*.jpg','Seleccionar imagen para modificar');

if nombre == 0
    return
else
    imgO = imread(fullfile(ubicacion,nombre));
    axes(handles.imagenO);
    imshow(imgO);
    title(sprintf('IMAGEN ORIGINAL\n(%s)',nombre),'Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
         
    axis off
end


%__________________________________________________________________________
%LIMPIAR VISORES DE IMAGEN
function limpiarVisor_Callback(hObject, eventdata, handles)
global imgO ImgEscalaGrises ImgRuido ImgLimpia ImgLimpiaMatlab ImgBordes ImgBordesMatlab
imgO = 0;
ImgEscalaGrises = 0;
ImgRuido = 0;
ImgLimpia = 0;
ImgLimpiaMatlab = 0;
ImgBordes = 0;
ImgBordesMatlab = 0;


axes(handles.imagenM),title(' '),xlabel(' ');
cla;
axis on;
set(gca,'xtick',[],'ytick',[]);

axes(handles.imagenO),title(' ');
cla;
axis on;
set(gca,'xtick',[],'ytick',[]);


axes(handles.imagenMMatlab),title(' '),xlabel(' ');
cla;
axis on;
set(gca,'xtick',[],'ytick',[]);


%LISTA DESPLEGABLE MODIFICAR IMAGEN
%__________________________________________________________________________
function modificarImg_Callback(hObject, eventdata, handles)

global ImgEscalaGrises ImgRuido ImgLimpia ImgLimpiaMatlab ImgBordes ImgBordesMatlab t1 t1M t2 t2M

[Adv mAdv] = imread('Advertencia.jpg','jpg');
VOpc=get(hObject,'Value');

switch VOpc
    case 1
        return
    case 2       
        escalaGrisesMl();   
        if ImgEscalaGrises == 0
            axes(handles.imagenM);
            xlabel(' ');
            title(sprintf(' '));
            axis on;
            set(gca,'xtick',[],'ytick',[]);            
            msgbox('           ¡No se ha cargado una imagen!          .','Advertencia','custom', Adv, mAdv);
        else
            axes(handles.imagenM);
            imshow(ImgEscalaGrises);
            xlabel(' ');
            title(sprintf('IMAGEN EN ESCALA DE GRISES\n'),'Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
            axis off;
            
            axes(handles.imagenMMatlab);
            imshow(ImgEscalaGrises); 
            xlabel(' ');
            title(sprintf('IMAGEN EN ESCALA DE GRISES\n'),'Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
            axis off;
        end 
        
    case 3
        
        agregarRuido();   
        if ImgRuido == 0
            axes(handles.imagenM);
            xlabel(' ');
            title(sprintf(' '));
            axis on;
            set(gca,'xtick',[],'ytick',[]);
            msgbox('  ¡La imagen no se encuentra en escala de grises! .','Advertencia','custom', Adv, mAdv);
        else
            axes(handles.imagenM);
            imshow(ImgRuido); 
            xlabel(' ');
            title(sprintf('IMAGEN CON RUIDO\n'),'Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
            axis off;
            
            axes(handles.imagenMMatlab);
            imshow(ImgRuido); 
            xlabel(' ');
            title(sprintf('IMAGEN CON RUIDO\n'),'Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
            axis off;
        end 
        
    case 4
        
        eliminarRuido();   
        if ImgLimpia == 0
            axes(handles.imagenM);
            xlabel(' ');
            title(sprintf(' '));
            axis on;
            set(gca,'xtick',[],'ytick',[]);            
        else
            axes(handles.imagenM);
            imshow(ImgLimpia);            
            tiempo = sprintf('El tiempo de operación es %s s',t1);
            xlabel(tiempo,'color','w','Fontweight','Bold');
            title(sprintf('IMAGEN SIN RUIDO\n'),'Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
            axis off;  
            
            
        end 
                
        eliminarRuidoMatlab();
        if ImgLimpiaMatlab == 0
            axes(handles.imagenMMatlab);
            xlabel(' ');
            title(sprintf(' '));
            axis on;
            set(gca,'xtick',[],'ytick',[]);
            msgbox('       ¡No se ha agregado ruido a la imagen!       ','Advertencia','custom', Adv, mAdv);
        else
            axes(handles.imagenMMatlab);
            imshow(ImgLimpiaMatlab); 
            tiempo = sprintf('El tiempo de operación es %s s',t1M);
            xlabel(tiempo,'color','w','Fontweight','Bold');
            title(sprintf('IMAGEN SIN RUIDO\n(Función de Matlab)'),'Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
            axis off;
        end 
        
    case 5
        detectarBordes();
        if ImgBordes == 0
            axes(handles.imagenM);
            xlabel(' ');
            title(sprintf(' '));
            axis on;
            set(gca,'xtick',[],'ytick',[]);            
        else
            axes(handles.imagenM);
            imshow(ImgBordes);  
            tiempo = sprintf('El tiempo de operación es %s s',t2);
            xlabel(tiempo,'color','w','Fontweight','Bold');
            title(sprintf('BORDES DE LA IMAGEN\n'),'Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
            axis off;            
        end 
        
        detectarBordesMatlab();
        if ImgBordesMatlab == 0
            axes(handles.imagenMMatlab);
            xlabel(' ');
            title(sprintf(' '));
            axis on;
            set(gca,'xtick',[],'ytick',[]); 
            msgbox('  ¡La imagen no se encuentra en escala de grises!  ','Advertencia','custom', Adv, mAdv);
        else
            axes(handles.imagenMMatlab);
            imshow(ImgBordesMatlab); 
            tiempo = sprintf('El tiempo de operación es %s s',t2M);
            xlabel(tiempo,'color','w','Fontweight','Bold');
            title(sprintf('BORDES DE LA IMAGEN\n(Funcion de Matlab)'),'Fontweight','Bold','Fontsize',12,'color',[1 1 1]);
            axis off;
        end                 
                       
end


function modificarImg_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%PASAR IMAGEN A ESCALA DE GRISES 
%__________________________________________________________________________
function escalaGrisesMl()
global imgO ImgEscalaGrises

if imgO == 0
    ImgEscalaGrises = 0;  
else
    ImgEscalaGrises = rgb2gray(imgO);   
end

%AGREGAR RUIDO A LA IMAGEN
%__________________________________________________________________________
function agregarRuido()
global ImgEscalaGrises ImgRuido
if ImgEscalaGrises == 0
    ImgRuido = 0;
else
    ImgRuido = imnoise(ImgEscalaGrises,'salt & pepper',0.2);
end


%ELIMINAR RUIDO A LA IMAGEN 
%__________________________________________________________________________
function eliminarRuido()
global ImgRuido ImgLimpia t1
ImgRuidoD = double(ImgRuido);

%e': nuevo pixel
%e'= (a+b+c+d+e+f+g+h+1)/9   pixel a pixel

if ImgRuido == 0
    ImgLimpia = 0;    
else
        
    [i,j]=size(ImgRuidoD);
    tic;
    for x=2:i-1               
        for y=2:j-1           %         a                  b                c                  d                e              f                g                  h                i                          
            ImgLimpiaD(x,y) = (ImgRuidoD(x-1,y+1)+ImgRuidoD(x,y+1)+ImgRuidoD(x+1,y+1)+ImgRuidoD(x-1,y)+ImgRuidoD(x,y)+ImgRuidoD(x+1,y)+ImgRuidoD(x-1,y-1)+ImgRuidoD(x,y-1)+ImgRuidoD(x+1,y-1))/9;            
        end
    end 
    toc;
    t1=num2str(toc);
    ImgLimpia = uint8(ImgLimpiaD);    
end


%ELIMINAR RUIDO A LA IMAGEN (_MATLAB_)
%__________________________________________________________________________
function eliminarRuidoMatlab()
global ImgRuido ImgLimpiaMatlab t1M

if ImgRuido == 0
    ImgLimpiaMatlab = 0;
else
    tic;
    ImgLimpiaMatlab = medfilt2(ImgRuido);
    toc;
    t1M=num2str(toc);
end
    

%DETECTAR BORDES
%__________________________________________________________________________
function detectarBordes()
global ImgEscalaGrises ImgBordes t2

%e': nuevo pixel
%e'= |(a+2b+c)-(g+2h+i)|+|(a+2d+g)-(c+2f+i)|  pixel a pixel 

ImgEscalaGrisesD = double(ImgEscalaGrises);

if ImgEscalaGrises == 0
    ImgBordes = 0;
else
    [i,j]=size(ImgEscalaGrisesD);
    tic
    for x=2:i-1              
        for y=2:j-1           %                 a                           2b                        c                             g                           2h                        i                         
            ImgBordesD(x,y) = ((ImgEscalaGrisesD(x-1,y+1)+(2*ImgEscalaGrisesD(x,y+1))+ImgEscalaGrisesD(x+1,y+1)) - (ImgEscalaGrisesD(x-1,y-1)+(2*ImgEscalaGrisesD(x,y-1))+ImgEscalaGrisesD(x+1,y-1))... 
                              +(ImgEscalaGrisesD(x-1,y+1)+(2*ImgEscalaGrisesD(x-1,y))+ImgEscalaGrisesD(x-1,y-1)) - (ImgEscalaGrisesD(x+1,y+1)+(2*ImgEscalaGrisesD(x+1,y))+ImgEscalaGrisesD(x+1,y+1))); 
                              %                 a                           2d                        g                             c                           2f                        i                
        end
    end 
    toc;
    t2=num2str(toc);
    ImgBordes = uint8(ImgBordesD);
end


%DETECTAR BORDES (_MATLAB_)
%__________________________________________________________________________
function detectarBordesMatlab()
global ImgEscalaGrises ImgBordesMatlab t2M

if ImgEscalaGrises == 0
    ImgBordesMatlab = 0;
else
    tic
    ImgBordesMatlab = edge(ImgEscalaGrises,'prewitt');
    toc;
    t2M=num2str(toc);
end

