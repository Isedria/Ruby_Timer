#!/usr/bin/env ruby



class ZeitMesser

  def initialize
    @timer_format = "%H:%M:%S"
  end

  def start
    @start_zeit = Time.now
    @ende_zeit = nil
    "OK"
  end

  def ende
    @ende_zeit = Time.now
    "OK"
  end

  def dauer
    begin
      ((@ende_zeit || Time.now) - @start_zeit).round
    rescue
      nil
    end
  end

  def dauer_format
    if dauer
      Time.at(dauer).utc.strftime(@timer_format)
    else
      "- - : - - : - -"
    end
  end

  def dauer_abrechnung # Zweistellige Gleitkommazahl sowie unter 15 Minuten sofort einmalige Abrechnung fehlen! "%.f2"
    if dauer
      ((dauer / 5).round * 0.15).to_s + " €"
    else
      "0,00 €"
    end
  end

  def pause
    
  end
end

class Abrechnung < ZeitMesser
#  def dauer_abrechnung
#    if dauer
#      ((dauer / 5).round * 0.15)
#    else
#      "0,test"
#    end
#  end
end
