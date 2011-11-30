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

  def stop
    @ende_zeit = Time.now
    "OK"
  end

  def pause
    @ende_zeit = Time.now
  end

  private
  def dauer_ungerundet
    ((@ende_zeit || Time.now) - @start_zeit)
  end

  public
  def weiter
    @start_zeit = Time.now - dauer_ungerundet
    @ende_zeit = nil
  end

  def dauer
    begin
      dauer_ungerundet.round
    rescue
      nil
    end
  end


  def reset
    @start_zeit = nil
    @ende_zeit = nil
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
  attr_reader :kaffee_anzahl
  
  def initialize
    @kaffee_anzahl = 0
  end
  
  def dauer_abrechnung
    if dauer
      "%.2f €" % ((dauer / 5).round * 0.15)
    else
      "0,00 €"
    end
  end

  def neuer_kaffee
    @kaffee_anzahl += 1
  end

end
