This folder contains self-signed certificates used for testing.

`localhost.crt` and `certstore.p12` are generated from `localhost.key` using
the following commands:

```sh
openssl req -x509 \
            -key localhost.key \
            -not_before 20190101000000Z \
            -not_after 21181208000000Z \
            -set_serial 1 \
            -subj '/CN=localhost' \
            -addext extendedKeyUsage=serverAuth,clientAuth \
            -addext subjectAltName=DNS:localhost \
            -out localhost.crt
openssl pkcs12 -legacy \
               -export \
               -macsaltlen 16 \
               -inkey localhost.key \
               -in localhost.crt \
               -passout pass:correct \
               -out certstore.p12
```

Note that the choice of starting date for certificate as well as the choice
of extensions (EKU and SAN) are crucial for satisfying
[Mac OS X requirements](https://support.apple.com/en-us/HT210176) for TLS
certificates.

If these are not satisfied tests will hang and spew cryptic "Connection
terminated during handshake" errors.
