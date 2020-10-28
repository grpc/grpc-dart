This folder contains self-signed certificates used for testing.

These files are generated using the following commands:

```
$ faketime '2019-01-01' openssl req -newkey rsa:2048                      \
                                    -nodes                                \
                                    -keyout localhost.key                 \
                                    -x509                                 \
                                    -days 36500                           \
                                    -out localhost.crt                    \
                                    -addext extendedKeyUsage=serverAuth   \
                                    -addext subjectAltName=DNS:localhost
# CN=localhost, the rest of the fields are left empty (.)
$ openssl pkcs12 -export -out certstore.p12 -inkey localhost.key -in localhost.crt
# Password: correct
```

Note that the choice of starting date for certificate as well as the choice
of extensions (EKU and SAN) are crucial for satisfying
[Mac OS X requirements](https://support.apple.com/en-us/HT210176) for TLS
certificates.

If these are not satisfied tests will hang and spew cryptic "Connection
terminated during handshake" errors.
