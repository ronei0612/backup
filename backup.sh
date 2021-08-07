#!/bin/bash

#Arquivo de controle do TAR
CONTROLE="/home/informatica/BACKUP"

#PASTAS QUE DEVEM SER FEITO BACKUP
PASTAS="/home/informatica/BACKUP/pastasbackup.txt"

#LOCAL ONDE SERÁ SALVO BACKUP
LOCALBACKUP="/mnt/backup/INCREMENTAL"

DIA=`date +%d-%m-%y_%H.%M.%S`

# CORRIGE PASTAS SE TERMINAM COM /
if [ "`echo ${CONTROLE: -1}`" == "/" ]; then
    CONTROLE=$(echo "$CONTROLE" | sed 's/.$//')
fi
CONTROLE=$(echo "$CONTROLE" | sed 's/ /\\ /g')
if [ "`echo ${LOCALBACKUP: -1}`" == "/" ]; then
    LOCALBACKUP=$(echo "$LOCALBACKUP" | sed 's/.$//')
fi
LOCALBACKUP=$(echo "$LOCALBACKUP" | sed 's/ /\\ /g')

cat "$PASTAS" | while read PASTA; do
    if [ "`echo $PASTA | head -c 1`" != "#" ] && [ "$PASTA" != "" ]; then
        NOME=$(echo "$PASTA" | awk -F '/' '{print$NF}')
        if [ "$NOME" != "" ]; then
            # SE A PASTA NÃO EXISTE, CRIE
            if [ ! -d $LOCALBACKUP/"$NOME" ]; then
                 mkdir -p $LOCALBACKUP/"$NOME"
            fi

            # FAZ O BACKUP LINHA A LINHA
            tar --create --gzip --file=$LOCALBACKUP/"$NOME"/backup_"$NOME"_$DIA.tar.gz $PASTA --listed-incremental=$CONTROLE/$NOME.snar -v > /tmp/saidabkp.txt

            echo "Backup $NOME finalizado!"
        fi
    fi
done

