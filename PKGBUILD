# Maintainer: Saphira Kai <kai.saphira@gmail.com>
pkgname='gitch'
pkgver=r2.4ba9231
pkgrel=1
epoch=
pkgdesc='Git Clone Helper - automatically find git repositories for cloning'
arch=('any')
url='https://github.com/SaphiraKai/gitch'
license=('MIT')
groups=()
depends=(bash curl git)
makedepends=()
checkdepends=()
optdepends=()
provides=()
conflicts=()
replaces=()
backup=()
options=()
install=
changelog=
source=('gitch.sh')
noextract=()
sha256sums=('SKIP')
validpgpkeys=()

pkgver() {
    mkdir -p "$pkgdir/usr/bin/"
    cd "$pkgdir"
    (
        set -o pipefail
        git describe --long 2>/dev/null | sed 's/\([^-]*-g\)/r\1/;s/-/./g' ||
        printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
    )
}

#prepare() {}

#build() {}

#check() {}

package() {
    install -Dm 755 'gitch.sh' "$pkgdir/usr/bin/gitch"
}
