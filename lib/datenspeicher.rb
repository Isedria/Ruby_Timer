require 'abrechnung'


class Datenspeicher
  STATISTIK_VOLLER_DATEINAME = "/hpbeta/aaa/111/RubySim/Ruby_Timer/lib/daten.txt"

  def initialize
    @date_format = Time.now.utc.strftime("%Y%m%d")

  end

  def datei_erstellen
    File.open(Datenspeicher::STATISTIK_VOLLER_DATEINAME, "a+")
  end

  def statistik_eingabe
    if File.exist?(Datenspeicher::STATISTIK_VOLLER_DATEINAME)
      IO.foreach(Datenspeicher::STATISTIK_VOLLER_DATEINAME) { |line| puts line }
    end
  end


  def statistik_eingabe_internetincome_old
    timer_line = IO.readlines(Datenspeicher::STATISTIK_VOLLER_DATEINAME)
    timer_line[00..5]
    case timer_line[00..5]
    when timer_line[1] then timer_line[1]
    end
  end

  def statistik_eingabe_drinksincome_old
    timer_line = IO.readlines(Datenspeicher::STATISTIK_VOLLER_DATEINAME)
    timer_line[00..5]
    case timer_line[00..5]
    when timer_line[3] then timer_line[3] = drinksincome_old.chomp(@date_format) ## SLICE?
    end
  end

  def statistik_eingabe_printincome_old
    timer_line = IO.readlines(Datenspeicher::STATISTIK_VOLLER_DATEINAME)
    timer_line[00..5]
    case timer_line[00..5]
    when timer_line[5] then timer_line[5] = printincome_old.chomp(@date_format)
    end
  end

  def statistik_ausgabe(abrechnungen_bzw_abr_array)
    abrechnungen_array = case abrechnungen_bzw_abr_array
    when Array then
      abrechnungen_bzw_abr_array
    when Abrechnung then
      [abrechnungen_bzw_abr_array]
    else
      raise "Falscher Parameter (#{abrechnungen_bzw_abr_array.inspect})"
    end
    i = g = k = 0
    abrechnungen_array.each do |abrechnung|
      i += (statistik_eingabe_internetincome_old + abrechnung.internet_preis)
      g += (statistik_eingabe_drinksincome_old + abrechnung.getraenke_preis)
      k += (statistik_eingabe_printincome_old + abrechnung.kopien_preis)
    end

    File.open(Datenspeicher::STATISTIK_VOLLER_DATEINAME, "w") do |file|
      file.puts "[internetincome]"
      file.puts "#{@date_format}=#{'%05.2f' % i}"
      file.puts "[drinksincome]"
      file.puts "#{@date_format}=#{'%05.2f' % g}"
      file.puts "[printincome]"
      file.puts "#{@date_format}=#{'%05.2f' % k}"
    end
  end
end
