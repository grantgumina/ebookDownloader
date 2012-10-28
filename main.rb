require 'rubygems'
require 'uri'
require 'prawn'
require 'curl'
require 'highline/import'

# ARGUMENTS
email = ask "Enter Email: "
password = ask "Enter Password: "
book_url = ask "Enter Book URL: "
number_of_pages = ask "Enter # Pages: "

temp1 = URI.parse(book_url).query
book_id = temp1.split("/")
book_pages = book_id[4]
book_id = book_id[2]

book_id
book_pages
number_of_pages

# ex info:
# username@gmail.com
# password132
# https://online.vitalsource.com/signin?return=/books/9781121125216/pages/18503748 <-- this is the url your browser navigates to when you open up a book
# 475

randomId = "Textbook_#{Time.now.hour}_#{Time.now.min}_#{Time.now.sec}"
base_url = "#{Dir.home}/Documents/#{randomId}"
cookiesPath = "Documents/#{randomId}/cookies"

if (!Dir.exist?(base_url))
  Dir.mkdir(base_url, 0755)
end

if (!File.exists?(File.join(Dir.home, cookiesPath)))
  File.new(File.join(Dir.home, cookiesPath), 'w+')
end

auth_cmd = "curl -c #{base_url}/cookies --verbose --anyauth --insecure --data \"email=#{email}&password=#{password}\" \"https://online.vitalsource.com/session?return=/books/#{book_id}/pages/#{book_pages}\""
system(auth_cmd);

# TODO - reinstate the session after it expires
for i in 1..number_of_pages.to_i
  if ((i % 100) == 0)
    system(auth_cmd)
  end
  download_cmd = "curl -b #{base_url}/cookies http://online.vitalsource.com/books/#{book_id}/content/image/#{i}.jpg?width=600 > #{base_url}/#{i}.jpg"
  system(download_cmd)
end

Prawn::Document.generate("#{base_url}/textbook.pdf") do |pdf|
  for i in 1..number_of_pages.to_i
    pdf.image("#{base_url}/#{i}.jpg", :position => :left, :vposition => :top)
    puts "#{base_url}/#{i}.jpg"
  end
end
