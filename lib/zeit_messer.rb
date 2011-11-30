#!/usr/bin/env ruby



class ZeitMesser

  def initialize
    @timer_format = "%H:%M:%S"
  end

  attr_reader :zustand
  # nil, :gestartet, :pause, :gestoppt

  def start
    @start_zeit = Time.now
    @ende_zeit = nil
    @zustand = :gestartet
    "OK"
  end

  def stop
    @ende_zeit = Time.now
    @zustand = :gestoppt
    "OK"
  end

  def pause
    @ende_zeit = Time.now
    @zustand = :pause
  end

  def weiter
    @start_zeit = Time.now - dauer_ungerundet
    @ende_zeit = nil
    @zustand = :gestartet
  end

  def reset
    @start_zeit = nil
    @ende_zeit = nil
    @zustand = nil
  end

  private
  def dauer_ungerundet
    ((@ende_zeit || Time.now) - @start_zeit)
  end

  public

  def dauer
    begin
      dauer_ungerundet.round
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

