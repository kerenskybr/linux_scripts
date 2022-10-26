#!/bin/bash

# tira_usb.sh - Script para ejetar dispositivos USB

# Os dispositivos ficam em subdiretórios do diretório /sys/bus/usb/devices
# Nestes diretórios, há dois arquivos importantes:
# product - A descrição do dispositivo
# remove - Remove o dispositivo se direcionarmos "1" para ele
# O script considera apenas diretórios cujo nome começa com dígito
# e que contenham o arquivo "product"
# Os outros diretórios não parecem úteis para a remoção de dispositivos

# Entra no diretório dos dispositivos e lista as descrições com o comando
# ls -1 - Lista um diretório por linha
# awk '/^[[:digit:]]/ - Filtra diretórios com nome começando por dígito
# { system(" - Executa comando dentro do "awk"
# [ -f "$1"/product ] - Testa a existência de arquivo chamado
#   $1/product - Para o "awk", $1 é o 1º campo - o nome do diretório
#   && echo $1 - Caso exista, retorna o nome do diretório
# Os parênteses transformam o resultado em uma matriz
# A notação #DIRS[*] retorna a quantidade de elementos da matriz
cd /sys/bus/usb/devices
DIRS=(`ls -1 | awk '/^[[:digit:]]/ { system("[ -f "$1"/product ] && echo "$1) }'`)
QTD=${#DIRS[*]}

# Gera uma segunda matriz com as descrições dos dispositivos USB
for INDICE in ${!DIRS[*]} ; do
    DISP[INDICE]="`cat ${DIRS[$INDICE]}/product`"
done

# Cria um menu com os índices e os dispositivos
# Soma 1 ao índice para ficar mais natural ao usuário
# e para reservar a opção "0" para sair do script
# Executa o menu até que o usuário digite "0"
while [ "$INDICE" != "0" ] ; do
    clear
    echo "Escolha um dos números mostrados ou 0 para sair"
    echo "Para dispositivos de armazenamento - pen drives, HDs/SDDs externos, etc - desmontar sistema de arquivos antes!"
    echo
    for INDICE in ${!DIRS[*]} ; do
        echo -e "`expr $INDICE + 1`\t${DISP[INDICE]}"
    done
    echo
    read INDICE
# Verifica se o usuário digitou apenas dígitos
    if [[ ! $INDICE =~ ^[[:digit:]]+$ ]] ; then
        echo "Entrada inválida"
# Verifica se o usuário digitou número dentro do limite da matriz
    elif [ $INDICE -gt $QTD ] ; then
        echo "Entrada inválida"
# Verifica se o usuário digitou um elemento ou "0"
    elif [ $INDICE -gt 0 ] ; then
        echo 1 | sudo tee "${DIRS[`expr $INDICE - 1`]}/remove"
    fi
done
