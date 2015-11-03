#!/usr/bin/env bash
#start
function main() {
init
chkBackupDir
}
function init() {
BACKUP_DIR="/home/satish"
DB_USER="db_user"
DB_PASSWORD="db_password"
DB_NAME="db_name"
DOC_ROOT="/home/pi"
DAYS_TO_KEEP_BACKUP="5"
}

function chkBackupDir(){
if [[ ! -d "BACKUP_DIR" ]]; then
        mkdir "$BACKUP_DIR"
fi
backupDocRoot
}
function backupDocRoot() {
        `which tar` -cjf "$BACKUP_DIR"/doc_root_backup-$(date+%d-%m-%y).tar.bz2 --directory="$DOC_ROOT"
if [[ -e "$BACKUP_DIR"/doc_root_backup-$(date +%d-%m-%y).tar.bz2 ]]; then
backupDatabase
else
echo "Backup failed for the document root on your server. Please check manually" | mail -s "Backup failed - Document Root"" satish.arya@gmail.com
fi
}

function backupDatabase() {
`which mysqldump` -u "DB_USER" -p "$DB_PASSWORD"
"$DB_NAME" > "$BACKUP_DIR/"$DB_NAME" -$(date +%d-%m-%y).sql |
tee "$BACKUP_DIR"/backup.log
tar -cjf "$BACKUP_DIR"/$DB_NAME"-$(date +%d-%m-%y).tar.bz2 "$BACKUP_DIR"/$DB_NAME"-$(date +%d-%m-%y).sql -- remove-files 2> $BACKUP_DIR/tar.log
if [[ -e "$BACKUP_DIR"/$DB_NAME"-$(date +%d-%m-%y).tar.bz2]]; then
createTar
else
echo "Backup failed for database on your server please check manually" | mail -s "backup failed - database" satish.arya@gmail.com
fi
}
function createTar() {
cd "$BACKUP_DIR"
`which tar` -cf backup-$(date +%d-%m-%y).tar doc_root_backup-$(date +%d-%m-%y).tar.bz2 "$DB_NAME"-$(date+%d-%m-%y).tar.bz2 --remove-files 2> final.log
deleteOldBackup
}
function deleteoldBackup() {
`which find` "$BACKUP_DIR"/"$DB_NAME"* -mtime + "$DAYS_TO_KEEP_BACKUP" -exec rm {} \; >> $BACKUP_DIR"/delete.log
}

main
#End
