# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

DESCRIPTION="vim plugin: fasmg syntax"
HOMEPAGE="https://github.com/pinicarus/gentoo-overlay"
SRC_URI=""
LICENSE="MIT"
KEYWORDS="amd64"

VIM_PLUGIN_HELPTEXT="This plugin provides syntax highlighting for fasmg files."

src_unpack() {
	mkdir -p "${S}/syntax"
	cp "${FILESDIR}/fasmg.vim" "${S}/syntax/"
	default
}
