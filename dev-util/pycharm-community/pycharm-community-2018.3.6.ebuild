# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils readme.gentoo-r1 xdg

DESCRIPTION="Intelligent Python IDE with unique code assistance and analysis"
HOMEPAGE="https://www.jetbrains.com/pycharm/"
SRC_URI="http://download.jetbrains.com/python/${P}.tar.gz"

LICENSE="Apache-2.0 BSD CDDL MIT-with-advertising"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-custom-jdk"

RDEPEND="!custom-jdk? ( >=virtual/jre-1.8 )
	dev-python/pip"

RESTRICT="mirror strip"

QA_PREBUILT="opt/${PN}/bin/fsnotifier
	opt/${PN}/bin/fsnotifier64
	opt/${PN}/bin/fsnotifier-arm"

MY_PN=${PN/-community/}
S="${WORKDIR}/${PN}-${PV}"

src_prepare() {
	default

	use custom-jdk || rm -rf jre64
}

src_install() {
	local dir="/opt/${PN}"

	insinto "${dir}"
	doins -r *

	fperms a+x /opt/${PN}/bin/{pycharm.sh,fsnotifier{,64},inspect.sh}

	if use custom-jdk; then
		if [[ -d jre64 ]]; then
		fperms 755 "${dir}"/jre64/bin/{java,jjs,keytool,orbd,pack200,policytool,rmid,rmiregistry,servertool,tnameserv,unpack200}
		fi
	fi

	dosym ../../opt/${PN}/bin/pycharm.sh /usr/bin/${PN}
	newicon bin/${MY_PN}.png ${PN}.png
	make_desktop_entry ${PN} ${PN} ${PN}

	readme.gentoo_create_doc
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_icon_cache_update
}
