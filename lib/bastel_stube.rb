#!/usr/bin/env ruby

require 'zeit_messer'
require 'Qt4'


app = Qt::Application.new(ARGV)

begin
  haupt_fenster = Qt::Widget.new do

    self.window_title = 'Timer v1.0'
    resize(200, 100)

    zeilen_anz = 10

    zeit_nummer_layout = Qt::VBoxLayout.new()
    zeit_anzeige_layout = Qt::VBoxLayout.new()
    haupt_buttons_layout = Qt::VBoxLayout.new()
    abrechnungs_anzeige_layout = Qt::VBoxLayout.new()
    extra_buttons_layout = Qt::VBoxLayout.new()

    haupt_layout = Qt::HBoxLayout.new do
      add_layout zeit_nummer_layout
      add_layout zeit_anzeige_layout
      add_layout haupt_buttons_layout
      add_layout abrechnungs_anzeige_layout
      add_layout extra_buttons_layout
    end


    zms = []
    abr = []
    zeilen_anz.times do |zm_nr|
      zms[zm_nr] = ZeitMesser.new
      abr[zm_nr] = Abrechnung.new


      ## Label
      money_label = Qt::Label.new("0,00 €")
      zeit_label = Qt::Label.new('- - : - - : - -')
      timer_nummer = Qt::Label.new("#{zm_nr}")
      kaffee_anzahl = Qt::Label.new('0')
      getraenke_anzahl = Qt::Label.new('0')
      kopie_anzahl = Qt::Label.new('0')


      #Buttons
      zeit_anzeige = Qt::Timer.new(self) do
        connect(SIGNAL("timeout()")) do
          zeit_label.text = zms[zm_nr].dauer_format
          money_label.text = zms[zm_nr].dauer_abrechnung
        end
        self.start(1000)
      end

      start_button = Qt::PushButton.new('Start') do
        connect(SIGNAL('clicked()')) do
         puts zms[zm_nr].start
         puts zeit_anzeige
         start_button.text = 'Pause'
         connect(SIGNAL('clicked()')) do
           start_button.text = 'Start'
         end
        end
      end



      ende_button = Qt::PushButton.new('Ende') do
        connect(SIGNAL('clicked()')) do
          puts zms[zm_nr].ende
        end
      end

      dauer_button = Qt::PushButton.new('Dauer') do
        connect(SIGNAL('clicked()')) do
          zeit_label.text = zms[zm_nr].dauer_format
          puts zms[zm_nr].dauer_format
        end
      end

      zureuck_button = Qt::PushButton.new('B') do
        connect(SIGNAL('clicked()')) do
        end
      end

      kaffee_button = Qt::PushButton.new('C') do
        connect(SIGNAL('clicked()')) do
        end
      end

      getraenke_button = Qt::PushButton.new('G') do
        connect(SIGNAL('clicked()')) do
        end
      end

      kopie_button = Qt::PushButton.new('K') do
        connect(SIGNAL('clicked()')) do
        end
      end





      # Layouts
      
      hlayout_timer_nummer = Qt::HBoxLayout.new do
        add_widget(timer_nummer, 0, Qt::AlignLeft)
      end


      hlayout_timer_show = Qt::HBoxLayout.new do
        add_widget(zeit_label, 0, Qt::AlignCenter)
      end

      hlayout_timer_buttons = Qt::HBoxLayout.new do
        add_widget(start_button, 0, Qt::AlignLeft)
        add_widget(ende_button, 0, Qt::AlignLeft)
        add_widget(dauer_button, 0, Qt::AlignLeft)
      end

      hlayout_money_show = Qt::HBoxLayout.new do
        add_widget(money_label, 0, Qt::AlignCenter)
      end

      hlayout_extra_buttons = Qt::HBoxLayout.new do
        add_widget(zureuck_button, 0, Qt::AlignCenter)
        add_widget(kaffee_button, 0, Qt::AlignCenter)
        add_widget(getraenke_button, 0, Qt::AlignCenter)
        add_widget(kopie_button, 0, Qt::AlignCenter)
        add_widget(kaffee_anzahl, 0, Qt::AlignCenter)
        add_widget(getraenke_anzahl, 0, Qt::AlignCenter)
        add_widget(kopie_anzahl, 0, Qt::AlignCenter)
      end

      zeit_nummer_layout.add_layout(hlayout_timer_nummer)
      zeit_anzeige_layout.add_layout(hlayout_timer_show)
      haupt_buttons_layout.add_layout(hlayout_timer_buttons)
      abrechnungs_anzeige_layout.add_layout(hlayout_money_show)
      extra_buttons_layout.add_layout(hlayout_extra_buttons)
    end

    self.layout = haupt_layout
  end
end

haupt_fenster.show()
app.exec()