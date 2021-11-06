#!/usr/bin/env ruby

debug = ARGV.delete('-d')

unless debug
    f = File.readlines('input')
else
    f = File.readlines('testinput')
end

nums = f.map(&:to_i)
puts nums.sum()