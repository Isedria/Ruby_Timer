
require 'datenspeicher'
require 'abrechnung'

describe Datenspeicher do
  describe "mit Datei" do
    before(:each) do
      @ds = Datenspeicher.new
      @ab = Abrechnung.new
      @ds.datei_erstellen
      File.exist?("daten.txt").should be_true
    end

  end

  describe "ohne Datei" do
    before(:each) do
      @ds = Datenspeicher.new
      @ab = Abrechnung.new
      File.delete("daten.txt") if File.exist?("daten.txt")
    end

    it "sollte die richtigen Werte hinein schreiben" do
      @ab.start
      @ab.stub!(:dauer).and_return(12)
      @ab.zeit_berechnungen.should == 0.30
      @ab.aktueller_preis == 0.30
      @ab.anzahl_genommen(:kaffee).should == 0
      @ab.benutzer_nimmt(:kaffee)
      @ab.anzahl_genommen(:kaffee).should == 1
      @ab.aktueller_preis.should == 0.80
#      aktueller_internet_preis = @ab.internet_preis
#      aktueller_getraenke_preis = @ab.getraenke_preis
#      aktueller_kopien_preis = @ab.kopien_preis
  #    unsere_mock_datei = mock("Mock_Datei")
  #    unsere_mock_datei.should_receive(:print).with("00.80")
  #    unsere_mock_datei.should_receive(:puts)
  #    @ds.statistik_ausgabe(aktueller_preis)

  #    unsere_mock_datei = StringIO.new
  #    File.should_receive(:open).and_yield(unsere_mock_datei)
  #    @ds.statistik_ausgabe(aktueller_preis)
  #    unsere_mock_datei.string.chomp.should == "00.80"
      @ds.statistik_ausgabe(@ab)
      File.read("daten.txt").should == <<TextEnde
[internetincome]
00.30
[drinksincome]
00.50
[printincome]
00.00
TextEnde

      @ds.statistik_ausgabe([@ab, @ab])
      File.read("daten.txt").should == <<TextEnde
[internetincome]
00.60
[drinksincome]
01.00
[printincome]
00.00
TextEnde

    end
  end
end

