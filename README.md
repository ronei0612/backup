# backup
Script in Shell Script to do local backup using TAR

To restore a file, you can use:
ls /mnt/backup/INCREMENTAL/*.gz | while read line; do echo $line && tar -ztf $line | grep -i --text 'aqui_o_nome_do_arquivo'; done
