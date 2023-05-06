# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Flat assembler"
HOMEPAGE="https://flatassembler.net"
SRC_URI="https://flatassembler.net/fasmg.k0v2.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-fasmg/xpu-i8087"
RDEPEND="${DEPEND}"
BDEPEND="
	app-arch/unzip
	app-text/dos2unix
"

src_unpack () {
	mkdir "${S}"
	pushd "${S}"
	unpack "${A}"
	popd
}

src_compile () {
	cp examples/x86/include/80287.inc "${T}"
	dos2unix "${T}/80287.inc"
}

src_install () {
	insinto /usr/include/fasmg/xpu/intel
	doins "${T}/80287.inc"
}
