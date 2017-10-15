#####################################################
#                                                   #
#      Python Compiler for ISA                      #
#      Author:  Frander Granados Vega               #
#      fgranados@ic-itcr.ac.cr                      #
#                                                   #
#####################################################

import binascii

#Lista con las instrucciones del ISA
instructionList = ["ADD","SUB","ADDI","SUBI","MLT","MLTI","AND","OR","ANDI","ORI","SLR","SLL","LDR","STR","BNE","BEQ","CMP","J"];
#Lista con el código de operación de la instrucción
opcodeList = ["00000","00001","00010","00011","00100","00101","00110","00111","01000","01001","01010","01011","01100","01101","01110","01111","10000","10001","10010","100 11"];
#Lista para determinar si el tercer operando es inmediato
immediateList = [0,0,1,1,0,1,0,0,1,1,1,1,1,1,0,0,0,0];
#Tabla con todos las instrucciones
instructionTable = [];
#Lorem_Ipsum
lorem = ['L','o','r','e','m',' ','i','p','s','u','m']
#nop
nop="11111000000000000000000000000000"


############################################################
#funcion que agrega los ceros necesarios para los registris en la instruccion en binario, son de 5 bites
def agregaCeros(reg,num): 
    ceros = ""
    while len(ceros) < (num-len(bin(int(reg))[2:])):
        ceros += "0"
    reg = ceros + bin(int(reg))[2:];
    return reg 

############################################################
#funcion para obtener el opcode
def opCodeOptain(opcode):
    binary="";
    n = 0
    for i in instructionList:
        if opcode == i:
            binary += opcodeList[n];
            break;
        n += 1;
    return [binary,n];

############################################################
#Cambia las etiquetas por las direcciones en memoria

def etiqueta(instruction,n):
    print(instruction,n)
    etiqueta = instruction[n][:-1].upper();
    i = 0;
    while(i < len(instructionTable)):
        if (instructionTable[i][0][:-1].upper() == etiqueta):
            instruction[n] = str(i);
            i = i+1;
            return instruction
        i = i+1;
    return -1;

############################################################
#busca la instruccion
         
def binario(instruction):
    if(len(instruction)==1):  #etiquetas o NOPS
        if (instruction[0].upper() == "NOP"):
            return nop;
        else:
            etiqueta = instruction[0][:-1].upper()
            return etiqueta;
        #logica para direccion de etiquetas
    else: 
        salida = opCodeOptain(instruction[0].upper())
        opcode = salida[0];
        n = salida[1]
        rd = ""
        rs = ""
        rt = ""
        etiqueta = ""
        if(len(instruction)==4):  #verifica la cantidad de argumentos
            rd = agregaCeros(instruction[1][1:],5);
            rs = agregaCeros(instruction[2][1:],5);
            if(instruction[0] == "BNE" or instruction[0] == "BEQ"):
                etiqueta = agregaCeros(instruction[3],17);
            else:
                rt = instruction[3];
                #se revisa si el tercer argumento es inmediato
                if immediateList[n] != 1:
                    #no es inmediato
                    rt = agregaCeros(instruction[3][1:],5);
                    rt += "000000000000"
                else:
                    #inmediato
                    rt = agregaCeros(instruction[3][1:],17);                        
        else: #saltos
            etiqueta = agregaCeros(instruction[1],27);

    return(opcode+rd+rs+rt+etiqueta)

#############################################################
#Agrega NOPS para eliminar riesgos

def agregaNop(tabla,i):
    for x in range(0,3):
        tabla.insert(i+1,["NOP"]);

def riesgos(instructionTable):
    i = 0;  #indice de la lista
    j = 0;  #indice para los NOPS
    while(i < len(instructionTable)):  #mientras el indice sea mejor al largo de la lista
        if(len(instructionTable[i]) > 2):  #se verifican que las instrucciones tengan más de 2 argumentos
            if(instructionTable[i][0] == "BEQ" or instructionTable[i][0] == "BNE"): #todo branch lleva nops
                agregaNop(instructionTable,i);#se agregan nops
                i = i+4; # se aumenta el indice por los nops agregados
            else:
                j = i+1; #indice para siguiente instrucción
                r1 = instructionTable[i][1]; #registro 1 de la instrucción
                #mientras no se salga del rango de la lista, verifica hasta 3 instrucciones adelante
                while(j < len(instructionTable) or j <= ((j+2)-len(instructionTable))):
                    if(len(instructionTable[j]) <= 2): # se revisa que la siguiente instrucción no sea salto o etiqueta
                        j = j+1;
                    else:
                        r2 = instructionTable[j][2]; # segundo registro de la instrucción
                        opcode = opCodeOptain(instructionTable[j][0]); #se obtiene el código de operacion para determinar si es branch
                        if(opcode[0] == "BNE" or opcode[0] == "BEQ"):#revisa si son branches
                             if(instructionTable[j][1] == r1 or r2 == r1): # si hay dependencia agrega NOPS para evitar el riesgo
                                 agregaNop(instructionTable,i);#se agregan nops
                                 i = i+3;
                                 break;
                             else:
                                 j = j+1;
                        elif(immediateList[opcode[1]] == 0):#No es inmediato
                            r3 = instructionTable[j][3][:-1]; # se tiene el tercer registro de la instrucción
                            if(r2 == r1 or r3 == r1):
                                agregaNop(instructionTable,i);#se agregan nops
                                i = i+3;
                                break;
                            else:
                                j = j+1;
                        else:
                            if(r2 == r1):
                                agregaNop(instructionTable,i);#se agregan nops
                                i = i+3;
                                break;
                            else:
                                j = j+1;
                i = i+1;
        else: #es una etiqueta, un salto o un NOP
            i = i+1;

#############################################################
#Agrega las instrucciones a una tabla para verificar riesgos

def agrega(instruction,line):
    if(len(instruction) < 1):
        return -1;
    else:
        instruction = instruction.split(";");
        instruction = instruction[0].replace("\t","") # se eliminan los \t
        instruction = instruction.replace(" ","").split(","); #se eliminan espacios en blanco y se separa en lista.
        if(instruction[0] == "" or instruction[0] == "\n"): # omite los \n y comentarios
            return 1;
        
        if(len(instruction) > 4):# error en la instruccion
            instructionTable.append(instruction)
            print("Error del código fuente en la línea: " + str(line))
            return -1;
        else:
            instructionTable.append(instruction)

#############################################################
#Lectura y escritura de archivo

def write(instructionTable,depth):
    riesgos(instructionTable);
    with open('salida.mif', 'w') as archive:
        print( "DEPTH = " + str(depth) + ";", file=archive);
        print("WIDTH = 32;", file=archive);
        print("ADDRESS_RADIX = HEX;", file=archive);
        print("DATA_RADIX = BIN; ", file=archive);
        print("CONTENT", file=archive);
        print("BEGIN", file=archive);
        print(str(0) + " : " + nop, file=archive);
        cont = 1;
        for i in instructionTable:
            if(i[0].upper() == "BNE" or i[0].upper() == "BEQ"):
                label=etiqueta(i,3)
                if (label != -1):
                    print(str(hex(cont)[2:]) + " : " + binario(label), file=archive);
                    cont = cont + 1;
                else:
                    return -1;
            elif (i[0].upper() == "J"):
                label=etiqueta(i,1)
                if (label != -1):
                    print(str(hex(cont)[2:]) + " : " + binario(label), file=archive);
                    cont = cont + 1;
                else:
                    return -1;
            else:
                print(str(hex(cont)[2:]) + " : " + binario(i), file=archive);
                cont = cont + 1;
        while(cont < depth):
            print(str(hex(cont)[2:]) + " : " + nop, file=archive);
            cont = cont + 1;
        print("END;", file=archive);

def read(source):
    cont = 1;
    error = False;
    with open(source) as archive:
        for line in archive:
            if (agrega(line,cont) == -1):
                error = True;
                cont = cont + 1;
    if(error == False):
        write(instructionTable,128);

def texto(source):
    listaTexto = [];
    for i in lorem:
        listaTexto.append(bin(int.from_bytes(i.encode(), 'big'))[2:])
    with open(source) as archive:
        for line in archive:
            for i in line:
               listaTexto.append(bin(int.from_bytes(i.encode(), 'big'))[2:])
    indice = 0;           
    for i in listaTexto:
        j=len(i)
        ceros = ''
        while(j < 8):
            ceros += "0"
            j = j + 1;
        listaTexto[indice] = ceros + i;
        indice += 1;          

    with open('texto.mif', 'w') as archive:
        print( "DEPTH = " + str(9142) + ";", file=archive);
        print("WIDTH = 7;", file=archive);
        print("ADDRESS_RADIX = HEX;", file=archive);
        print("DATA_RADIX = BIN; ", file=archive);
        print("CONTENT", file=archive);
        print("BEGIN", file=archive);
        cont = 0;        
        while(cont <= 9142):
            for i in listaTexto:
                if(cont <= 9142):
                    print(str(hex(cont)[2:]) + " : " + i, file=archive);
                    cont +=1;
                else:
                    break;
        print("END;", file=archive);
