# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Standard library for the C3 programming language"
HOMEPAGE="https://c3-lang.org/"

EGIT_MIN_CLONE_TYPE="shallow"
EGIT_REPO_URI="https://github.com/c3lang/c3c.git"
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
	insinto /usr/lib/c3
	doins -r lib/std
}
