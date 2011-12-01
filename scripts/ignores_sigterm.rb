#!/usr/bin/env ruby

Signal.trap("SIGTERM") do
  puts "Meh, sigterms, I don't care"
end

Signal.trap("SIGKILL") do
  puts "sigkill, whatever. I can stand anything. Or wait..."
end

loop do
  sleep 1
  puts "I am going to run forever!"
end
