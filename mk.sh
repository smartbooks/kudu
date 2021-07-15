#!/usr/bin/env bash

#brew tap homebrew/dupes
#brew install autoconf automake cmake git krb5 libtool openssl pkg-config pstree
#brew uninstall libtool && brew install libtool
#sudo xcodebuild -license
#sudo xcode-select --install

export cur_home=$(cd `dirname $0`; pwd)

cd ${cur_home}

mkdir -p ${cur_home}/build/release

cd ${cur_home}/build/release

${cur_home}/build-support/enable_devtoolset.sh

${cur_home}/thirdparty/build-if-necessary.sh

export PATH=${cur_home}/thirdparty/installed/common/bin:$PATH

${cur_home}/thirdparty/installed/common/bin/cmake \
-DNO_TESTS=1
-DCMAKE_BUILD_TYPE=release \
-DOPENSSL_ROOT_DIR=/usr/local/opt/openssl@1.1 \
-DKUDU_CLIENT_INSTALL=ON \
-DKUDU_MASTER_INSTALL=OFF \
-DKUDU_TSERVER_INSTALL=OFF \
${cur_home}

make -j4

mkdir -p ${cur_home}/build/opt/kudu

make DESTDIR=${cur_home}/build/opt/kudu install
