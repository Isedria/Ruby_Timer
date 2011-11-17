#!/usr/bin/env ruby

require 'zeit_messer'

zms = []

3.times do |zm_nr|
  zms[zm_nr] = ZeitMesser.new
end

loop do
  print 'Timer: '
  eingabe_befehl = gets.chomp

  if eingabe_befehl =~ /s|e|d|x|t/i
    if eingabe_befehl == "t"
      print "Timer - Nummer :"
      eingabe_multi = gets.chomp
    end

    zm_nr = eingabe_multi.to_i
  
    case eingabe_befehl
    when "s" then puts zms[zm_nr].start
    when "e" then puts zms[zm_nr].ende
    when "d" then puts zms[zm_nr].dauer
    end

    break if eingabe_befehl == "x"
  end
end

