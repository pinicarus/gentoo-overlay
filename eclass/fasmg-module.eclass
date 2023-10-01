# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: fasmg-module.eclass
# @MAINTAINER:
# Pierre-Nicolas Clauss <pinicarus@protonmail.com>
# @AUTHOR:
# Pierre-Nicolas Clauss <pinicarus@protonmail.com>
# @SUPPORTED_EAPIS: 8
# @BLURB: Eclass for installing fasmg modules.
# @DESCRIPTION:
# This eclass provides default src_unpask, src_compile and src_install functions
# for modules written with fasmg.

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ ! ${_FASMG_MODULE_ECLASS} ]]; then
_FASMG_MODULE_ECLASS=1

test -n "${FASMG_MODULE_FILES}" || die "${ECLASS}: FASMG_MODULE_FILES not set"
test -n "${FASMG_MODULE_INSINTO}" || die "${ECLASS}: FASMG_MODULE_INSINTO not set"

BDEPEND+="
	app-arch/unzip
	app-text/dos2unix
"

fasmg-module_src_unpack() (
	mkdir "${S}"
	cd "${S}"
	unpack "${A}"
)

fasmg-module_src_compile() (
	for FILE in "${FASMG_MODULE_FILES[@]}"; do
		BASENAME=$(basename "${FILE}")
		cp "${FILE}" "${T}"
		dos2unix "${T}/${BASENAME}"
	done
)

fasmg-module_src_install() (
	insinto "/usr/include/fasmg/${FASMG_MODULE_INSINTO}"
	for FILE in "${FASMG_MODULE_FILES[@]}"; do
		BASENAME=$(basename "${FILE}")
		doins "${T}/${BASENAME}"
	done
)

fi

EXPORT_FUNCTIONS src_unpack src_compile src_install
