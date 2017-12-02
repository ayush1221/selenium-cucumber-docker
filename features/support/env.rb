require 'rspec' #for page.shoud etc
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'pry'


#because it's an internal URL and I'm on reith, we don't need the proxy...
#ENV['HTTP_PROXY'] = ENV['http_proxy'] = nil

#get IP of host which has 4444 mapped from other container
docker_ip = %x(/sbin/ip route|awk '/default/ { print $3 }').strip

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app,
  :browser => :remote,
  :desired_capabilities => :chrome,
  :url => "http://#{docker_ip}:4444/wd/hub")
  #puts docker_ip
end

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :chrome
  config.app_host = 'http://www.google.com' # change url
end
