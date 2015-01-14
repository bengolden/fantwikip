require 'uri'
require 'open-uri'


# uri = URI.parse("http://stats.grok.se/json/en/201401/el%20niño")

# # puts uri

# puts URI.encode_www_form("el niño", enc=nil)
puts OpenURI.public_methods#encode("el niño")