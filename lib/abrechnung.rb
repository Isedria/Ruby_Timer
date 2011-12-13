
require 'zeit_messer'

class Abrechnung < ZeitMesser
  

  attr_reader :kaffee_anzahl, :getraenke_anzahl, :kopie_anzahl

  ARTIKEL_ARTEN = [:kaffee, :getraenk, :kopie]

  def initialize(master_abrechnung = nil)
    if master_abrechnung.nil?
      puts "Wo ist mein Meister!!"
    end

    @master = master_abrechnung

    super()
    @anzahlen = {
      :kaffee => 0,
      :kopie => 0,
      :getraenk => 0,
    }
    @artikel_preise = {
      :kaffee => 0.50,
      :kopie => 0.15,
      :getraenk => 1.30,
    }
    @alter_internet_preis = 0
  end

  def alter_internet_preis= alter_wert
    @alter_internet_preis = alter_wert
  end

  def alter_internet_preis
    @alter_internet_preis
  end
  
  private
  def fuege_aktuelle_daten_zum_master_hinzu
    return if @master.nil?
    ARTIKEL_ARTEN.each do |art|
      anzahl_genommen(art).times{ @master.benutzer_nimmt(art) }
    end
    @master.alter_internet_preis += zeit_berechnungen
  end

  
  public
  def reset
    fuege_aktuelle_daten_zum_master_hinzu if @master
    super
    @anzahlen = {
      :kaffee => 0,
      :kopie => 0,
      :getraenk => 0,
    }

    "Reset OK"
  end

  def zeit_berechnungen
    ((dauer / 5).round * 0.15)
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

  def internet_preis
    ((@alter_internet_preis + zeit_berechnungen)*100).round / 100.0
  end

  def getraenke_preis
    artikel_berechnungen(:kaffee) + artikel_berechnungen(:getraenk)
  end

  def kopien_preis
    artikel_berechnungen(:kopie)
  end

end
