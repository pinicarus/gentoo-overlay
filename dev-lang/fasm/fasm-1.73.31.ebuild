# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Flat assembler"
HOMEPAGE="https://flatassembler.net"
SRC_URI="https://flatassembler.net/${P}.tgz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="sys-apps/diffutils"

S="${WORKDIR}/${PN}"
QA_PRESTRIPPED="usr/bin/fasm"

src_compile () {
	local bootstrap
	local src

	if use abi_x86_64; then
		bootstrap="${S}/fasm.x64"
		src=source/Linux/x64/fasm.asm
	elif use abi_x86_32; then
		bootstrap="${S}/fasm"
		src=source/Linux/fasm.asm
	fi
	test -n "${bootstrap}${src}" || die "No compatible ABI found"

	"${bootstrap}" "${src}" "${T}/fasm"
	einfo "Compare bootstrap and target"
	cmp --quiet "${bootstrap}" "${T}/fasm" || die "Stages differ"
}

src_install () {
	dobin "${T}/fasm"
	dodoc fasm.txt
}
