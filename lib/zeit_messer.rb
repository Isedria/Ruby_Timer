#!/usr/bin/env ruby



class ZeitMesser

  def initialize
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
    ((@ende_zeit || Time.now) - @start_zeit).round
  end
  def info
    "OK"
  end
end

