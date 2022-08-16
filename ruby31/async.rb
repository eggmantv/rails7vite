# 需要先安装对应的gem

# bundle add async
require 'async'
require 'net/http'
require 'uri'

LINKS = [
  'https://www.baidu.com',
  'https://eggman.tv'
]

res_codes = []
Async do
  puts Thread.current.to_s
  LINKS.each do |link|
    Async do
      puts Thread.current.to_s
      rsp = Net::HTTP.get_response(URI(link))
      res_codes << [rsp.code, link]
    end
  end
end

puts Thread.current.to_s
puts "task created!"
puts res_codes