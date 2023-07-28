# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A PIC-like markup language for diagrams in technical documentation."
HOMEPAGE="https://pikchr.org"
SRC_HASH="589586a89e"
SRC_URI="https://pikchr.org/home/tarball/589586a89e/pikchr-${SRC_HASH}.tar.gz"

LICENSE="0BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${SRC_HASH}"

src_install() {
	dobin "${PN}"
	dodoc -r doc/*
}
