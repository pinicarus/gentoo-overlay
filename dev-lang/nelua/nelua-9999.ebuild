# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Typed compiled metaprogrammable safe programming language with a Lua flavor"
HOMEPAGE="https://nelua.io/"

EGIT_MIN_CLONE_TYPE="shallow"
EGIT_REPO_URI="https://github.com/edubart/nelua-lang.git"
EGIT_BRANCH="master"
inherit git-r3

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack () {
	git-r3_src_unpack
}

src_install() {
	emake PREFIX="${D}/usr" install
	einstalldocs
}
