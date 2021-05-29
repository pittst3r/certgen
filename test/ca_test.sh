set -e

echo '`certgen ca` produces expected files'

certgen ca foo-ca

test -f foo-ca.crt
test -f foo-ca.key
test ! -f foo-ca.csr
