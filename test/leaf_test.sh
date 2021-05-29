set -e

echo "Basic leaf cert generation"

certgen ca foo-ca
certgen leaf foo-ca foo-bar

test -f foo-ca.crt
test -f foo-ca.key
test ! -f foo-ca.csr
test -f foo-ca.srl
test -f foo-bar.crt
test -f foo-bar.key
test ! -f foo-bar.csr
openssl verify -CAfile foo-ca.crt foo-bar.crt
