#!/usr/bin/env ruby

require 'zeit_messer'

zms = []

3.times do |zm_nr|
  zms[zm_nr] = ZeitMesser.new
end

zm_nr = 0
loop do
  print 'Timer: '
  eingabe_befehl = gets.chomp

  if eingabe_befehl =~ /s|e|d|x|t/i
    if eingabe_befehl == "t"
      print "Timer - Nummer :"
      zm_nr = gets.to_i
    end

  
    case eingabe_befehl
    when "s" then puts zms[zm_nr].start
    when "e" then puts zms[zm_nr].ende
    when "d" then puts zms[zm_nr].dauer
    end

    break if eingabe_befehl == "x"
  end
end

