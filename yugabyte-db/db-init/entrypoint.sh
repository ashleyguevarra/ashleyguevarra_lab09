#!/bin/bash
set -e

# Ne pas lancer yugabyted ici : le serveur est le conteneur yugabyte1.
# On attend seulement que YSQL réponde (boucle rapide, pas le healthcheck Compose).
echo "Attente de YSQL sur yugabyte1..."
until /home/yugabyte/bin/ysqlsh -h yugabyte1 -U yugabyte -c "SELECT 1" > /dev/null 2>&1; do
  echo "YSQL indisponible, nouvel essai dans 2s..."
  sleep 2
done

echo "YSQL est prêt. Exécuter init.sql..."
/home/yugabyte/bin/ysqlsh -h yugabyte1 -U yugabyte -d yugabyte -f /db-init/init.sql
echo "Le script init a été exécuté correctement."

