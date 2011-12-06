require 'abrechnungen'


class Datenspeicher

  def datei_erstellen
    File.open("daten.txt", "w"){}
  end

  def statistik_ausgabe(aktueller_preis)
    File.open("daten.txt", "w") do |file|
      file.puts "#{'%05.2f' % aktueller_preis}"
    end
  end
end
