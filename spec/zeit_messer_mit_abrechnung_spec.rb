# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'zeit_messer_mit_abrechnung'

describe ZeitMesserMitAbrechnung do
  before(:each) do
    @ab = ZeitMesserMitAbrechnung.new
  end

  it "sollte richtig abrechnen" do
    @ab.start
    @ab.stub!(:dauer).and_return(12)
    @ab.dauer_abrechnung.should == "0.30 €"
  end

  it "sollte klicker richtig berechnen" do

    @ab.dauer_abrechnung.should == "0,00 €"
  end

  it "sollte kaffee addieren" do
    @ab.kaffee_anzahl.should == 0
    @ab.neuer_kaffee
    @ab.kaffee_anzahl.should == 1
    @ab.start
    sleep 1
    @ab.kaffee_anzahl.should == 1
    @ab.stop
    @ab.neuer_kaffee
    @ab.kaffee_anzahl.should == 2
  end

  it "sollte immer noch formatiert ausgeben können" do
      @ab.start
      sleep 2
      @ab.dauer_format.should == "00:00:02"
  end
end


