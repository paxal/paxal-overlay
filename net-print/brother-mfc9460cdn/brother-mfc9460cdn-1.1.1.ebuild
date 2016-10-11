# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit rpm

DESCRIPTION="Brother printer driver for MFC-9340CDW"

HOMEPAGE="http://support.brother.com"

SRC_URI="http://download.brother.com/welcome/dlf006484/mfc9460cdnlpr-1.1.1-5.i386.rpm
http://download.brother.com/welcome/dlf006486/mfc9460cdncupswrapper-1.1.1-5.i386.rpm"

#LICENSE="brother-eula"

SLOT="0"

KEYWORDS="amd64"

IUSE=""

RESTRICT="mirror strip"

DEPEND="net-print/cups"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_unpack() {
	rpm_unpack ${A}
}

src_install() {
	has_multilib_profile && ABI=x86

	dosbin "${WORKDIR}/usr/bin/brprintconf_mfc9460cdn"

	cp -r usr "${D}" || die

	mkdir -p "${D}/usr/libexec/cups/filter" || die
	( cd "${D}/usr/libexec/cups/filter/" && ln -s ../../../local/Brother/Printer/mfc9460cdn/lpd/filtermfc9460cdn brlpdwrappermfc9460cdn ) || die

	mkdir -p "${D}/usr/share/cups/model" || die
	( cd "${D}/usr/share/cups/model" && ln -s ../../../local/Brother/Printer/mfc9460cdn/cupswrapper/mfc9460cdn.ppd) || die
}
