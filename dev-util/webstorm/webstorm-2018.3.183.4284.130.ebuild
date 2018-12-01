# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils versionator

DESCRIPTION="JavaScript IDE for client- and server-side development with Node.js"
HOMEPAGE="https://www.jetbrains.com/webstorm"
SRC_URI="https://download.jetbrains.com/${PN}/WebStorm-$(get_version_component_range 1-2).tar.gz"

LICENSE="WebStorm WebStorm_Academic WebStorm_Classroom WebStorm_OpenSource WebStorm_personal"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-custom-jdk"

RESTRICT="splitdebug" #656858

RDEPEND=">=virtual/jdk-1.7:*"

S="${WORKDIR}/WebStorm-$(get_version_component_range 3-6)"
QA_PREBUILT="opt/${PN}/*"

src_install() {
	local dir="/opt/${PN}"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}"/bin/{webstorm.sh,fsnotifier{,64}}

	if use custom-jdk; then
		if [[ -d jre64 ]]; then
		fperms 755 "${dir}"/jre64/bin/{java,jjs,keytool,orbd,pack200,policytool,rmid,rmiregistry,servertool,tnameserv,unpack200}
		fi
	fi

	make_wrapper "${PN}" "${dir}/bin/${PN}.sh"
	newicon "bin/${PN}.svg" "${PN}.svg"
	make_desktop_entry "${PN}" "WebStorm" "${PN}" "Development;IDE;"
}
