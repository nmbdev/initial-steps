#BIBLIOTECAS::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
import os 
import random as r
import time as t
import math as m
import json as j


#VARIABLES::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
gPlaces: list = []
gUserPlaces: list = []
gMenuList: list = []
gOption: int = 0
gAttempts: int = 0
gPassword: str = ""
gTripData: list = []
gInformationUser: dict = {}
OPC1: str = "Cambiar contraseña"
OPC2: str = "Ingresar coordenadas actuales"
OPC3: str = "Ubicar zona wifi más cercana"
OPC4: str = "Guardar archivo con ubicación cercana"
OPC5: str = "Actualizar registros de zonas wifi desde archivo"
OPC6: str = "Elegir opción de menú favorita"
OPC7: str = "Cerrar sesión"
CODE: str = "51630" #TODO Remplazar valor por: 51630
#Adivinanzas | Fuente: https://www.todoadivinanzas.com/adivinanzas-de-numeros/
PUZZLE0: str = "Redondo soy y es cosa anunciada que a la derecha algo valgo, pero a la izquierda nada"
PUZZLE1: str = "De millones de hijos que somos el primero nací, pero aun así soy el menor de todos"
PUZZLE2: str = "Soy más de uno sin llegar al tres, y llego a cuatro cuando dos me des"
PUZZLE3: str = "Tengo forma de serpiente, y entre el dos y el cuatro siempre estoy cuando me buscas"
PUZZLE4: str = "Las estaciones del año y también los elementos y los puntos cardinales, ese número represento"
PUZZLE5: str = "Los tienes en las manos y los tienes en los pies y en seguida sabrás qué número es"
PUZZLE6: str = "Si le sumas su hermano gemelo al tres, ya sabes cuál es"
PUZZLE7: str = "Si quieres saber quién soy, esperen a que llueva. Contando los colores del arcoíris tendrán la prueba"
PUZZLE8: str = "Parece un reloj de arena o el eslabón de una cadena"
PUZZLE9: str = "Este era un número impar que un día se dio la vuelta y en otro número se convirtió"
TOWNS: list =  [[0,"Leticia, Amazonas", -3.002, -4.227, -69.714,    -70.365],
                [1,"Betulia, Antioquia",6.284,  6.077,  -75.841,    -76.049],
                [2,"Calamar, Bolívar",  10.362, 10.103, -74.918,    -75.088],
                [3,"Chita, Boyacá",     6.306,  5.888,  -72.321,    -72.552],
                [4,"Cajibio, Cauca",    2.766,  2.548,  -76.493,    -76.879],
                [5,"La Paz, Cesar",     10.462, 9.757,  -72.987,    -73.623],
                [6,"Tadó, Chocó",       5.413,  5.119,  -76.132,    -76.619],
                [7,"Suaza, Huila",      1.998,  1.740,  -75.689,    -75.950],
                [8,"Ortega, Tolima",    4.120,  3.746,  -75.075,    -75.443],
                [9,"Curití, Santander", 6.690,  6.532,  -72.872,    -73.120]]
SAVED_PLACES: int = 3
UPPER_LATITUDE: int = 2
LOWER_LATITUDE: int = 3
EASTERN_LONGITUDE: int = 4
WESTERN_LONGITUDE: int = 5
NORTH: str = "norte"
SOUTH: str = "sur"
EAST: str = "occidente"
WEST: str = "oriente"
AVERAGE: str = "promedio"
KEY_INFORMATION: list =    [[0,NORTH, SOUTH],
                            [1,NORTH, EAST],
                            [2,NORTH, WEST],
                            [3,NORTH, AVERAGE],
                            [4,SOUTH, AVERAGE],
                            [5,SOUTH, EAST],
                            [6,SOUTH, WEST],
                            [7,EAST,  WEST],
                            [8,EAST,  AVERAGE],
                            [9,WEST,  AVERAGE]]
KEY1: int = 1
KEY2: int = 2
gWiFiZones: list = [[0,"Leticia, Amazonas",    [["-3.777",  "-70.302",  91],
                                                ["-4.134",  "-69.983",  233],
                                                ["-4.006",  "-70.132",  149],
                                                ["-3.846",  "-70.222",  211]]],
                    [1,"Betulia, Antioquia",   [["6.124",   "-75.946",  1035],
                                                ["6.125",   "-75.966",  109],
                                                ["6.135",   "-75.976",  31],
                                                ["6,144",   "-75.836",  151]]],
                    [2,"Calamar, Bolívar",     [["10.127",  "-74.950",  0],
                                                ["10.196",  "-74.935",  0],
                                                ["10.305",  "-75.040",  2490],
                                                ["10.196",  "-74.935",  101]]],
                    [3,"Chita, Boyacá",        [["6.211",   "-72.482",  2],
                                                ["6.212",   "-72.470",  25],
                                                ["6.105",   "-72.342",  25],
                                                ["6.210",   "-72.442",  50]]],
                    [4,"Cajibio, Cauca",       [["2.698",   "-76.680",  63],
                                                ["2.724",   "-76.693",  20],
                                                ["2.606",   "-76.742",  680],
                                                ["2.698",   "-76.690",  15]]],
                    [5,"La Paz, Cesar",        [["10.348",  "-73.051",  0],
                                                ["10.171",  "-73.136",  0],
                                                ["10.259",  "-73.069",  67],
                                                ["10.350",  "-73.043",  45]]],
                    [6,"Tadó, Chocó",          [["5.273",   "-76.579",  390],
                                                ["5.311",   "-76.413",  333],
                                                ["5.354",   "-76.204",  240],
                                                ["5.306",   "-76.332",  793]]],
                    [7,"Suaza, Huila",         [["1.811",   "-75.820",  58],
                                                ["1.919",   "-75.843",  1290],
                                                ["1.875",   "-75.877",  110],
                                                ["1.938",   "-75.764",  114]]],
                    [8,"Ortega, Tolima",       [["3.942",   "-75.152",  59],
                                                ["3.482",   "-75.259",  45],
                                                ["3.989",   "-75.181",  165],
                                                ["3.966",   "-75.128",  97]]],
                    [9,"Curití, Santander",    [["6.632",   "-72.984",  285],
                                                ["6.564",   "-73.061",  127],
                                                ["6.531",   "-73.002",  15],
                                                ["6.623",   "-72.978",  56]]]]
ZONES: int = 2
AVERAGE_CONNECTED_USERS: int = 2
EARTH_RADIUS: float = 6372795.477598
BUS: str = "en bus"
BUS_SPEED: float = 16.67
WALKING: str = "a pie"
WALKING_SPEED: str = 0.483
BICYCLE: str = "en bicicleta"
BICYCLE_SPEED: float = 3.33
MOTORCYCLE: str = "en moto"
MOTORCYCLE_SPEED: float = 19.44
CAR: str = "en auto"
CAR_SPEED: float = 20.83
TRANSPORT: list =  [[0, BUS,        BUS_SPEED,          MOTORCYCLE,     MOTORCYCLE_SPEED],
                    [1, BUS,        BUS_SPEED,          WALKING,        WALKING_SPEED   ],
                    [2, BUS,        BUS_SPEED,          CAR,            CAR_SPEED       ],
                    [3, BUS,        BUS_SPEED,          BICYCLE,        BICYCLE_SPEED   ],
                    [4, MOTORCYCLE, MOTORCYCLE_SPEED,   BICYCLE,        BICYCLE_SPEED   ],
                    [5, MOTORCYCLE, MOTORCYCLE_SPEED,   WALKING,        WALKING_SPEED   ],
                    [6, MOTORCYCLE, MOTORCYCLE_SPEED,   CAR,            CAR_SPEED       ],
                    [7, WALKING,    WALKING_SPEED,      CAR,            CAR_SPEED       ],
                    [8, WALKING,    WALKING_SPEED,      BICYCLE,        BICYCLE_SPEED   ],
                    [9, CAR,        CAR_SPEED,          BICYCLE,        BICYCLE_SPEED   ]]
CURRENT_PLACE: int = 2
TRIP_DATA_FILE_PATH: str = "trip_data.json"
WIFI_ZONES_FILE_PATH: str = "wifi_zones.txt"
EASTER_EGG1: str = "Tripulante2022"
EASTER_EGG2: str = "2021"
EASTER_EGG3: str = "m1s10nt1c"
EASTER_EGG4: str = "2022"
LONGITUDES_TIMEZONE: list =    [[-81.296, -67.401, -5],
                                [-67.402, -54.316, -4],
                                [-54.316, -35.833, -3]]


#===========================================================================
#==================================RETO 1===================================
#===========================================================================


#RETO1===RF01===============================================================
#BIENVENIDA
def welcomeMessage():
    print("Bienvenido al sistema de ubicación para zonas públicas WIFI")


#RETO1===RF02===============================================================
#OBTENER USUARIO
def getUser()->str:
    user: str = input("Nombre de usuario: ")
    return user


#OBTENER CONTRASEÑA
def getPassword()->str:
    password: str = input("Contraseña: ")
    return password


#OBTENER CONTRASEÑA PARA PRUEBA (código inverso)
def getTestPassword()->str:
    code: str = CODE
    lengthCode: int = len(code)
    passwordTest: str = ""
    index: int = 1
    while(lengthCode>=index):
        passwordTest += code[(lengthCode-index)]
        index += 1
    return passwordTest


#VALIDAR USUARIO
def validateUser(user: str)->bool:
    validation: bool = False    
    userTest: str = CODE
    if(user == userTest):
        validation = True
    return validation


#VALIDAR CONTRASEÑA
def validatePassword(password: str)->bool:
    global gPassword
    validation: bool = False
    passwordTest: str = getTestPassword()
    if(password == passwordTest):
        validation = True
        gPassword = passwordTest
    return validation


#RETO1===RF03===============================================================
#PRIMER TERMINO
def getLatestN(digits: int)->int:
    codeStr: str = CODE    
    lastNStr:str = codeStr[(len(codeStr)-digits):] 
    lastN: int = int(lastNStr)
    return lastN


#SEGUNDO TERMINO PARA VALIDAR
def getPenultimate()->int:
    codeStr: str = CODE
    penultimateStr:str = codeStr[(len(codeStr)-2)] 
    penultimate: int = int(penultimateStr)
    return penultimate


#GENERAR ECUACIÓN PARA SEGUNDO TÉRMINO
def getEquation()->str:
    equationStr: str = ""
    equationInt: int = -1
    operations: str = "+-*%"
    operation: str = ""
    code: str = CODE
    lengthCode: int = len(code)
    position: int = 0
    result: int = getPenultimate()

    while(equationInt != result):
        equationInt = int(code[ (r.randint(0,lengthCode-1)) ]) 
        equationStr = str(equationInt)
        
        while(position<lengthCode):        
            operation = operations[r.randint(0,3)]
            if(operation == "+"):
                equationInt += int(code[position])
                equationStr = "({}+{})".format(equationStr,int(code[position]))
            elif(operation == "-"):
                equationInt -= int(code[position])
                equationStr = "({}-{})".format(equationStr,int(code[position]))
            elif(operation == "*"):
                equationInt *= int(code[position])
                equationStr = "({}*{})".format(equationStr,int(code[position]))
            elif(operation == "%"):
                if(int(code[position]) == 0):
                    continue
                equationInt %= int(code[position])
                equationStr = "({}%{})".format(equationStr,int(code[position]))
            position += 1
        position = 0
    equationStr += " = {}".format(equationInt) 
    return equationStr


#SEGUNDO TERMINO
def getSecondTerm()->int:
    penultimate:int = getPenultimate()
    secondTerm:int = 0
    index: int = 0
    equations: str = ["","",""]

    while(index<3):
        equation: str = getEquation()
        lengthEq: int = len(equation)        
        secondTerm = int(equation[lengthEq-1])

        if(secondTerm == penultimate):
            equations[index] = equation
            index += 1
        
    return secondTerm


#GENERAR CAPTCHA
def generateCaptcha(term1: int, term2: int)->str:
    captcha: str = "{} + {} = ".format(term1,term2)
    return captcha


#RESPUESTA DEL USUARIO AL CAPTCHA 
def getUserCaptcha(captchaStr: str)->int:
    try:
        userCaptcha: int = int(input(captchaStr)) 
    except:
        exit(0)
    return userCaptcha


#VALIDAR CAPTCHA
def validateCaptcha(term1: int, term2: int, userCaptcha: int)->bool:
    valid: bool = False
    if( (term1+term2) == userCaptcha ):
        valid = True    
    return valid


#RETO1===RF04===============================================================
#INGRESO
def successfulLoginMessage():
    print("Sesión iniciada")


#RETO1:::PROGRAMA:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
"""
from os import system
import random as r
"""
def reto1()->bool:
    os.system("cls")
    isReto1Successful: bool = False

    welcomeMessage()
    
    try: 
        user: str = getUser()
        if (easterEgg(user)):
            raise NameError("finishByEasterEgg")
        if(not validateUser(user)):
            exit(0)
        
        password: str = getPassword()
        if (easterEgg(password)):
            raise NameError("finishByEasterEgg")
        if(not validatePassword(password)):
            exit(0)

        term1: int = getLatestN(3)
        term2: int = getSecondTerm()
        
        captchaStr: str = generateCaptcha(term1,term2)
        captchaInt: int = getUserCaptcha(captchaStr)
        
        if(not validateCaptcha(term1,term2,captchaInt)):
            exit(0)
        else:
            os.system("cls")
            successfulLoginMessage()
            isReto1Successful = True
    except NameError: 
        pass
    except:
        os.system("cls")
        print("Error")
    return isReto1Successful


#===========================================================================
#==================================RETO 2===================================
#===========================================================================


#RETO2===RF01=============================================================== 
def setUpMenu(menuList: list): 
    global gMenuList   
    gMenuList = menuList


def getMenu()->list:
    menuList: list = gMenuList
    return menuList


def defaultMenu(): 
    menuList: list = [OPC1,OPC2,OPC3,OPC4,OPC5,OPC6,OPC7]
    setUpMenu(menuList)


def menu()->int:
    global gAttempts
    menuList: list = getMenu()
    menuStr: str = ""
    menuLength: int = len(menuList)
    option: int = 0
    index: int = 0
    while index < menuLength:
        menuStr += "{}. {}\n".format(index+1,menuList[index])
        index += 1
    try:
        option = int(input(menuStr+"Elija una opción"))
        if (option == int(EASTER_EGG2) or option == int(EASTER_EGG4)):
            pass
        #Si es un número fuera de rango
        elif not((option >= 1) and (option <= 7)):
            #Mostrar menú nuevamente
            exit(0)
        else:
            gAttempts = 0
    #Si la entrada es diferente de un número
    except: 
        #Mostrar menú nuevamente
        alert()
    return option


#RETO2===RF02===============================================================
def actionModifyMenu(option: int):
    menuList: list = getMenu()
    favoriteOption: str = menuList.pop(option-1)
    menuList.insert(0,favoriteOption)
    setUpMenu(menuList)


def getConfirmation(position: int)->bool:
    os.system("cls")
    confirmation: bool = False
    codeLength: int = len(CODE)
    number: int = int(CODE[codeLength-position])
    request: str = "Para confirmar por favor responda:"
    puzzle: str = ""
    answer: int = -1   
    if (number == 0):
        puzzle = PUZZLE0
    elif (number == 1):
        puzzle = PUZZLE1
    elif (number == 2):
        puzzle = PUZZLE2
    elif (number == 3):
        puzzle = PUZZLE3
    elif (number == 4):
        puzzle = PUZZLE4
    elif (number == 5):
        puzzle = PUZZLE5
    elif (number == 6):
        puzzle = PUZZLE6
    elif (number == 7):
        puzzle = PUZZLE7
    elif (number == 8):
        puzzle = PUZZLE8
    elif (number == 9):
        puzzle = PUZZLE9

    answer = int(input("{} {}:".format(request,puzzle)))
    
    if number == answer:
            confirmation = True 
    return confirmation


def getFavoriteOption()->int:
    global gOption
    global gAttempts
    favoriteOption: int = 0
    try:
        favoriteOption = int(input("Seleccione opción favorita"))
        if not((favoriteOption >= 1) and (favoriteOption <= 5)):
            gOption = 7
            exit(0)
        else:
            gAttempts = 0
    except:
        gOption = 7
        exit(0)
    return favoriteOption


def modifyMenu():
    try:
        option: int = getFavoriteOption()
        if (getConfirmation(2) and getConfirmation(1)):
            actionModifyMenu(option)
        else:
            os.system("cls")
            print("Error")
            t.sleep(0.3)
    except:
        alert()
        exit(0)


#Función temporal para las opciones del menú 
def optionTask(option: int):
    os.system("cls")
    print("Usted ha elegido la opción {}".format(option))
    taskDone()


def selectedOption(option: int):
    try:
        menuList: list = getMenu()
        operation = menuList[option-1]
        if(operation == OPC1):
            updatePassword()
        elif(operation == OPC2):
            places()
        elif(operation == OPC3):
            findWiFiZones()
        elif(operation == OPC4):
            saveData()
        elif(operation == OPC5):
            updateWiFiZones()
        elif(operation == OPC6):
            modifyMenu()
        elif(operation == OPC7):
            logout()       
    except:
        pass


#RETO2===RF03===============================================================
def alert():
    os.system("cls")
    global gAttempts
    gAttempts += 1        
    if(gAttempts > 3):
        exit(0)
    print("Error")
    t.sleep(0.3)


#RETO2===RF04===============================================================
def taskDone():
    global gOption
    gOption = 7 #7 cierra el programa


#RETO2===RF05===============================================================
def logout():
    os.system("cls")
    print("Hasta pronto")


#RETO2:::PROGRAMA:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
def reto2():
    global gOption
    defaultMenu()
    try:
        while ((gOption != 7) ):
            os.system("cls")
            gOption = menu()

            if (easterEgg(str(gOption))):
                raise NameError("finishByEasterEgg")
            
            selectedOption(gOption)
    except NameError:
        pass
    except:
        if(gOption != 7):
            os.system("cls")
            print("Error")


#===========================================================================
#==================================RETO 3===================================
#===========================================================================


#RETO3===RF01===============================================================
#OBTENER CONTRASEÑA NUEVA
def getNewPassword()->str:
    password: str = input("Contraseña nueva: ")
    return password


def updatePassword():
    os.system("cls")
    global gPassword
    global gOption
    newPassword: str = ""
    try:
        if ( getPassword() == gPassword ):
            newPassword = getNewPassword()
            if ( newPassword != gPassword ):
                gPassword = newPassword
            #TODO ¿Finalizar el programa? ("La nueva contraseña no puede ser igual a la contraseña actual.")
            #===============================================
            else:
                exit(0)
            #===============================================
        else:
            exit(0)
    except:
        gOption = 7
        print("Error")
        exit(0)


#RETO3===RF02===============================================================
def threeDecimalPlaces(number: float)->str:
    numberList: list = str(number).split(".")
    integerPart: str = numberList[0]
    decimalPart: str = numberList[1][0:3]
    while (len(decimalPart) < 3):
        decimalPart += "0"
    numberStr: str = "{}.{}".format(integerPart,decimalPart)
    return numberStr


def coordinateSetting(coordinates: list)->list:
    coordinates[0] = threeDecimalPlaces(coordinates[0])
    coordinates[1] = threeDecimalPlaces(coordinates[1])
    return coordinates


def validatePlace(town: int, coordinates: list)->bool:
    isValidPlace: bool = False
    if ( ( coordinates[0] >= TOWNS[town][LOWER_LATITUDE] ) and ( coordinates[0] <= TOWNS[town][UPPER_LATITUDE] ) ):
        if ( ( coordinates[1] >= TOWNS[town][WESTERN_LONGITUDE] ) and ( coordinates[1] <= TOWNS[town][EASTERN_LONGITUDE] ) ):
            isValidPlace = True
    return isValidPlace


def getNewCoordinates()->list:
    coordinates: list = [0.0,0.0]
    os.system("cls")
    try:
        coordinates[0] = float(input("Latitud: ")) #"Por favor ingrese la latitud: "
        coordinates[1] = float(input("Longitud: ")) #"Por favor ingrese la longitud: "
    except:
        exit(0)
    return coordinates


def addPlaces():
    os.system("cls")
    global gPlaces
    global gOption
    gPlaces = []
    coordinates: list = []
    index: int = 0
    try:
        while ( index < 3 ):
            coordinates = getNewCoordinates()
            if (validatePlace(getPenultimate(),coordinates)):
                coordinates = coordinateSetting(coordinates)
                gPlaces.insert(index,coordinates)
            else:
                print("Error coordenada")
                gOption = 7
                exit(0)
            index += 1 
    except:
        if(gOption != 7):
            print("Error coordenada")
            gOption = 7
        exit(0)


def places():
    try:
        if ( len(gPlaces) != SAVED_PLACES):
            addPlaces()
        else:
            updatePlace()
    except:
        exit(0)


#RETO3===RF03===============================================================
def showPlaces():
    placesStr: str = ""
    index: int= 1
    for place in gPlaces:
        placesStr += "coordenada [latitud,longitud] {}: {}".format(index,place)
        index += 1
        if (index < 4) :
            placesStr += "\n"
    print(placesStr)


def averagePlace(latitude: list, longitude: list)->list:
    averageLatitude: float = 0.0
    averageLongitude: float = 0.0
    
    for la in latitude:
        averageLatitude += la
    
    for lo in longitude:
        averageLongitude += lo
    
    averageLatitude /= len(latitude)
    averageLongitude /= len(longitude)
    return [threeDecimalPlaces(averageLatitude),threeDecimalPlaces(averageLongitude)]


def calculateInformation(coordinates: list, key: list)->list:
    index: int = 0
    latitude: list = []
    longitude: list = []
    information: list = []
    try:
        while index < len(coordinates):
            latitude.insert(index, float(coordinates[index][0]))
            longitude.insert(index, float(coordinates[index][1]))
            index += 1

        index = 0
        for k in key:
            if (k == NORTH):
                information.insert(index, latitude.index(max(latitude)))
            elif (k == SOUTH):
                information.insert(index, latitude.index(min(latitude)))
            elif (k == EAST):
                information.insert(index, longitude.index(max(longitude)))
            elif (k == EAST):
                information.insert(index, longitude.index(min(longitude)))
            elif (k == AVERAGE):
                information.insert(index, averagePlace(latitude,longitude))
            index += 1
    except:
        pass
    return information


def showKeyInformation():
    key: list = []
    keyInformation: list = []
    keyInformationStr: str = ""
    index: int = 0
    key = [KEY_INFORMATION[getLatestN(1)][KEY1],KEY_INFORMATION[getLatestN(1)][KEY2]]
    keyInformation = calculateInformation(gPlaces, key)

    for ki in keyInformation:
        if (key[index] == AVERAGE):
            keyInformationStr += "La coordenada {} es {} de todos los puntos".format(ki,key[index])
        else:
            keyInformationStr += "La coordenada {} está ubicada más al {}".format((ki+1),key[index])
        index += 1
        if (index < 2) :
            keyInformationStr += "\n"
    
    print(keyInformationStr)


def newCoordinate()->list:
    os.system("cls")
    global gOption
    try:
        coordinates = getNewCoordinates()
        if (validatePlace(getPenultimate(),coordinates)):
            coordinates = coordinateSetting(coordinates)
        else:
            print("Error coordenada")
            gOption = 7
            exit(0)
    except:
        if(gOption != 7):
            print("Error")
            gOption = 7
        exit(0)
    return coordinates


def coordinatesToUpdate()->bool:
    global gOption
    coordinateOption: int = 0
    exitCoordinates: bool = False
    try:
        coordinateOption = int(input("Presione 1,2 ó 3 para actualizar la respectiva coordenada. Presione 0 para regresar al menú"))
        if ( (coordinateOption >= 1) and (coordinateOption <= 3) ):
            gPlaces[(coordinateOption-1)] = newCoordinate()
        elif ( coordinateOption == 0 ):
            exitCoordinates = True
        else:
            exit(0)
    except:
        if ( gOption != 7 ):
            print("Error actualización")
            gOption = 7
        exit(0)
    return exitCoordinates


def updatePlace():
    os.system("cls")
    global gPlaces
    global gOption
    exitCoordinates: bool = False
    try:
        while ( not(exitCoordinates) ):
            os.system("cls")
            if ( len(gPlaces) == SAVED_PLACES ):
                showPlaces()
                showKeyInformation()
                exitCoordinates = coordinatesToUpdate()
            else: 
                addPlaces()
    except:
        pass


#RETO3:::PROGRAMA:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#Integrado en PROGRAMA de RETO2


#===========================================================================
#==================================RETO 4===================================
#===========================================================================


#RETO4===RF01===============================================================
def validateWiFiZones()->list:
    wiFiZones: list = gWiFiZones[getPenultimate()][ZONES]
    wiFiZonesFloat: list = []
    index: int = 0
    isValidWiFiZones: bool = True
    try:
        for wz in wiFiZones:
            wiFiZonesFloat.insert(index, [ float(wz[0]), float(wz[1]) ])
            isValidWiFiZones = isValidWiFiZones and ( validatePlace(getPenultimate(),wiFiZonesFloat[index]) )
            index += 1
    except: 
        isValidWiFiZones = False
    return [isValidWiFiZones, wiFiZonesFloat]


#RETO4===RF02===============================================================
def getDestinationOption()->int:
    destinationOption: int = 0
    try:
        destinationOption = int(input("Elija 1 o 2 para recibir indicaciones de llegada"))
        if ( (destinationOption >= 1) and (destinationOption <= 2) ):
            pass
        else:
            exit(0)
    except:
        os.system("cls")
        print("Error zona wifi")
        exit(0)
    return destinationOption


def showPlacesByAverageUsers(places: list):
    os.system("cls")
    placesStr: str = "La zona wifi {}: ubicada en {} a {} metros, tiene en promedio {} usuarios"
    index: int = 1
    
    print("Zonas wifi más cercanas con menos usuarios")
    for p in places:
        print(placesStr.format(index, p[0], int(p[1]), p[2] ))
        index += 1


def sortPlaces(nearestPlacesIndexes: list, wiFiZones: list, distances: list, averageUsers: list)->list:
    places: list = []
    placesSortedByDistance: list = []
    index: int = 0
    
    #Dar formato a coordenadas
    index = 0
    for wz in wiFiZones:
        wiFiZones[index] = coordinateSetting(wz)
        index += 1
    
    #Unir información ordenada por zonas wifi más cercanas
    index = 0
    for npi in nearestPlacesIndexes:
        placesSortedByDistance.insert(index , [ wiFiZones[npi], distances[npi], averageUsers[npi] ])
        index += 1
    
    #Ordenar por promedio de usuarios conectados 
    index = 0
    for psd in placesSortedByDistance:
        averageUsers[index] = psd[2]
        index += 1
    
    averageUsers.sort()
    index = 0
    for psd in placesSortedByDistance:
        places.insert(averageUsers.index(psd[2]) , placesSortedByDistance[index])
        index += 1
    
    return places


def getConnectedUsers()->list:
    connectedUsers: list = []
    index: int = 0
    for wz in gWiFiZones[getPenultimate()][ZONES]:
        connectedUsers.insert(index, wz[AVERAGE_CONNECTED_USERS] )
        index +=1
    return connectedUsers


def getNearestPlacesIndexes(places: int, distances: list)->list:
    nearestPlacesIndexes: list = []
    leftover: list = distances.copy()
    nearestPlaceIndex: int = 0
    index: int = 0
    try:
        while index < places:
            nearestPlaceIndex = distances.index(min(leftover))
            nearestPlacesIndexes.insert(index, nearestPlaceIndex)
            leftover.pop(nearestPlaceIndex)
            index += 1
    except:
        # (places) debe ser menor o igual a la cantidad de elemntos en (distances)
        pass
    return nearestPlacesIndexes


def getDistances(currentPlace: list, wiFiZones: list)->list:
    distances: list = []
    distance: float = 0.0
    lat1 = currentPlace[0]
    lon1 = currentPlace[1]
    index: int = 0
    for wz in wiFiZones:
        lat2 = wz[0]
        lon2 = wz[1]
        dLat = lat2 - lat1
        dLon = lon2 - lon1
        sin2dLat = m.pow( m.sin( m.radians(dLat/2) ) , 2) 
        sin2dLon = m.pow( m.sin( m.radians(dLon/2) ) , 2) 
        cosLat1 = m.cos( m.radians( lat1 ) )
        cosLat2 = m.cos( m.radians( lat2 ) )
        radicand = sin2dLat + (cosLat1 * cosLat2 * sin2dLon)
        arcsine = m.asin( m.sqrt( radicand ) )
        distance = 2 * EARTH_RADIUS * arcsine
        distances.insert(index, distance)
        index += 1
    return distances


def getCurrentPlace()->list:
    global gOption
    place: int = 0
    currentPlace: list = []
    try:
        place = int(input("Por favor elija su ubicación actual (1,2 ó 3) para calcular la distancia a los puntos de conexión"))
        if ( (place >= 1) and (place <= 3) ):
            currentPlace = [ float(gPlaces[place-1][0]), float(gPlaces[place-1][1]) ] 
        else:
            exit(0)
    except:
        os.system("cls")
        print("Error ubicación")
        gOption = 7
        exit(0)
    return currentPlace


def findWiFiZones():
    os.system("cls")
    global gOption
    global gTripData
    currentPlace: list = []
    distances: list = []
    averageUsers: list = []
    option: int = 0
    try:
        wiFiZones: list = validateWiFiZones()
        if ( len(gPlaces) == SAVED_PLACES ):
            if (wiFiZones[0]):
                #while ():
                showPlaces()
                currentPlace = getCurrentPlace()
                distances = getDistances(currentPlace, wiFiZones[1])
                averageUsers = getConnectedUsers()
                nearestPlacesIndexes = getNearestPlacesIndexes(2, distances)
                sortedWiFiPlaces = sortPlaces(nearestPlacesIndexes, wiFiZones[1], distances, averageUsers)
                showPlacesByAverageUsers(sortedWiFiPlaces)                
                option = getDestinationOption()

                gTripData = getTransport(option, currentPlace, sortedWiFiPlaces)
                if (int(input("Presione 0 para salir")) != 0):
                    exit(0)
            else:
                #TODO Borrar
                print("Zonas wifi no validas")
                t.sleep(1.4)
        else:
            print("Error sin registro de coordenadas")
            exit(0)
    except:
        gOption = 7
        exit(0)


#RETO4===RF03==============================================================
def showTripAverageTime(distance: float)->list:
    transport: list = TRANSPORT[getLatestN(1)]
    tripAverageTime: list = []
    tripAverageTimeData: list = []
    meansOfTransport: list = [ transport[1], transport[3] ]
    tripAverageTime.insert(0, distance / transport[2])
    tripAverageTime.insert(1, distance / transport[4])
    tripAverageTimeStr: str = ""
    index: int = 0

    for mt in meansOfTransport:
        tripAverageTimeStr += "El tiempo promedio de viaje {} es de: {}s ".format( mt, int(tripAverageTime[index]) )
        tripAverageTimeData.insert(index, [mt, int(tripAverageTime[index]) ])
        if (index < 1):
            tripAverageTimeStr += "\n"
        index += 1
    print(tripAverageTimeStr)
    return tripAverageTimeData


def showRouteDirection(origin: list, destination: list)->list:
    os.system("cls")
    steps: list = []
    stepsStr: str = ""
    dLat: float = 0.000 
    dLon: float = 0.000
    zero: float = 0.000
    index: int = 0
    try:
        destination = [ float(destination[0]), float(destination[1]) ]
        dLat = destination[0] - origin[0]
        dLon = destination[1] - origin[1]
        if (dLon != zero):
            if (dLon > zero):
                steps.insert(index, EAST)
                index += 1
            else:
                steps.insert(index, WEST)
                index += 1
        if (dLat != zero):
            if (dLat > zero):
                steps.insert(index, NORTH)
            else:
                steps.insert(index, SOUTH)
        if(dLat == dLon == zero):
            steps = []
            stepsStr = "Estas ubicado en la zona wifi" #TODO Menasaje por definir
        
        if ( len(steps) == 2):
            stepsStr = "Para llegar a la zona wifi dirigirse primero al {} y luego hacia el {}".format(steps[0], steps[1])
        elif ( len(steps) == 1 ):
            stepsStr = "Para llegar a la zona wifi dirigirse al {}".format(steps[0])
    except:
        pass
    print(stepsStr)
    return [origin, destination, steps]


def getTransport(option: int, currentPlace: list, wiFiPlaces: list)->list:
    routeDirection: list = []
    tripData: list = []
    try:
        # [ [origin], [destination], [steps] ]
        routeDirection = showRouteDirection(currentPlace, wiFiPlaces[option-1][0])
        # [..., distance]
        routeDirection.append( wiFiPlaces[option-1][1] )
        # [..., averageUsers]
        routeDirection.append( wiFiPlaces[option-1][2] )
        # [ [meansOfTransport], [time] ]
        tripData = showTripAverageTime(wiFiPlaces[option-1][1])
    except:
        exit(0)
    # [ [origin], [destination], [steps], distance, averageUsers, [ [meansOfTransport], [averageTime] ] ]
    routeDirection.append(tripData)
    return routeDirection


#RETO4:::PROGRAMA:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#Integrado en PROGRAMA de RETO2


#===========================================================================
#==================================RETO 5===================================
#===========================================================================


#RETO5===RF01===============================================================
def createJsonFile(dictionary: dict):
    try:
        with open(TRIP_DATA_FILE_PATH, "w") as file:
            j.dump(dictionary, file)
    except:
        print("Error") #TODO Borrar

def setInformationUser(tripData: list):
    global gInformationUser
    global gOption
    informationUser: dict = {}
    origin: list = []
    wiFiZone: list = []
    meansOfTransport: list = []
    averageTime: list = []
    route: list = []
    confirmationStr: str = "¿Está de acuerdo con la información a exportar? Presione 1 para confirmar, 0 para regresar al menú principal"
    index: int = 0
    confirmation: int = -1
    try:
        origin = coordinateSetting( tripData[0] )
        wiFiZone = coordinateSetting( tripData[1] )
        wiFiZone.append(tripData[4])
        
        for t in tripData[5]:
            meansOfTransport.insert(index, t[0])
            averageTime.insert(index, t[1])
            index += 1
        
        route = [tripData[3], meansOfTransport, averageTime]
        informationUser =  {
                "actual":       origin,     #["latitud", "longitud"],
                "zonawifi1":    wiFiZone,   #["latitud", "longitud", "usuarios"],
                "recorrido":    route       #["distancia", "mediotransporte", "tiempopromedio"]
            }
        
        print(informationUser)
        confirmation = int(input(confirmationStr))
        if ( confirmation == 1):
            gInformationUser = informationUser
            createJsonFile(gInformationUser)
            os.system("cls")
            print("Exportando archivo")
            gOption = 7
        elif (confirmation != 0):
            exit(0)
    except:
        exit(0)


def saveData():
    os.system("cls")
    global gOption
    try:
        if ( len(gPlaces) == SAVED_PLACES ):
            if ( len(gTripData[0]) == CURRENT_PLACE ):
                setInformationUser(gTripData)
            else:
                exit(0)
        else:
            exit(0)
    except:
        print("Error de alistamiento")
        gOption = 7
        exit(0)


#RETO5===RF02===============================================================
#Obtener matriz de coordenadas desde un diccionario
def getData()->list:
    coordinates: list = []
    try:
        file = open(WIFI_ZONES_FILE_PATH, "r")
        coordinates = eval(file.read())
    except FileNotFoundError:
        print("Error archivo no encontrado") #TODO Borrar
    except:
        print("Archivo vacio") #TODO Borrar
    return coordinates

    """
    [
        ["6.021","-72.427", 3],
        ["5.981","-72.349", 34],
        ["6.310","-72.413", 43],
        ["6.297","-72.391", 74]
    ]
    """


def updateWiFiZones():
    os.system("cls")
    global gOption
    global gWiFiZones
    coordinates: list = []
    coordinatesBackup: list = []
    penultimate: int = getPenultimate()
    exitOption: int = 0
    exitOptionStr: str = "resione 0 para regresar al menú principal"
    try:
        coordinates = getData()
        if coordinates:
            coordinatesBackup = gWiFiZones[penultimate][ZONES]
            gWiFiZones[penultimate][ZONES] = coordinates 
            if (validateWiFiZones()[0]):                
                exitOption = int(input("Datos de coordenadas para zonas wifi actualizados, p{}".format(exitOptionStr) ))
            else:
                gWiFiZones[penultimate][ZONES] = coordinatesBackup
                #TODO Borrar
                print("Una o mas zonas wifi no son validas")
                exit(0)            
        else:
            exitOption = int(input("P{}".format(exitOptionStr) ))
        
        if ( exitOption != 0):
            gOption = 7
    except:
        exitOption = int(input("P{}".format(exitOptionStr) ))
        if ( exitOption != 0):
            gOption = 7
            exit(0)


#RETO5:::PROGRAMA:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#Integrado en PROGRAMA de RETO2


#===========================================================================
#==================================RETO EXTRA===============================
#===========================================================================


#RETO 4 EXTRA===============================================================
def easterEggLoginUser():
    os.system("cls")
    print("Este fue mi primer programa y vamos por más")


def easterEggMenu2021():
    os.system("cls")
    latitude: float = 0.0
    location: str = ""
    try:
        latitude = float(input("Dame una latitud y te diré cual hemisferio es..."))
        if (latitude > 0):
            location = "hemisferio norte"
        elif (latitude < 0):
            location = "hemisferio sur"
        else:
            location = "ningún hemisferio"
        print("Usted está en {}".format(location))
    except:
        pass #print("Error")


#RETO 5 EXTRA===============================================================
def easterEggLoginPassword():
    os.system("cls")
    latitudes: int = 0
    index: int = 1
    average: float = 0.0
    try:
        latitudes = int(input("Por favor ingrese la cantidad de latitudes a promediar: "))
        while index <= latitudes:
            average += float(input("Latitud {}: ".format(index)))
            index += 1
        average /= latitudes
        print("La latitud promedio es {}".format(threeDecimalPlaces(average)))
    except:
        pass


def longitudeToTimeZone(longitude: float)->str:
    timeZone: str = ""
    try:
        for ltm in LONGITUDES_TIMEZONE:
            if (ltm[1] >= longitude >= ltm[0]):
                timeZone = str(ltm[2])
                break
        if (timeZone == ""):
            timeZone = "fuera de Sudamérica"
    except:
        pass
    return timeZone


def easterEggMenu2022():
    os.system("cls")
    longitude: float = 0.0
    try:
        longitude = float(input("Escribe una la coordenada de una longitud en Sudamérica y te diré su huso horario")) # *Escribe la coordenada...
        print("El huso horario es {}".format(longitudeToTimeZone(longitude)))
    except:
        pass


#RETO EXTRA:::PROGRAMA::::::::::::::::::::::::::::::::::::::::::::::::::::::
def easterEgg(value: str)->bool:
    isEasterEgg: bool = False
    if (value == EASTER_EGG1):
        easterEggLoginUser()
        isEasterEgg = True
    elif (value == EASTER_EGG2):
        easterEggMenu2021()
        isEasterEgg = True
    elif (value == EASTER_EGG3):
        easterEggLoginPassword()
        isEasterEgg = True
    elif (value == EASTER_EGG4):
        easterEggMenu2022()
        isEasterEgg = True
    return isEasterEgg


#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#::::::::::::::::::::::::::::::::::PROGRAMA:::::::::::::::::::::::::::::::::
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if reto1():
    t.sleep(0.4)
    reto2()
exit(0)

