# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Syntax highlighting for Nelua programming language"
HOMEPAGE="https://github.com/stefanos82/nelua.vim"

EGIT_MIN_CLONE_TYPE="shallow"
EGIT_REPO_URI="https://github.com/stefanos82/nelua.vim.git"
EGIT_BRANCH="main"
inherit git-r3

LICENSE="public-domain"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack () {
	git-r3_src_unpack
}

src_install () {
	insinto /usr/share/vim/vimfiles
	doins -r after ftdetect syntax
}
