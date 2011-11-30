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

