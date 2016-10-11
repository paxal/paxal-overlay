# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils

DESCRIPTION="A Hipchat client"
HOMEPAGE="http://www.hipchat.com/"

SRC_URI="http://downloads.hipchat.com/linux/arch/x86_64/hipchat-${PV}-x86_64.pkg.tar.xz"

LICENSE=""
SLOT="2"
KEYWORDS="amd64"

DEPEND="media-libs/gst-plugins-base:0.10"

S=${WORKDIR}

src_install() {
	doins -r *
	mv ${D}/usr/bin/hipchat ${D}/usr/bin/hipchat2
	fperms -R 0755 /opt/HipChat/bin/ /opt/HipChat/lib/hipchat.bin
}
