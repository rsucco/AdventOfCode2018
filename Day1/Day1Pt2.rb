#!/usr/bin/env ruby

debug = ARGV.delete('-d')

unless debug
    f = File.readlines('input')
else
    f = File.readlines('testinput')
end

nums = f.map(&:to_i)
seen_before = []
current_freq = 0
keep_going = true
while keep_going
    nums.each { |num|
        current_freq += num
        puts "current freq #{current_freq}"
        if seen_before.include? current_freq
            puts "seen before #{current_freq}"
            keep_going = false
            break
        end
        seen_before << current_freq
    }
end
puts current_freq