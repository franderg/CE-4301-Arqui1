#####################################################
#                                                   #
#      Python Compiler for ISA                      #
#      Author:  Frander Granados Vega               #
#      fgranados@ic-itcr.ac.cr                      #
#                                                   #
#####################################################

import binascii  #Se agregan paquetes necesarios

#Lista con las instrucciones del ISA
instructionList = ["ADD","SUB","ADDI","SUBI","MLT","MLTI","AND","OR","ANDI","ORI",
                   "SLR","SLL","LDR","STR","BNE","BEQ","J","CMP"];
#Lista con el codigo de operacion de la instruccion
opcodeList = ["00000","00001","00010","00011","00100","00101","00110","00111",
              "01000","01001","01010","01011","01100","01101","01110","01111","10000","10001"];
#Lista para determinar si el tercer si la instruccion usa inmediato
immediateList = [0,0,1,1,0,1,0,0,1,1,1,1,1,1,0,0,0,0];
#Tabla con todos las instrucciones a escribir
instructionTable = [];
#Lorem_Ipsum
lorem = ['L','o','r','e','m',' ','i','p','s','u','m']
#nop
nop="11111000000000000000000000000000"
#end
end="11111111111111111111111111111111"


############################################################
#funcion que agrega los ceros necesarios para los registris en la instruccion en binario, son de 5 bites
def agregaCeros(reg,num): 
    ceros = ""
    while len(ceros) < (num-len(bin(int(reg))[2:])): #Mientras el numero final sea menor al necesario
        ceros += "0"
    reg = ceros + bin(int(reg))[2:];  #Agrega ceros necesarios del registro
    return reg 

############################################################
#funcion para obtener el opcode
def opCodeOptain(opcode):
    binary="";
    n = 0
    for i in instructionList: #para cada elemento en la lista
        if opcode == i:       # Verifica el OPCode
            binary += opcodeList[n];
            break;
        n += 1;
    return [binary,n];

############################################################
#Cambia las etiquetas por las direcciones en memoria

def etiqueta(instruction,n):
    etiqueta = instruction[n].upper(); #Pasa a mayuscula
    i = 0;
    while(i < len(instructionTable)): #Mientras i sea menor al largo de la lista
        if (instructionTable[i][0].upper() == etiqueta): #si encuentra una igual
            if(etiqueta == "FIN"):
                instruction[n] = str(i); #Las etiquetas de Fin indican el final del archivo
                i = i+1;
            else:
                instruction[n] = str(i+1); #Cambia la instruccion
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
            etiqueta = instruction[0].upper()
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
                    if(instruction[3][0]=="R"):
                        #no es inmediato
                        rt = agregaCeros(instruction[3][1:],5);
                        rt += "000000000000"
                    else:
                        return -1;
                else:
                    #inmediato
                    rt = agregaCeros(instruction[3],17);                        
        else: #saltos
            etiqueta = agregaCeros(instruction[1],27);

    return(opcode+rd+rs+rt+etiqueta)

#############################################################
#Agrega NOPS para eliminar riesgos

def agregaNop(tabla,i,n):#Agrega NOPS a la tabla en el indice i, n veces
    for x in range(0,n):
        tabla.insert(i+1,["NOP"]);

def riesgos(instructionTable):
    i = 0;  #indice de la lista
    while(i < len(instructionTable)):  #mientras el indice sea mejor al largo de la lista
        if(len(instructionTable[i]) > 2):  #se verifican que las instrucciones tengan mas de 2 argumentos
            if(instructionTable[i][0] == "BEQ" or instructionTable[i][0] == "BNE"): #todo branch lleva nops
                agregaNop(instructionTable,i,3);#se agregan nops
                i = i+4; # se aumenta el indice por los nops agregados
            else:
                k = i; # 
                r1 = instructionTable[i][1]; #registro 1 de la instruccion
                for j in range(i+1,i+4):
                #mientras no se salga del rango de la lista, verifica hasta 3 instrucciones adelante
                    if (len(instructionTable) <= j):                        
                        break;
                    else:
                        if(len(instructionTable[j]) <= 2): # se revisa que la siguiente instruccion no sea salto o etiqueta
                            k += 1;
                        else:
                            r2 = instructionTable[j][2]; # segundo registro de la instruccion
                            opcode = opCodeOptain(instructionTable[j][0]); #se obtiene el codigo de operacion para determinar si es inmediato
                            if(opcode[1] > 17):
                                print("Error en la linea: " + str(i));
                                return -1;
                            elif(instructionTable[j][0] == "BNE" or instructionTable[j][0] == "BEQ"):#En caso de branches 
                                r3 = instructionTable[j][1];
                                if(r2 == r1 or r3 == r1):
                                    agregaNop(instructionTable,k,4-(j-i));#se agregan nops
                                    break;
                                else:
                                    k += 1;#Si no hay dependencia aumenta el indice k
                            else:
                                if(immediateList[opcode[1]] == 0):#No es inmediato
                                    r3 = instructionTable[j][3]; # se tiene el tercer registro de la instruccion
                                    if(r2 == r1 or r3 == r1):
                                        agregaNop(instructionTable,k,4-(j-i));#se agregan nops
                                        break;
                                    else:
                                        k += 1;
                                else:
                                    if(r2 == r1):
                                        agregaNop(instructionTable,k,4-(j-i));#se agregan nops
                                        break;
                                    else:
                                        k += 1;
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
        instruction = instruction[0].replace("\t",""); # se eliminan los \t        
        instruction = instruction.replace(" ","").split(","); #se eliminan espacios en blanco y se separa en lista.
        j = 0;
        for i in instruction:
            instruction[j] = i.replace("\n","");
            j += 1;
        if(instruction[0] == "" or instruction[0] == "\n"): # omite los \n y comentarios
            return 1;
        if(len(instruction) > 4 or len(instruction) == 3):# error en la instruccion
            instructionTable.append(instruction)
            print("Error del codigo fuente en la linea: " + str(line))
            return -1;
        else:
            instructionTable.append(instruction)

#############################################################
#Lectura y escritura de archivo

def write(instructionTable,algoritmo): #Escritura de archivo
    if(riesgos(instructionTable) == -1): #Si los riesgos retorna -1 es que hay errores
        print("error en el codigo fuente.") 
        return -1;
    else:
        with open(algoritmo, 'w') as archive:
            print(nop, file=archive);
            cont = 1;
            indice = 0;
            for i in instructionTable: #Para cada elemento de la lista
                if(i[0].upper() == "BNE" or i[0].upper() == "BEQ"): #Verifica las etiquetas de branch
                    label=etiqueta(i,3) #Llama a etiqueta con la posicion 
                    if (label != -1):#si no retorna error
                        instructionTable[indice]=label #Cambia por la direccion
                        indice += 1;
                    else:
                        return -1;
                elif (i[0].upper() == "J"): # En caso de los saltos
                    label=etiqueta(i,1)
                    if (label != -1):
                        instructionTable[indice]=label#Cambia la direccion
                        indice += 1;
                    else:
                        return -1;
                else:
                    indice += 1;
            for i in instructionTable: #Revisa nuevamente la tabla para convertir a binario
                if (i[0].upper() == 'FIN'):
                    print(end, file=archive);#Para Fin agrega fin de archivo
                    cont = cont + 1;
                elif (i[0] == 'NOP' or len(i) != 1):                    
                    test = binario(i);#Agrega los datos en binario
                    if(test != -1):
                        print(binario(i), file=archive);
                        cont = cont + 1;
                    else:                    
                        print("Error en el codigo fuente!");
                        return -1;

            #print(end, file=archive);

def read(source,algoritmo): #Lee el archivo origen
    cont = 1;
    error = False;
    with open(source) as archive: #Abre y lee el archivo
        for line in archive:
            if (agrega(line,cont) == -1):
                error = True;
                cont = cont + 1;
    if(error == False): #Si no da error continua
        write(instructionTable,algoritmo);

def texto(source,destino): #Para lectura del texto de memoria de datos
    listaTexto = [];
    for i in lorem:
        listaTexto.append(bin(int.from_bytes(i.encode(), 'big'))[2:]) #los agrega convertidos en binario
    with open(source) as archive:
        for line in archive:
            for i in line:
               listaTexto.append(bin(int.from_bytes(i.encode(), 'big'))[2:])
    indice = 0;           
    for i in listaTexto:
        j=len(i)
        ceros = ''
        while(j < 7):
            ceros += "0"
            j = j + 1;
        listaTexto[indice] = ceros + i;
        indice += 1;          

    with open(destino, 'w') as archive:
        cont = 0;        
        for i in listaTexto:
            print(i, file=archive);

read('prueba.txt','salida.txt')            
##########################################
# Para la memoria de instrucciones       #
#    read(origen,destino);              #
#                                        #
#                                        #
#  Para la memoria de datos              #
#    texto(origen,destino);               #
#                                        #
##########################################
