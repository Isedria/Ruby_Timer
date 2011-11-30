#!/usr/bin/env ruby

require 'zeit_messer'

abr = []

10.times do |zm_nr|
  abr[zm_nr] = ZeitMesserMitAbrechnung.new
end


standard_nr = 1
loop do    #Hauptschleife
  begin
    print 'Timer: '
    eingabe_kombi = gets.chomp
    eingabe_befehl, zm_nr = eingabe_kombi.split("", 2)
    zm_nr = (zm_nr=="") ? standard_nr : zm_nr.to_i

    if eingabe_befehl =~ /[sedpwxi]/i
      case eingabe_befehl
      when "s" then puts abr[zm_nr].start
      when "e" then puts abr[zm_nr].stop
      when "d" then puts abr[zm_nr].dauer_format
      when "p" then puts abr[zm_nr].pause
      when "w" then puts abr[zm_nr].weiter
      when "i" then 
        10.times {|zeilen_nummer|
          print zeilen_nummer.to_s.center(2)
          print "|".center(5)
          print abr[zeilen_nummer].dauer_format.to_s.center(10)
          print "|".center(5)
          if abr[zeilen_nummer].dauer_format.nil?
            print "Nicht Aktiv"
          else
            print "   Aktiv   "
          end
          puts
        }
      when "x" then break
      end
    else
      puts "Ungültige Eingabe!"
    end
  rescue
    puts "Es ist ein Fehler aufgetreten in der Hauptschleife."
    print "Wollen Sie die Fehlermeldung sehen?  "
    if gets =~ /y|j/
      puts "Meldung"
      puts $!
      puts $!.backtrace
    end
  end
end