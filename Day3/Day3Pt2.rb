#!/usr/bin/env ruby

debug = ARGV.delete('-d')

unless debug
    f = File.readlines('input')
else
    f = File.readlines('testinput')
end

# initialize grid
grid = Array.new(1000){Array.new(1000, 0)}

intact_claims = []
f.each { |claim|
    # parse the claim string to figure out which squares it covers
    claim_id = claim.split('#')[1].split(' @')[0].to_i
    intact_claims << claim_id
    x = claim.split('@ ')[1].split(',')[0].to_i
    y = claim.split(',')[1].split(':')[0].to_i
    width = claim.split(': ')[1].split('x')[0].to_i
    height = claim.split('x')[1].to_i
    for i in x..x + width - 1 do
        for j in y..y + height - 1 do
            # mark the squares as occupied if it's empty
            if grid[i][j] == 0
                grid[i][j] = claim_id
            # mark the square as crowded if it's occupied and delete both claims from the array of intact claims
            else
                intact_claims.delete(grid[i][j])
                intact_claims.delete(claim_id)
                grid[i][j] = -1
            end
        end
    end
}
puts intact_claims