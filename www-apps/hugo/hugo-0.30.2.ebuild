# Distributed under the terms of the GNU General Public License v2

EAPI=6
# Following dep list is https://github.com/spf13/hugo/blob/v${PV}/vendor/vendor.json
EGO_VENDOR=( "github.com/BurntSushi/toml 99064174e013895bbd9b025c31100bd1d9b590ca"
	"github.com/PuerkitoBio/purell 0bcb03f4b4d0a9428594752bd2a3b9aa0a9d4bd4"
	"github.com/PuerkitoBio/urlesc 5bd2802263f21d8788851d5305584c82a5c75d7e"
	"github.com/bep/gitmap dcb907b39a0690430d435eb8f63cd8811961231f"
	"github.com/bep/inflect b896c45f5af983b1f416bdf3bb89c4f1f0926f69"
	"github.com/chaseadamsio/goorgeous 42b0ec184e93fc9fd2c0402f099a4939aba68407"
	"github.com/cpuguy83/go-md2man a65d4d2de4d5f7c74868dfa9b202a3c8be315aaa"
	"github.com/dchest/cssmin fb8d9b44afdc258bfff6052d3667521babcb2239"
	"github.com/eknkc/amber 9be5e8aae85904f63d505e0c00e5e0881d44ef4d"
	"github.com/fortytw2/leaktest 0db74e8cd5adacfcc982838c6e185789e4b44e14"
	"github.com/fsnotify/fsnotify 4da3e2cfbabc9f751898f250b49f2439785783a1"
	"github.com/gorilla/websocket adf16b31781325cbd41085c5be901d95b4d1f33d"
	"github.com/hashicorp/hcl 80e628d796135357b3d2e33a985c666b9f35eee1"
	"github.com/inconshreveable/mousetrap 76626ae9c91c4f2a10f34cad8ce83ea42c93bb75"
	"github.com/kardianos/osext 9b883c5eb462dd5cb1b0a7a104fe86bc6b9bd391"
	"github.com/kr/fs 2788f0dbd16903de03cb8186e5c7d97b69ad387b"
	"github.com/kyokomi/emoji 7e06b236c489543f53868841f188a294e3383eab"
	"github.com/magiconair/properties 9c47895dc1ce54302908ab8a43385d1f5df2c11c"
	"github.com/miekg/mmark 2d4f1dd6f87cad351b9323bbaa6f6c586f0c4bee"
	"github.com/mitchellh/mapstructure bfdb1a85537d60bc7e954e600c250219ea497417"
	"github.com/nicksnyder/go-i18n 4df9b06c0c1ffd8538a3cfa9d888f8f52985b302"
	"github.com/opennota/urlesc 5bd2802263f21d8788851d5305584c82a5c75d7e"
	"github.com/pelletier/go-buffruneio c37440a7cf42ac63b919c752ca73a85067e05992"
	"github.com/pelletier/go-toml fee7787d3f811af92276f5ff10107092e95b7a1d"
	"github.com/pkg/errors 248dadf4e9068a0b3e79f02ed0a610d935de5302"
	"github.com/pkg/sftp 4d0e916071f68db74f8a73926335f809396d6b42"
	"github.com/russross/blackfriday 5f33e7b7878355cd2b7e6b8eefc48a5472c69f70"
	"github.com/shurcooL/sanitized_anchor_name 1dba4b3954bc059efc3991ec364f9f9a35f597d2"
	"github.com/spf13/afero 9be650865eab0c12963d8753212f4f9c66cdcf12"
	"github.com/spf13/cast ce135a4ebeee6cfe9a26c93ee0d37825f26113c7"
	"github.com/spf13/cobra 7be4beda01ec05d0b93d80b3facd2b6f44080d94"
	"github.com/spf13/fsync 12a01e648f05a938100a26858d2d59a120307a18"
	"github.com/spf13/jwalterweatherman fa7ca7e836cf3a8bb4ebf799f472c12d7e903d66"
	"github.com/spf13/nitro 24d7ef30a12da0bdc5e2eb370a79c659ddccf0e8"
	"github.com/spf13/pflag 9ff6c6923cfffbcd502984b8e0c80539a94968b7"
	"github.com/spf13/viper 7538d73b4eb9511d85a9f1dfef202eeb8ac260f4"
	"github.com/stretchr/testify 4d4bfba8f1d1027c4fdbe371823030df51419987"
	"github.com/yosssi/ace ea038f4770b6746c3f8f84f14fa60d9fe1205b56"
	"golang.org/x/crypto 453249f01cfeb54c3d549ddb75ff152ca243f9d8 github.com/golang/crypto"
	"golang.org/x/net 906cda9512f77671ab44f8c8563b13a8e707b230 github.com/golang/net"
	"golang.org/x/sys 075e574b89e4c2d22f2286a7e2b919519c6f3547 github.com/golang/sys"
	"golang.org/x/text 0ad425fe45e885577bef05dc1c50f72e33188b16 github.com/golang/text"
	"gopkg.in/yaml.v2 a3f3340b5840cee44f372bddb5880fcbc419b46a github.com/go-yaml/yaml" )

inherit golang-build golang-vcs-snapshot

EGO_PN="github.com/spf13/hugo/..."
GIT_COMMIT="4bfb013"
ARCHIVE_URI="https://${EGO_PN%/*}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

DESCRIPTION="A Fast and Flexible Static Site Generator built with love in Go"
HOMEPAGE="https://github.com/spf13/hugo"
SRC_URI="${ARCHIVE_URI}
	${EGO_VENDOR_URI}"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

RDEPEND=">=dev-python/pygments-2.1.3"

RESTRICT="test"

src_prepare() {
	default
	sed -i -e "s/^COMMIT_HASH.*/COMMIT_HASH = ${GIT_COMMIT}/" -e "s/install: vendor/install:/" src/${EGO_PN%/.*}/Makefile || die
}

src_compile() {
	GOPATH="${WORKDIR}/${P}" emake -C src/${EGO_PN%/.*} install || die
}

src_install() {
	dobin bin/*
}
