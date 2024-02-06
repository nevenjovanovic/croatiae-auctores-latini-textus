#!/usr/bin/env bash
# croala-db-update, 2024-02-06, prema basex-refresh.sh, 2015-10-10
# create new croala database, backup it, rsync backup
# to croala, and basex/data
# usage: ./croala-db-update.sh

set -o errexit
set -o pipefail
set -o nounset

echo "CroALa DB update: ažuriram bazu CroALa i radim sigurnosnu kopiju..."
/home/neven/Applications/basex/bin/basex -c /home/neven/Nextcloud/Repos/croatiae-auctores-latini-textus/scripts/xq/croala-dbs-create-backup.bxs
# echo "Provjeravam datum ažuriranja..."
# INF=`./basex/bin/basex -c /home/neven/rad/croala-r/local-scripts/check-croalabib.bxs`
# echo -e "Baza CroALaBib posljednji je put ažurirana ${INF}.\n"
# echo "Radim sigurnosnu kopiju..."
# ./basex/bin/basex -c /home/neven/rad/croala-r/local-scripts/croalabib-backup.bxs

BACKUP=`ls /home/neven/basexdata-2021-11/data/croalatextus-202*.zip -t | head -1`
echo "Sigurnosna kopija: ${BACKUP}."

# echo "Presnimavam s adrese ${BACKUP} u /home/neven/basex/data..."
# rsync -avzP ${BACKUP} /home/neven/basexdata-2021-11/data/
# echo -e "Presnimavam s adrese ${BACKUP} \nna solr.ffzg.hr..."
# rsync -avzP -e 'ssh -p 12122' ${BACKUP} njovanov@pluton.ffzg.hr:/home/njovanov/b/basex/data/
echo -e "Presnimavam s adrese ${BACKUP} \nna croala.ffzg.hr..."
rsync -avzP -e 'ssh -p 13322' ${BACKUP} njovanov@pluton.ffzg.hr:/home/njovanov/
# echo -e "Baza CroALaBib ažurirana ${INF}\nSigurnosna kopija ${BACKUP} \npresnimljena na croala."
echo -e "Baza CroALaBib ažurirana.\nSigurnosna kopija ${BACKUP} \npresnimljena na croala."


