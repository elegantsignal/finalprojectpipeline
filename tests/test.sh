#!/bin/bash 
set -e

# Checkout to latest release
 git config user.name "jenkins" && git config user.email "jenkins@null.com"
git checkout master
git checkout $(git describe)
sleep 2

# Generate dummy site
/var/www/vendor/bin/drush site-install standard --yes --account-name=admin --account-pass=admin --site-name=Test --db-url=pgsql://docker:docker@postgres:5432/drupal || true && \
/var/www/vendor/bin/drush --yes dl devel health_check bootstrap_business && \
/var/www/vendor/bin/drush --yes en devel_generate health_check bootstrap_business && \
/var/www/vendor/bin/drush --yes config:set system.theme default bootstrap_business && \
/var/www/vendor/bin/drush --yes config-set system.theme admin bootstrap_business && \
/var/www/vendor/bin/drush generate-users 3 && \
/var/www/vendor/bin/drush generate-content --types=article --languages='en' 15 && \
/var/www/vendor/bin/drush sset system.maintenance_mode TRUE && \
/var/www/vendor/bin/drush cache-rebuild


# Merge pull request
git merge $COMMIT
sleep 2

# Update the site
/var/www/vendor/bin/drush --yes updatedb && \
/var/www/vendor/bin/drush sset system.maintenance_mode FALSE && \
/var/www/vendor/bin/drush generate-users 3 && \
/var/www/vendor/bin/drush generate-content --types=article --languages='en' 15

echo "Success!"
