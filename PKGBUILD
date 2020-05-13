# Maintainer: Jay Tauron <jytrn@protonmail.com>
pkgname=oreo-nord-cursors-git
pkgver=20200512
pkgrel=1
epoch=
pkgdesc="Fork of oreo-cursors with Nord colors"
arch=('any')
url="https://github.com/0jdxt/oreo-nord-cursors"
license=('GPL2')
makedepends=('git' 'gtk-engine-murrine' 'inkscape' 'xorg-xcursorgen' 'python')
provides=()
conflicts=()
options=('!strip')
source=("git+$url.git")
sha256sums=('SKIP')

pkgver() {
	cd "$srcdir/${pkgname%-git}"
	make dist
}

prepare() {
	cd "$srcdir/${pkgname%-git}"
	make clean
}

build() {
	cd "$srcdir/${pkgname%-git}"
    ./generate_colours.py
	make build
}

package() {
	cd "$srcdir/${pkgname%-git}"
	make DESTDIR="$pkgdir/" install
}
