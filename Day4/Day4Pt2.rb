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
consistent_sleepy_guard = 0
consistent_sleepy_minute = 0
consistent_sleepy_minutes_asleep = 0
sleep_schedules.each { |guard_id, minutes_asleep|
    minutes_asleep.each { |minute, time_asleep|
        if time_asleep > consistent_sleepy_minutes_asleep
            consistent_sleepy_minutes_asleep = time_asleep
            consistent_sleepy_guard = guard_id
            consistent_sleepy_minute = minute
        end
    }
}
puts "-------------------"
puts "most consistent sleepy guard: #{consistent_sleepy_guard}"
puts "sleepiest minute: #{consistent_sleepy_minute} (#{sleep_schedules[consistent_sleepy_guard][consistent_sleepy_minute]} minutes)"
answer = consistent_sleepy_guard * consistent_sleepy_minute
puts answer
