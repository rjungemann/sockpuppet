require 'shellwords'
require 'pathname'
require 'erb'

$prefix = Pathname.new(".").realpath.to_s

require "#{$prefix}/lib/sockpuppet"

$sdk_path = "#{$prefix}/vendor/sdk".shellescape
$mxmlc_path = "#{$sdk_path}/bin/mxmlc"

if !File.exists? $sdk_path
  $sdk_path = "/Applications/Adobe Flex Builder 3/sdks/4.0.0b1/".shellescape
  
  if !File.exists? $sdk_path
    puts "Run \"rake vendor\" to download the Flex SDK."
    exit
  end
end

$bin_path = "#{$prefix}/assets/flash"
$src_path = "#{$prefix}/lib/flash"

$index_template = open("#{$src_path}/index.html.erb").read

desc ""
task :vendor do
  sh "curl -O http://fpdownload.adobe.com/pub/flex/sdk/builds/flex4/flex_sdk_4.0.0.6898.zip"
  sh "unzip flex_sdk_4.0.0.6898.zip -d #{$prefix}/vendor/sdk"
  sh "rm flex_sdk_4.0.0.6898.zip"
  
  sh "cd #{$prefix}/vendor && git clone git clone git://github.com/warhammerkid/rocket-amf.git"
  sh "cd #{$prefix}/vendor && git clone git clone git://github.com/deadprogrammer/spork.git"
  
  puts "Please install the following gems:"
  puts "  eventmachine, thin"
end

task :clean_vendor do
  sh "rm -rf #{$prefix}/vendor/*"
end

desc ""
task :clean do
  sh "rm #{$bin_path}/index.html" if File.exists? "#{$bin_path}/index.html"
  sh "rm #{$bin_path}/#{$project_name}.swf" if File.exists? "#{$bin_path}/#{$project_name}.swf"
end

desc ""
task :build do
  erb = ERB.new($index_template).result(binding)
  
  File.open("#{$bin_path}/index.html", "w") { |f| f.puts erb }
  
  sh "#{$mxmlc_path} #{$src_path}/#{$project_name}.as -output #{$bin_path}/#{$project_name}.swf -use-network=true"
end

desc ""
task :run do
  sh "open #{$rack_server}/flash/index.html"
end

desc ""
task :default => [:clean, :build]

namespace :sockpuppet do
  desc ""
  task :run do
    sh "thin start -R config.ru -p#{$rack_server_port}"
  end
end