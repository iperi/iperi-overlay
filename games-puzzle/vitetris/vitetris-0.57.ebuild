# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit games

DESCRIPTION="Terminal-based Tetris clone by Victor Nilsson"
HOMEPAGE="http://victornils.net/tetris/"
SRC_URI="http://victornils.net/tetris/${P}.tar.gz"

LICENSE="vitetris"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+joystick
	-ncurses
	-X
	+2player
	+network
	-allegro
	+term-resizing
	+menu
	+blockstyles
	+pctimer"

DEPEND="virtual/libc
	X? ( x11-libs/libX11 )
	ncurses? ( sys-libs/ncurses )
	allegro? ( >=media-libs/allegro-4.4.2 )"
RDEPEND="${DEPEND}"

do_configure() {
	./configure \
		--prefix=/usr \
		$(use_enable 2player) \
		$(use_enable joystick) \
		$(use_enable network) \
		$(use_enable ncurses curses) \
		$(use_enable X xlib) \
		$(use_enable allegro) \
		$(use_enable term-resizing term_resizing) \
		$(use_enable menu) \
		$(use_enable blockstyles) \
		$(use_enable pctimer) || die "econf failed"
}

src_compile() {
	do_configure
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR=${D}
	dodoc INSTALL README
}
