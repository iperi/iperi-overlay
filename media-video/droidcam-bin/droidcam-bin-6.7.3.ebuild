# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils linux-mod user

DESCRIPTION="Use your Android phone as a wireless webcam"
HOMEPAGE="http://www.dev47apps.com/"
SRC_URI="x86? ( https://www.dev47apps.com/files/600/droidcam-64bit.tar.bz2 -> droidcam-32bit-${PV}.tbz2 )
	amd64? ( https://www.dev47apps.com/files/600/droidcam-64bit.tar.bz2 -> droidcam-64bit-${PV}.tbz2 )
	https://files.dev47apps.net/img/app_icon.png -> droidcam-icon-${PV}.png"

LICENSE="as-is"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="net-wireless/bluez"
RDEPEND="${DEPEND}"

BUILD_TARGETS="all"
BUILD_TARGET_ARCH="${ARCH}"
MODULE_NAMES="v4l2loopback-dc(kernel/drivers/media/v4l2-core:${S}/v4l2loopback)"
RESTRICT="mirror"

src_unpack() {
	if use x86; then
		unpack droidcam-32bit-${PV}.tbz2
		mv ${WORKDIR}/droidcam-32bit ${WORKDIR}/droidcam-bin-${PV}
	elif use amd64; then
		unpack droidcam-64bit-${PV}.tbz2
		mv ${WORKDIR}/droidcam-64bit ${WORKDIR}/droidcam-bin-${PV}
	else
		die "wtf"
	fi
}

src_install() {
	cd "${S}"
	dobin droidcam droidcam-cli
	# doicon droidcam.png
	newicon ${DISTDIR}/droidcam-icon-${PV}.png droidcam.png
	linux-mod_src_install
	dodoc README
	# Does not exist
	#domenu "${FILESDIR}"/droidcam.desktop
}
