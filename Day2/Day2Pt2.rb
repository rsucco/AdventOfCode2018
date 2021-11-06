#!/usr/bin/env ruby

debug = ARGV.delete('-d')

unless debug
    f = File.readlines('input')
else
    f = File.readlines('testinput')
end

matching_chars = ''
f.each { |box_id|
    for i in 0..box_id.length
        # Create a regex with a '.' at each possible position in the string
        check_regex_str = box_id.dup
        check_regex_str[i] = '.'
        check_regex = Regexp.new(check_regex_str)
        matched = false
        f.each { |other_box_id|
            # If the regex matches any other values in the list besides the string from which it was derived, that's what we need
            if other_box_id != box_id && check_regex =~ other_box_id
                puts "matched regex #{check_regex_str} from box_id #{box_id} to other_box_id #{other_box_id}"
                matched = true
            end
        }
        if matched
            puts ''
            puts 'result:'
            puts check_regex_str.gsub('.', '')
            exit 0
        end
    end
}
