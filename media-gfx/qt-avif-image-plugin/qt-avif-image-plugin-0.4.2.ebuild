# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 flag-o-matic qmake-utils eutils

DESCRIPTION="Qt plug-in to allow Qt and KDE based applications to read/write AVIF images."
HOMEPAGE="https://github.com/novomesk/qt-avif-image-plugin"
SRC_URI=""

EGIT_REPO_URI="https://github.com/novomesk/qt-avif-image-plugin"
EGIT_COMMIT="v${PV}"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="media-libs/libavif"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	eqmake5 ${PN}.pro
}

src_install() {
	emake install INSTALL_ROOT="${D}"
}
