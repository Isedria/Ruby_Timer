# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'zeit_messer'

describe ZeitMesser do
  before(:each) do
    @zm = ZeitMesser.new
  end

  it "sollte starten" do
    @zm.start.should == "OK"
  end

  it "sollte bei kleinen Zeiten korrekte Dauer zurückgeben " do
    a = Time.now
    @zm.start

    sleep 0.3
    e = Time.now
    korrekte_dauer = (e - a).round
    @zm.dauer.should == korrekte_dauer
  end

  it "sollte Info ausgeben" do
    @zm.info.should be_a String
  end

  it "sollte am Anfang Dauer Null haben" do
    @zm.start
    @zm.dauer.should == 0
  end

  it "sollte nach einer Sekunde Dauer 1 haben" do
    @zm.start
    sleep 1
    @zm.dauer.should == 1
  end

  it "sollte korrekte Dauer zurückgeben wenn er von Anfang an läuft" do
    a = Time.now
    @zm.start

    sleep 1.3
    e = Time.now
    zm_dauer = @zm.dauer
    korrekte_dauer = (e - a).to_i
    zm_dauer.should == korrekte_dauer

    sleep 1.7
    e = Time.now
    zm_dauer = @zm.dauer
    korrekte_dauer = (e - a).to_i
    zm_dauer.should == korrekte_dauer

    zm_dauer.should == 3
  end
  
  it "sollte die Dauer nicht weiterzählen, wenn gestoppt" do
    a = Time.now
    @zm.start

    sleep 1.1
    e = Time.now
    zm_dauer = @zm.dauer
    korrekte_dauer = (e - a).to_i
    zm_dauer.should == korrekte_dauer
    
    @zm.ende
    
    sleep 1.2
    @zm.dauer.should == korrekte_dauer
  end  

  it "sollte erst anfangen zu zählen, wenn gestartet" do
    sleep 1.1

    a = Time.now
    @zm.start
    @zm.dauer.should == 0
    
    sleep 1

    e = Time.now
    korrekte_dauer = (e - a).to_i
    @zm.dauer.should == korrekte_dauer
    
    @zm.ende    
       
  end  

  it "sollte beenden können" do
    @zm.ende.should == "OK"
  end

  
end

