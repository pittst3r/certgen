# certgen

Docker image for generating self-signed CA and leaf X.509 certificates. For
internal/private use only; self-signed certificates should not be exposed
publicly because they cannot be verified and trusted by a third-party.

## Usage

```shell
certgen COMMAND [OPTIONS] [ARGUMENTS]
```

### Examples

```shell
docker run -v $PWD/certs:/certs pittst3r/certgen ca foo-ca
docker run -v $PWD/certs:/certs pittst3r/certgen leaf foo-ca bar-baz
openssl verify -CAfile certs/foo-ca.crt certs/bar-baz.crt
# > certs/bar-baz.crt: OK
```

### Commands

#### `ca`

Generate a self-signed root CA certificate and private key.

##### Arguments

1. The Common Name of the CA, which will also be used as the cert and key file
   names (less the extension); IMPORTANT: this name cannot be shared by any of
   the certificates you create with this root certificate

##### Options

- `--ttl <integer>`: (default: `3650`) Number of days for which the certificate
  will be valid
- `--mode <integer>`: (default: `0600`) Sets the mode of the files

#### `leaf`

Generate a leaf certificate using the given CA certificate/key.

##### Arguments

1. The Common Name of the CA certificate
2. The Common Name of this certificate, which will also be used as the cert and
   key file names (less the extension)

##### Options

- `--ttl <integer>`: (default: `30`) Number of days for which the certificate
  will be valid
- `--mode <integer>`: (default: `0600`) Sets the mode of the files
