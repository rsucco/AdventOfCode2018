#!/usr/bin/env ruby

debug = ARGV.delete('-d')

unless debug
    f = File.readlines('input')
else
    f = File.readlines('testinput')
end

num_repeats_twice = 0
num_repeats_thrice = 0
f.each { |box_id|
    repeats_twice = false
    repeats_thrice = false
    box_id.chars.uniq.each { |char|
        if box_id.count(char) == 2
            repeats_twice = true
        elsif box_id.count(char) == 3
            repeats_thrice = true
        end
    }
    if repeats_twice
        num_repeats_twice += 1
    end
    if repeats_thrice
        num_repeats_thrice += 1
    end
}
puts "total double repeats #{num_repeats_twice}"
puts "total triple repeats #{num_repeats_thrice}"
checksum = num_repeats_twice * num_repeats_thrice
puts "checksum #{checksum}"