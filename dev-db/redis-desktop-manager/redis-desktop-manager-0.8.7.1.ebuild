# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 flag-o-matic qmake-utils versionator

DESCRIPTION="Redis desktop manager"
HOMEPAGE="http://redisdesktop.com/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtimageformats:5
	dev-qt/qtdeclarative:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtscript:5
	dev-qt/qtquick1:5

	sys-devel/gcc:4.9.3
	=net-libs/libssh2-1*
	dev-vcs/subversion
"
RDEPEND="${DEPEND}"

MY_PV=$(replace_version_separator 3 '-')
MY_PV3=$(get_version_component_range 1-3 ${PV})
EGIT_REPO_URI="git://github.com/uglide/RedisDesktopManager"
EGIT_COMMIT="refs/tags/${MY_PV}"
EGIT_SUBMODULES=( '*' )

src_prepare() {
	epatch ${FILESDIR}/0.8-gentoo-configure.patch
	sed -i -e "s/${MY_PV3}-dev/${MY_PV}-9999/" src/rdm.pro
}

src_configure() {
	cd src && ./configure
}

src_compile() {
	cd src && eqmake5 && emake
}

src_install() {
	cd src && emake INSTALL_ROOT="${D}" install
	dosym ../share/redis-desktop-manager/bin/rdm /usr/bin/rdm
	fperms +x /usr/share/redis-desktop-manager/bin/rdm.sh
	mv ${D}/usr/share/redis-desktop-manager/bin/qt.conf ${D}/usr/share/redis-desktop-manager/bin/qt.backup
}
