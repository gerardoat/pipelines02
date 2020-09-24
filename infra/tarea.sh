#!/bin/bash
param1=$1
param2=$2
param3=$3
param4=$4

echo "Parámetros recibidos:"
echo "Param1: $param1"
echo "Param2: $param2"
echo "Param3: $param3"
echo "Param4: $param4"

echo "Variables de entorno:"
echo "SONARTOKEN: $SONARTOKEN"
echo "UNSECRET: $UNSECRET"
echo "OTROSECRET: $OTROSECRET"
echo "SASCONTENEDORB64: $SASCONTENEDORB64"

echo "===================== Decodificar SAS"
SASCONTENEDOR=`echo $SASCONTENEDORB64 | base64 --decode`
echo "SASCONTENEDOR: $SASCONTENEDOR"

echo "===================== Crear archivo"
ls -l
echo "Se agrega éste contenido al archivo..." >> ./archivo.txt
echo "Hola" | base64 --decode >> ./archivo.txt
echo "$SASCONTENEDOR" >> ./archivo.txt
ls -l
cat ./archivo.txt

echo "===================== Descarga de AzCopy"
wget -O azcopy.tar.gz https://aka.ms/downloadazcopy-v10-linux && tar -xf azcopy.tar.gz --strip-components=1 > nul
echo "===================== Carga de Archivo"
fqdnContenedor="https://resulttests.blob.core.windows.net/%24web"
./azcopy copy "./archivo.txt" "$fqdnContenedor/archivo.txt?$SASCONTENEDOR" --recursive=true
