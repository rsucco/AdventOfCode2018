#!/usr/bin/env ruby

debug = ARGV.delete('-d')

unless debug
    f = File.readlines('input')
else
    f = File.readlines('testinput')
end

# initialize grid
grid = Array.new(1000){Array.new(1000, 0)}

f.each { |claim|
    # parse the claim string to figure out which squares it covers
    x = claim.split('@ ')[1].split(',')[0].to_i
    y = claim.split(',')[1].split(':')[0].to_i
    width = claim.split(': ')[1].split('x')[0].to_i
    height = claim.split('x')[1].to_i
    # mark the squares as occupied
    for i in x..x + width - 1 do
        for j in y..y + height - 1 do
            grid[i][j] += 1
        end
    end
}

# get the number of squares with two or more occupied
two_or_more = 0
for row in grid do
    for val in row do
        if val >= 2
            two_or_more += 1
        end
    end
end
puts two_or_more