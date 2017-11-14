# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit versionator git-r3 flag-o-matic qmake-utils

DESCRIPTION="Redis desktop manager"
HOMEPAGE="http://redisdesktop.com/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 **"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtimageformats:5
	dev-qt/qtdeclarative:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtscript:5
	dev-qt/qtcharts:5

	>=sys-devel/gcc-5.3.0
	=net-libs/libssh2-1*
	dev-vcs/subversion
"
RDEPEND="${DEPEND}"

EGIT_REPO_URI="git://github.com/uglide/RedisDesktopManager"
EGIT_COMMIT="$(replace_version_separator 3 '-')"

src_configure() {
   	cd src && ./configure breakpad && eqmake5
}

src_compile() {
	cd src && emake
}

src_install() {
	cd src && emake INSTALL_ROOT="${D}" install
	dosym ../share/redis-desktop-manager/bin/rdm /usr/bin/rdm
	fperms +x /usr/share/redis-desktop-manager/bin/rdm.sh
	mv ${D}/usr/share/redis-desktop-manager/bin/qt.conf ${D}/usr/share/redis-desktop-manager/bin/qt.backup
}
