# backup
Script para fazer backup localmente usando o TAR

Para recuperar um backup, você pode utilizar o comando de exemplo:
ls /mnt/backup/INCREMENTAL/*.gz | while read line; do echo $line && tar -ztf $line | grep -i --text 'aqui_o_nome_do_arquivo'; done
