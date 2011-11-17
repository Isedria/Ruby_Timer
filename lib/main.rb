#!/usr/bin/env ruby

require 'zeit_messer'

zms = []

33.times do |zm_nr|
  zms[zm_nr] = ZeitMesser.new
end

standard_nr = 1
loop do
  print 'Timer: '
  eingabe_kombi = gets.chomp
  eingabe_befehl, zm_nr = eingabe_kombi.split("", 2)
  zm_nr = (zm_nr=="") ? standard_nr : zm_nr.to_i

  if eingabe_befehl =~ /[sedx]/i
    case eingabe_befehl
    when "s" then puts zms[zm_nr].start
    when "e" then puts zms[zm_nr].ende
    when "d" then puts zms[zm_nr].dauer
    when "x" then break
    end
  else
    puts "Ungültige Eingabe!"
  end
end

