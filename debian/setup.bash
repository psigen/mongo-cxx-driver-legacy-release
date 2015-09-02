#!/bin/bash
#
# Script to create a base GBP repository for mongodb-legacy CXX driver.
#
# Based on instructions from:
# https://github.com/freshtonic/debianization-with-git-howto
#
# Required dependencies:
# sudo apt-get install debhelper dh-make git-buildpackage build-essential
#
# To build this GBP repository, call:
# git-buildpackage --git-pristine-tar
#
# \author Pras Velagapudi <psigen@gmail.com>
#
PROJECT="mongo-cxx-driver-legacy"
TAG="1.0.5"
LICENSE="apache"
GBP_REPO_PATH="${PROJECT}-release"
UPSTREAM_TARBALL_URI="https://github.com/mongodb/mongo-cxx-driver/tarball/legacy-${TAG}"
DEBEMAIL="psigen@gmail.com"
DEBFULLNAME="Pras Velagapudi"
export DEBEMAIL DEBFULLNAME

# Download the upstream tarball.
rm -f ${PROJECT}-*.tar.gz
wget ${UPSTREAM_TARBALL_URI} -O ${PROJECT}-${TAG}.tar.gz

# Create the GBP repository.
rm -rf ${GBP_REPO_PATH}
mkdir -p ${GBP_REPO_PATH}
pushd ${GBP_REPO_PATH}
git init
git import-orig --pristine-tar ../${PROJECT}-${TAG}.tar.gz

# Create the debian build configuration.
dh_make -p ${PROJECT}_${TAG} \
        -f ../${PROJECT}-${TAG}.tar.gz \
        -c ${LICENSE}

# Commit the resulting generated debian structure.
git add ./debian
git commit -m "Added initial debian structure."
