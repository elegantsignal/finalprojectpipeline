#!/bin/bash 

# sudo usermod -aG www-data $USER

mkdir -p files/translations backups
touch settings.php
chgrp -R www-data files backups settings.php
chgrp -R www-data files && chmod -R g+rwx files 
chgrp www-data settings.php && chmod g+rwx settings.php


docker exec -it upstream /bin/bash -c "/var/www/vendor/bin/drush site-install demo_umami --yes --account-name=admin --account-pass=admin --site-name=Test --db-url=pgsql://docker:docker@postgres:5432/drupal"
docker exec -it upstream /bin/bash -c "/var/www/vendor/bin/drush sset system.maintenance_mode TRUE"
docker exec -it upstream /bin/bash -c "/var/www/vendor/bin/drush cache-rebuild"
docker exec postgres /bin/bash -c "PGPASSWORD='docker' pg_dump -U docker drupal" > backup_drupal_init.sql
docker exec -it upstream /bin/bash -c "/var/www/vendor/bin/drush sset system.maintenance_mode FALSE"
