#!/usr/bin/env ruby

require 'zeit_messer'

#puts"Timer"
#print 'Um den Timer zu starten, tippen Sie "s" ein: '
#
#eingabe = gets.chomp
zm = ZeitMesser.new

loop do
  print 'Timer: '
  eingabe = gets.chomp
  if eingabe =~ /s|e|d|x/i
      case eingabe
      when "s" then puts zm.start
      when "e" then puts zm.ende
      when "d" then puts zm.dauer
      end
  end
  break if eingabe == "x"
end

#
#
#
#if eingabe == "s"
#  puts zm.start
#else
#  puts "falsche Eingabe!"
#end
#
#print 'Um den Timer zu starten, tippen Sie "e" ein: '
#
#eingabe = gets.chomp
#if eingabe == "e"
#  puts zm.ende
#else
#  puts "falsche Eingabe!"
#end
#
#print 'Um den Timer zu starten, tippen Sie "d" ein: '
#
#eingabe = gets.chomp
#if eingabe == "d"
#  puts zm.dauer
#else
#  puts "falsche Eingabe!"
#end


