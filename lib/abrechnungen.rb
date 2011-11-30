
require 'zeit_messer'

class Abrechnungen < ZeitMesser
  

  attr_reader :kaffee_anzahl, :getraenke_anzahl, :kopie_anzahl

  ARTIKEL_ARTEN = [:kaffee, :getraenk, :kopie, :coke]

  def initialize
    super
    @anzahlen = {
      :kaffee => 0,
      :kopie => 0,
      :getraenk => 0,
      :coke => 0
    }
    @artikel_preise = {
      :kaffee => 0.50,
      :kopie => 0.15,
      :getraenk => 1.30,
      :coke => 33.30
    }
  end

  def zeit_berechnungen
    if dauer
      ((dauer / 5).round * 0.15)
    else
      0
    end
  end

  def benutzer_nimmt(genommener_artikel)
    @anzahlen[genommener_artikel] += 1
  end

  def anzahl_genommen(genommener_artikel)
    @anzahlen[genommener_artikel]
  end

  def artikel_berechnungen(genommener_artikel)
     @artikel_preise[genommener_artikel] * @anzahlen[genommener_artikel]
  end

  def aktueller_preis
    summe = 0
    @artikel_preise.each do |artikel, preis|
      summe += artikel_berechnungen(artikel)
    end
    zeit_berechnungen  + summe
  end
end
