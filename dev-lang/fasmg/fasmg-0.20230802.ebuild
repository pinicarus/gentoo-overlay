# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Flat assembler"
HOMEPAGE="https://flatassembler.net"
SRC_URI="https://flatassembler.net/${PN}.k4v8.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
REQUIRED_USE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	app-arch/unzip
	sys-apps/diffutils
"

QA_PRESTRIPPED="usr/bin/fasmg"

src_unpack () {
	mkdir "${S}"
	pushd "${S}"
	unpack "${A}"
	popd
}

src_compile () {
	local bootstrap
	local src

	if use abi_x86_64; then
		bootstrap="${S}/fasmg.x64"
		src=source/linux/x64/fasmg.asm
	elif use abi_x86_32; then
		bootstrap="${S}/fasmg"
		src=source/linux/fasmg.asm
	fi
	test -n "${bootstrap}${src}" || die "No compatible ABI found"
	mkdir --parents "${T}/bin" "${T}/include/fasmg"

	"${bootstrap}" "${src}" "${T}/bin/fasmg"
	einfo "Compare bootstrap and target"
	cmp --quiet "${bootstrap}" "${T}/bin/fasmg" || die "Stages differ"
}

src_install () {
	dobin "${T}/bin/fasmg"
	dodoc docs/fasmg.txt
	dodoc docs/manual.txt

	insinto /usr/share/portage/config/sets
	newins "${FILESDIR}/set.conf" fasmg.conf
}

pkg_postinst () {
	elog "Run 'emerge @fasmg-rebuild' to rebuild all 'fasmg' packages"
}
