#!/bin/bash 
set -e

# Get script location
project_dir=$(dirname $(readlink -f $0))

# go up
parent_dir=$( dirname "${project_dir}" )
export APP_DIR=$parent_dir/m-sa2-10-19-app
export TMP_DIR=$project_dir/tmp
export SRC_DIR=$project_dir/src

# Cleanup
rm -rf $APP_DIR
mkdir -p $APP_DIR
mkdir -p $TMP_DIR
mkdir -p $SRC_DIR

cd $APP_DIR

# Init git porject
git init
git config user.name "elegentsignal" && git config user.email "elegentsignal@gmail.com"
git config remote.origin.url git@github.com:elegantsignal/m-sa2-10-19-app.git


# Make first release in master
export DRUPAL_VERSION="8.7.5"
tar -xzf $SRC_DIR/drupal-$DRUPAL_VERSION.tar.gz -C $TMP_DIR
rsync -a $TMP_DIR/drupal-$DRUPAL_VERSION/ $APP_DIR
git add .
git commit -m "drupal-$DRUPAL_VERSION"

# Make several branches
export DRUPAL_VERSION="8.7.6"
git checkout -b "dev-$DRUPAL_VERSION"
tar -xzf $SRC_DIR/drupal-$DRUPAL_VERSION.tar.gz -C $TMP_DIR
rsync -a $TMP_DIR/drupal-$DRUPAL_VERSION/ $APP_DIR
git add .
git commit -m "drupal-$DRUPAL_VERSION"

export DRUPAL_VERSION="8.7.7"
git checkout -b "dev-$DRUPAL_VERSION"
tar -xzf $SRC_DIR/drupal-$DRUPAL_VERSION.tar.gz -C $TMP_DIR
rsync -a $TMP_DIR/drupal-$DRUPAL_VERSION/ $APP_DIR
git add .
git commit -m "drupal-$DRUPAL_VERSION"

export DRUPAL_VERSION="8.7.8"
git checkout -b "dev-$DRUPAL_VERSION"
tar -xzf $SRC_DIR/drupal-$DRUPAL_VERSION.tar.gz -C $TMP_DIR
rsync -a $TMP_DIR/drupal-$DRUPAL_VERSION/ $APP_DIR
git add .
git commit -m "drupal-$DRUPAL_VERSION"

export DRUPAL_VERSION="8.7.9"
git checkout -b "dev-$DRUPAL_VERSION"
tar -xzf $SRC_DIR/drupal-$DRUPAL_VERSION.tar.gz -C $TMP_DIR
rsync -a $TMP_DIR/drupal-$DRUPAL_VERSION/ $APP_DIR
git add .
git commit -m "drupal-$DRUPAL_VERSION"

export DRUPAL_VERSION="8.7.10"
git checkout -b "dev-$DRUPAL_VERSION"
tar -xzf $SRC_DIR/drupal-$DRUPAL_VERSION.tar.gz -C $TMP_DIR
rsync -a $TMP_DIR/drupal-$DRUPAL_VERSION/ $APP_DIR
git add .
git commit -m "drupal-$DRUPAL_VERSION"

export DRUPAL_VERSION="8.8.0"
git checkout -b "dev-$DRUPAL_VERSION"
tar -xzf $SRC_DIR/drupal-$DRUPAL_VERSION.tar.gz -C $TMP_DIR
rsync -a $TMP_DIR/drupal-$DRUPAL_VERSION/ $APP_DIR
git add .
git commit -m "drupal-$DRUPAL_VERSION"

# Push to GitHub
git push --all -f
git push origin --tags -f
