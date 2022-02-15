# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The WebAssembly Binary Toolkit"
HOMEPAGE="https://github.com/WebAssembly/wabt"
SRC_URI="https://github.com/WebAssembly/${PN}/releases/download/${PV}/${P}.tar.xz"

inherit cmake

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"

src_configure () {
	local mycmakeargs=(
		"-Wno-dev"
		"-DCMAKE_C_COMPILER=gcc"
		"-DCMAKE_CXX_COMPILER=g++"
		"-DCMAKE_BUILD_TYPE=Release"
	)
	cmake_src_configure || die
}

src_test () {
	test/run-tests.py || die
}
