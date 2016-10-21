# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit rpm

DESCRIPTION="Brother printer driver for MFC-9340CDW"

HOMEPAGE="http://support.brother.com"

SRC_URI="http://download.brother.com/welcome/dlf101196/mfcj5620dwlpr-3.0.1-1.i386.rpm
http://download.brother.com/welcome/dlf101197/mfcj5620dwcupswrapper-3.0.1-1.i386.rpm"

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

	dobin "${WORKDIR}/usr/bin/brprintconf_mfcj5620dw"

	cp -r opt "${D}" || die

	mkdir -p "${D}/usr/libexec/cups/filter" || die
	( cd "${D}/usr/libexec/cups/filter/" && ln -s ../../../../opt/brother/Printers/mfcj5620dw/lpd/filtermfcj5620dw brlpdwrappermfcj5620dw ) || die
	( cd "${D}/usr/libexec/cups/filter/" && ln -s ../../../../opt/brother/Printers/mfcj5620dw/lpd/filtermfcj5620dw brother_lpdwrapper_mfcj5620dw ) || die
	mkdir -p "${D}/usr/share/cups/model" || die
	( cd "${D}/usr/share/cups/model" && ln -s ../../../../opt/brother/Printers/mfcj5620dw/cupswrapper/brother_mfcj5620dw_printer_en.ppd) || die
}
