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
    Time.at((@ende_zeit || Time.now) - @start_zeit).utc.strftime(@timer_format)
  end

  def info
    "OK"
  end
end

