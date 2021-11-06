#!/usr/bin/env ruby
require 'time'

debug = ARGV.delete('-d')

unless debug
    f = File.readlines('input')
else
    f = File.readlines('testinput')
end

# sort input by timestamp
timestamps = f.sort_by{|timestamp| Time.parse(timestamp.split('[')[1].split(']')[0])}

current_guard = 0
minute_fell_asleep = 0
sleep_schedules = Hash.new
timestamps.each { |line|
    day = line.split('-')[2].split(' ')[0].to_i
    minute = line.split(':')[1].split(']')[0].to_i
    puts line
    info = line.split('] ')[1]
    if info.include? "Guard"
        current_guard = info.split('#')[1].split(' ')[0].to_i
    elsif info.include? "falls asleep"
        minute_fell_asleep = minute
        puts "guard #{current_guard} falls asleep at minute #{minute_fell_asleep}"
    elsif info.include? "wakes up"
        puts "guard #{current_guard} wakes up at minute #{minute}"
        unless sleep_schedules.key? current_guard
                sleep_schedules[current_guard] = Hash.new
        end
        for i in minute_fell_asleep..minute do
            unless sleep_schedules[current_guard].key? i
                sleep_schedules[current_guard][i] = 0
            end
            sleep_schedules[current_guard][i] += 1
        end
    end
}
sleepiest_guard = 0
sleepiest_guard_time_sleeping = 0
sleep_schedules.each { |guard_id, minutes_asleep|
    if minutes_asleep.values.sum > sleepiest_guard_time_sleeping
        sleepiest_guard = guard_id
        sleepiest_guard_time_sleeping = minutes_asleep.values.sum
    end
}
sleepiest_minute = sleep_schedules[sleepiest_guard].max_by{ |k, v| v }[0]
puts "-------------------"
puts "sleepiest guard: #{sleepiest_guard} (slept for #{sleepiest_guard_time_sleeping} minutes"
puts "sleepiest minute: #{sleepiest_minute} (#{sleep_schedules[sleepiest_guard][sleepiest_minute]} minutes)"
answer = sleepiest_guard * sleepiest_minute
puts answer
