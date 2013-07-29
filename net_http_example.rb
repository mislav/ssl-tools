require 'https'

uri = URI('https://example.com/hello?world')

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = uri.scheme == 'https' || uri.port == 443

if http.use_ssl?
  ## Important. Turns on certificate verification
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

  ## Override SSL_CERT_FILE: the path to your CA bundle
  http.ca_file = '/path/to/ca_cert.pem'
  ## Override SSL_CERT_DIR: the directory with individual cert files
  http.ca_path = '/path/to/certs/'

  ## Optional. Configure extra certificates that you will trust.
  http.cert_store = OpenSSL::X509::Store.new
  http.cert_store.set_default_paths
  http.cert_store.add_file('/path/to/cacert.pem')
  # ...or:
  cert = OpenSSL::X509::Certificate.new(File.read('mycert.pem'))
  http.cert_store.add_cert(cert)

  http.ssl_timeout = 5 # seconds
  http.verify_depth = 3 # max length of cert chain to be verified

  ## Optional. Set the client certificate. This enables servers which support it
  ## to verify that YOU are who you claim to be as well. You probably don't need this.
  # http.cert = OpenSSL::X509::Certificate.new(...)
  # Provide the private key for the client certificate
  # http.key = OpenSSL::PKey::RSA.new(...)
end

user_agent = "net/http #{RUBY_VERSION}"
req = Net::HTTP::Get.new(uri.request_uri, 'user-agent' => user_agent)

begin
  res = http.start { http.request(req) }
  abort res.inspect if res.code.to_i >= 300
  puts res.body
rescue Errno::ECONNREFUSED
  abort "Error: connection refused"
rescue OpenSSL::SSL::SSLError
  abort "SSLError: #{$!.message}"
end
