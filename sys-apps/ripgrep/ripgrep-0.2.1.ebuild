# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit flag-o-matic

DESCRIPTION="Ripgrep"
HOMEPAGE="https://github.com/BurntSushi/ripgrep"
SRC_URI="https://github.com/BurntSushi/ripgrep/archive/${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="
	dev-lang/rust
	dev-util/cargo
"
RDEPEND="${DEPEND}"

#EGIT_REPO_URI="git://github.com/BurntSushi/ripgrep"
#EGIT_COMMIT="refs/tags/${PV}"
#EGIT_SUBMODULES=( '*' )

src_compile() {
	CARGO_HOME=${WORKDIR}/.cargo cargo build --release || die Unable to compile
}

src_install() {
	newbin target/release/rg ripgrep
	dosym ${DESTTREE}/bin/ripgrep ${DESTTREE}/bin/rg

	newman doc/rg.1 ripgrep.1
}

