require 'faraday'

connection = Faraday.new('https://example.com', :ssl => {
  # Peer verification is true by default
  :verify => true,
  # Rarely needed. If you need to be explicit, set:
  :verify_mode => OpenSSL::SSL::VERIFY_PEER,

  # Override SSL_CERT_FILE: the path to your CA bundle
  :ca_file => '/path/to/ca_cert.pem',
  # Override SSL_CERT_DIR: the directory with individual cert files
  :ca_path => '/path/to/certs/',

  # Optional. Store extra certificates that you will trust.
  :cert_store => OpenSSL::X509::Store.new,

  # Max length of cert chain to be verified
  :verify_depth => 3,

  # Rarely needed. Set client certificate and private key.
  :client_cert => OpenSSL::X509::Certificate.new,
  :client_key => OpenSSL::PKey::RSA.new
}) do
  conn.request :url_encoded
  conn.response :raise_error
  conn.response :logger
  conn.adapter :net_http
end

connection.get('/hello')
