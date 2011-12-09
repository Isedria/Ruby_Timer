require 'abrechnung'


class Datenspeicher

  def datei_erstellen
    File.open("daten.txt", "w"){}
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
      i += abrechnung.internet_preis
      g += abrechnung.getraenke_preis
      k += abrechnung.kopien_preis
    end
    File.open("daten.txt", "w") do |file|
      file.puts "[internetincome]"
      file.puts "#{'%05.2f' % i}"
      file.puts "[drinksincome]"
      file.puts "#{'%05.2f' % g}"
      file.puts "[printincome]"
      file.puts "#{'%05.2f' % k}"
    end
  end
end
