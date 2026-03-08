# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="A configuration database tool."
HOMEPAGE="https://www.kernel.org"
SRC_URI="https://cdn.kernel.org/pub/linux/kernel/v$(ver_cut 1).x/linux-${PV}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

IUSE="ncurses gtk qt5"

DEPEND="
	ncurses? ( sys-libs/ncurses )
	gtk? (
		gnome-base/libglade:2.0
		x11-libs/gtk+:2
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
	)
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-alternatives/tar
	app-arch/xz-utils
"

S="${WORKDIR}/linux-${PV}"

src_unpack() {
	# Manually unpack until partial unpacking is supported.
	unpack_banner "${A}"
	tar xf "${DISTDIR}/${A}" \
		"linux-${PV}/Makefile" \
		"linux-${PV}/scripts/Kbuild.include" \
		"linux-${PV}/scripts/Makefile.build" \
		"linux-${PV}/scripts/Makefile.compiler" \
		"linux-${PV}/scripts/Makefile.host" \
		"linux-${PV}/scripts/Makefile.lib" \
		"linux-${PV}/scripts/subarch.include" \
		"linux-${PV}/scripts/basic" \
		"linux-${PV}/scripts/kconfig" \
		"linux-${PV}/scripts/include" \
		|| die "unpacking failed"
	mkdir -p "linux-${PV}/arch/dummy" || die "creation of dummy arch directory failed"
	touch "linux-${PV}/arch/dummy/Makefile" || die "create of dummy arch file failed"
}

src_compile() {
	emake SRCARCH=dummy build_config || die "conf build failed"
	use ncurses && {
		emake SRCARCH=dummy build_menuconfig || die "mconf build failed"
		emake SRCARCH=dummy build_nconfig    || die "nconf build failed"
	}
	use gtk && {
		emake SRCARCH=dummy build_gconfig || die "gconf build failed"
		cat > gconf <<- EOF
		#!/bin/sh
		exec /usr/libexec/${PN}/gconf "\${@}"
		EOF
		chmod a+x gconf
	}
	use qt5 && {
		emake SRCARCH=dummy build_xconfig || die "qconf build failed"
	}
}

src_install() {
	dobin scripts/kconfig/conf
	use ncurses && {
		dobin scripts/kconfig/mconf
		dobin scripts/kconfig/nconf
	}
	use gtk && {
		dobin gconf
		exeinto "/usr/libexec/${PN}"
		doexe scripts/kconfig/gconf
		insinto "/usr/libexec/${PN}"
		doins scripts/kconfig/gconf.glade
	}
	use qt5 && dobin scripts/kconfig/qconf
}
