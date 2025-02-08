# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FASMG_MODULE_INSINTO=fmt
FASMG_MODULE_FILES=(
	examples/x86/include/format/pe.inc
)

inherit fasmg-module

DESCRIPTION="Flat assembler"
HOMEPAGE="https://flatassembler.net"
SRC_URI="https://flatassembler.net/fasmg.kp60.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-fasmg/xpu-i8086"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/${PV}/xpu-8086.diff"
)
