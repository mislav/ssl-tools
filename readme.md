# SSL tools

    der2pem FILES...

    remote-cert status.github.com | show-cert

    create-cert example.com "My Organization" > cert_and_key.pem

    ruby doctor.rb example.com:443

Sample output of `doctor.rb`:

```
/Users/mislav/.rbenv/versions/2.0.0-p247/bin/ruby (2.0.0-p247)
OpenSSL 1.0.1e 11 Feb 2013: /usr/local/etc/openssl
SSL_CERT_DIR=""
SSL_CERT_FILE=""

HEAD https://status.github.com:443
OpenSSL::SSL::SSLError: SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed

The server presented a certificate that could not be verified:
subject: /C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert High Assurance CA-3
issuer: /C=US/O=DigiCert Inc/OU=www.digicert.com/CN=DigiCert High Assurance EV Root CA
error code 20: unable to get local issuer certificate

Possible causes:
- `/usr/local/etc/openssl/cert.pem' does not exist
- `/usr/local/etc/openssl/certs/' is empty
```
