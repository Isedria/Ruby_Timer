#!/usr/bin/env ruby



class ZeitMesser

  def initialize
  end

  def start
    @start_zeit = Time.now
    "OK"
  end

  def ende
    @ende_zeit = Time.now
    "OK"
  end

  def dauer
    if @ende_zeit
       ((@ende_zeit - @start_zeit)).round
    else
       (Time.now - @start_zeit).round
    end
  end

  def info
    "OK"
  end
end

