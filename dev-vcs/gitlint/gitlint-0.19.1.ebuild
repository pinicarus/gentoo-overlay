# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{7..11} )

inherit distutils-r1 pypi

DESCRIPTION="Git commit message linter"
HOMEPAGE="https://github.com/jorisroovers/gitlint"
SRC_URI="$(pypi_sdist_url "${PN}-core")"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
RESTRICT="test"

DEPEND=""
RDEPEND="
	dev-python/arrow[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/hatch-vcs[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}_core-${PV}"

distutils_enable_tests pytest
