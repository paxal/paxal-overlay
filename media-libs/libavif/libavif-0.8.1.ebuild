# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION="Library for encoding and decoding .avif files"
HOMEPAGE="https://github.com/AOMediaCodec/libavif"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

EGIT_REPO_URI="https://github.com/AOMediaCodec/libavif"
EGIT_COMMIT="v${PV}"

DEPEND=">=media-libs/libaom-2.0.0"
RDEPEND="${DEPEND}"
BDEPEND=""
