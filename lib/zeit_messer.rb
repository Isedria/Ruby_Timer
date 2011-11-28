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

  def pause
    @ende_zeit = Time.now
  end

  def weiter
    @start_zeit = Time.now - dauer
    @ende_zeit = nil
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
end

class ZeitMesserMitAbrechnung < ZeitMesser
  def dauer_ZeitMesserMitAbrechnung
    if dauer
      "%.2f €" % ((dauer / 5).round * 0.15)
    else
      "0,00 €"
    end
  end

  def kaffee_anzahl_berechnung
  end


end
