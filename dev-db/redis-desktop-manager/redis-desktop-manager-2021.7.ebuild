# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

PYTHON_COMPAT=( python3_7 python3_8 python3_9 )

inherit git-r3 flag-o-matic qmake-utils python-single-r1

REQUIRED_USE="${PYTHON_REQUIRED_USE}"


DESCRIPTION="Redis desktop manager"
HOMEPAGE="http://redisdesktop.com/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 **"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtimageformats:5
	dev-qt/qtdeclarative:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtscript:5
	dev-qt/qtcharts:5[qml]
	dev-qt/qtconcurrent:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5

	$(python_gen_cond_dep '
		dev-python/PyQt5[${PYTHON_USEDEP}]
	')


	>=sys-devel/gcc-5.3.0
	=net-libs/libssh2-1*
"
RDEPEND="${DEPEND}"

EGIT_REPO_URI="https://github.com/uglide/RedisDesktopManager"
EGIT_COMMIT="$(ver_cut 1-2 ${PV})"

MY_RDM_BIN_OPT="/opt/redis-desktop-manager"
FEATURES="-network-sandbox"

#src_prepare() {
#	default
#	eapply ${FILESDIR}/0.9.6-nolog.patch
#}

#src_unpack() {
	#git-r3_src_unpack
	#cd "${S}"
	#(cd 3rdparty/gbreakpad && git clone --depth 1 -v https://github.com/RedisDesktop/linux-syscall-support.git src/third_party/lss)
#}

src_configure() {
	#sed -e 's@usr/local/lib/libssh2@usr/lib/libssh2@' -i 3rdparty/qredisclient/3rdparty/qsshclient/3rdparty/3rdparty.pri
	#cd src && ./configure breakpad && echo "#define RDM_VERSION \"${PV}\"" > version.h && eqmake5
	#sed -e 's@build/cmake/liblz4.a@liblz4.a@' -i 3rdparty/3rdparty.pri
	cd src && echo "#define RDM_VERSION \"${PV}\"" > version.h && eqmake5 "SYSTEM_LZ4=1" "VERSION=${PV}-dev"
}

src_compile() {
	cd src && emake
}

src_install() {
	cd src && emake INSTALL_ROOT="${D}" install
	dosym ../..${MY_RDM_BIN_OPT}/rdm.sh /usr/bin/rdm
	fperms +x ${MY_RDM_BIN_OPT}/rdm.sh
	mv ${D}${MY_RDM_BIN_OPT}/qt.conf ${D}${MY_RDM_BIN_OPT}/qt.backup
}
