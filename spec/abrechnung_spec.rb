# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'abrechnung'

describe Abrechnung do
  describe "ohne Master" do
    before(:each) do
      @ab = Abrechnung.new
    end

    it "sollte richtig abrechnen" do
      @ab.start
      @ab.stub!(:dauer).and_return(12)
      @ab.zeit_berechnungen.should == 0.30
    end

    it "sollte klicker richtig berechnen" do

      @ab.zeit_berechnungen.should == 0.00
    end

    it "sollte kaffee addieren" do
      @ab.anzahl_genommen(:kaffee).should == 0
      @ab.benutzer_nimmt(:kaffee)
      @ab.anzahl_genommen(:kaffee).should == 1
      @ab.start
      sleep 1
      @ab.anzahl_genommen(:kaffee).should == 1
      @ab.stop
      @ab.benutzer_nimmt(:kaffee)
      @ab.anzahl_genommen(:kaffee).should == 2
    end

    it "sollte kaffee abrechnen" do
      @ab.anzahl_genommen(:kaffee).should == 0
      @ab.benutzer_nimmt(:kaffee)
      @ab.anzahl_genommen(:kaffee).should == 1
      @ab.artikel_berechnungen(:kaffee).should == 0.50
      @ab.benutzer_nimmt(:kaffee)
      @ab.artikel_berechnungen(:kaffee).should == 1.0
      @ab.anzahl_genommen(:kaffee).should == 2

    end

    it "sollte kopien richtig ausrechnen" do
      @ab.kopien_preis.should == 0.0
      @ab.benutzer_nimmt(:kopie)
      @ab.kopien_preis.should == 0.15
    end

    it "sollte kaffee & Zeit abrechnen" do
      @ab.start
      @ab.stub!(:dauer).and_return(6)
      @ab.stop
      @ab.anzahl_genommen(:kaffee).should == 0
      @ab.benutzer_nimmt(:kaffee)
      @ab.anzahl_genommen(:kaffee).should == 1
      @ab.artikel_berechnungen(:kaffee).should == 0.50
      @ab.benutzer_nimmt(:kaffee)
      @ab.artikel_berechnungen(:kaffee).should == 1.00
      @ab.anzahl_genommen(:kaffee).should == 2
      @ab.zeit_berechnungen == 0.15
      @ab.aktueller_preis == 1.15

    end

    it "sollte immer noch formatiert ausgeben können" do
      @ab.start
      sleep 2
      @ab.dauer_format.should == "00:00:02"
    end
  end

  describe "mit Master" do
    before(:each) do
      @master_ab = Abrechnung.new
      @ab = Abrechnung.new(@master_ab)
    end

    it "sollte bei Reset alle Werte zum Master hinzufügen" do
      @master_ab.anzahl_genommen(:kopie).should == 0
      @master_ab.aktueller_preis.should == 0
      @master_ab.dauer.should == 0

      @ab.start
      sleep 1
      4.times {@ab.benutzer_nimmt(:kaffee)}
      @ab.anzahl_genommen(:kaffee).should == 4
      2.times {@ab.benutzer_nimmt(:getraenk)}
      42.times {@ab.benutzer_nimmt(:kopie)}

      @ab.anzahl_genommen(:kopie).should == 42
      @ab.aktueller_preis.should == 10.90
      @ab.dauer.should == 1

      @ab.stop
      @ab.anzahl_genommen(:kopie).should == 42
      @ab.aktueller_preis.should == 10.90
      @ab.dauer.should == 1

      @ab.reset
      @ab.anzahl_genommen(:kopie).should == 0
      @ab.aktueller_preis.should == 0
      @ab.dauer.should == 0

      @master_ab.anzahl_genommen(:kopie).should == 42
      @master_ab.aktueller_preis.should == 10.90
      @master_ab.dauer.should == 1
    end

  end
end


