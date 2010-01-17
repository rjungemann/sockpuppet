require 'pathname'
require 'pp'

$prefix = Pathname.new(".").realpath.to_s

require 'rubygems'
require 'eventmachine'
require "#{$prefix}/lib/sockpuppet"
require "#{$prefix}/vendor/spork/lib/spork"
require "#{$prefix}/vendor/rocket-amf/lib/rocketamf"
require "#{$prefix}/lib/apps/sockpuppet_socket"

Spork.spork(:log => @log) do
  puts "Sockpuppet starting."
  EventMachine::run do
    EventMachine::start_server $sockpuppet_server, $sockpuppet_port, SockpuppetSocket
  end
end

run Rack::URLMap.new("/" => Rack::File.new("assets"))