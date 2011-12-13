# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'zeit_messer'

describe ZeitMesser do
  before(:each) do
    @zm = ZeitMesser.new
  end

  it "sollte Pause mchen können" do
    1.times do
      @zm.start
      @zm.dauer.should == 0
      sleep 1.2
      @zm.dauer.should == 1
      @zm.pause
      sleep 1.1
      @zm.dauer.should == 1
      @zm.weiter
      @zm.dauer.should == 1
      sleep 0.2  # 1.4
      @zm.dauer.should == 1
      sleep 0.2  # 1.6
      @zm.dauer.should == 2
    end
  end
end

describe ZeitMesser do
  before(:each) do
    @zm = ZeitMesser.new
  end

  it "sollte starten" do
    @zm.start.should == "OK"
  end

  it "sollte bei ungestartetem Zeitmesser nicht abstürzen" do
    a = Time.now
    @zm.dauer_format.should be_a String
  end

  it "sollte richtig formatieren" do
    1.times do
      a = Time.now
      @zm.start

      sleep 2
      e = Time.now
      korrekte_dauer = (e - a).to_i
      @zm.dauer_format.should == "00:00:02"
    end
  end

  it "sollte bei kleinen Zeiten korrekte Dauer zurückgeben " do
    @zm.dauer.should == 0
    a = Time.now
    @zm.start

    sleep 0.3
    e = Time.now
    korrekte_dauer = (e - a).round
    @zm.dauer.should == korrekte_dauer
  end

  it "sollte am Anfang Dauer Null haben" do
    @zm.start
    @zm.dauer.should == 0
  end

  it "sollte nach einer Sekunde Dauer 1 haben und beim Reset wieder Null" do
    @zm.start
    sleep 1
    @zm.dauer.should == 1

    @zm.stop
    @zm.reset
    @zm.dauer.should == 0
  end

  it "sollte korrekte Dauer zurückgeben wenn er von Anfang an läuft" do
    1.times do
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
  end

  it "sollte die Dauer nicht weiterzählen, wenn gestoppt" do
    1.times do
      a = Time.now
      @zm.start

      sleep 1.1
      e = Time.now
      zm_dauer = @zm.dauer
      korrekte_dauer = (e - a).to_i
      zm_dauer.should == korrekte_dauer

      @zm.start

      sleep 1.2
      @zm.dauer.should == korrekte_dauer
    end
  end

  it "sollte erst anfangen zu zählen, wenn gestartet" do
    1.times do
      sleep 1.1

      a = Time.now
      @zm.start
      @zm.dauer.should == 0

      sleep 1

      e = Time.now
      korrekte_dauer = (e - a).to_i
      @zm.dauer.should == korrekte_dauer

      @zm.stop
    end
  end

  it "sollte beenden können" do
    @zm.stop.should == "OK"
  end

   it "sollte nach einem Neustart neuzählen" do
    1.times do
      a = Time.now
      @zm.start

      sleep 1.1
      e = Time.now
      korrekte_dauer = (e - a).to_i
      @zm.dauer.should == korrekte_dauer

      @zm.stop

      a2 = Time.now
      @zm.start

      sleep 2.1
      e2 = Time.now
      korrekte_dauer = (e2 - a2).to_i
      @zm.dauer.should == korrekte_dauer
    end
  end
end

