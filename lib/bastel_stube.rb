#!/usr/bin/env ruby

require 'zeit_messer_mit_abrechnung'
require 'Qt4'


app = Qt::Application.new(ARGV)

begin
  haupt_fenster = Qt::Widget.new do

    self.window_title = 'Timer v1.0'
    resize(200, 100)

    zeilen_anz = 10
    
    extra_buttons_layout = Qt::VBoxLayout.new()

    haupt_layout = Qt::VBoxLayout.new do
      add_layout extra_buttons_layout
    end

    abr = []
    zeilen_anz.times do |zm_nr|
      abr[zm_nr] = ZeitMesserMitAbrechnung.new


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
          zeit_label.text = abr[zm_nr].dauer_format
          money_label.text = abr[zm_nr].dauer_abrechnung
        end
        self.start(200)
      end

      start_button = Qt::PushButton.new('Start') do
        connect(SIGNAL('clicked()')) do
          txt = start_button.text
          puts abr[zm_nr].send(txt.downcase)

          next_txt = case txt
          when 'Start'  then 'Pause'
          when 'Pause'  then 'Weiter'
          when 'Weiter' then 'Pause'
          end
          start_button.text = next_txt
        end
      end

      ende_button = Qt::PushButton.new('Stop') do
         connect(SIGNAL('clicked()')) do
          txt = start_button.text
          puts abr[zm_nr].send(txt.downcase)

          next_txt = case txt
          when 'Stop'  then 'Reset'
          when 'Reset'  then 'Stop'
          end
          start_button.text = next_txt
        end
      end

      zureuck_button = Qt::PushButton.new('B') do
        connect(SIGNAL('clicked()')) do
        end
      end

      kaffee_button = Qt::PushButton.new do
        connect(SIGNAL('clicked()')) do
          puts abr[zm_nr].kaffee_anzahl.to_s
          abr[zm_nr].neuer_kaffee
          kaffee_anzahl.text = abr[zm_nr].kaffee_anzahl.to_s
        end
      end

      getraenke_button = Qt::PushButton.new do
        connect(SIGNAL('clicked()')) do
          puts abr[zm_nr].getraenke_anzahl.to_s
          abr[zm_nr].neues_getraenk
          getraenke_anzahl.text = abr[zm_nr].getraenke_anzahl.to_s
        end
      end

      kopie_button = Qt::PushButton.new do
        connect(SIGNAL('clicked()')) do
          puts abr[zm_nr].kopie_anzahl.to_s
          abr[zm_nr].neue_kopie
          kopie_anzahl.text = abr[zm_nr].kopie_anzahl.to_s
        end
      end

      #icons
      icon = Qt::Icon.new
      icon.addPixmap(Qt::Pixmap.new("icon_coffee.xpm"), Qt::Icon::Normal, Qt::Icon::Off)
      kaffee_button.icon = icon
      icon.addPixmap(Qt::Pixmap.new("icon_coke.xpm"), Qt::Icon::Normal, Qt::Icon::Off)
      getraenke_button.icon = icon
      icon.addPixmap(Qt::Pixmap.new("icon_print.xpm"), Qt::Icon::Normal, Qt::Icon::Off)
      kopie_button.icon = icon


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
      end

      hlayout_money_show = Qt::HBoxLayout.new do
        add_widget(money_label, 0, Qt::AlignCenter)
      end

      hlayout_extra_buttons = Qt::HBoxLayout.new do
        add_widget(zureuck_button, 0, Qt::AlignCenter)
        add_widget(kaffee_button, 0, Qt::AlignCenter)
        add_widget(kaffee_anzahl, 0, Qt::AlignCenter)
        add_widget(getraenke_button, 0, Qt::AlignCenter)
        add_widget(getraenke_anzahl, 0, Qt::AlignCenter)
        add_widget(kopie_button, 0, Qt::AlignCenter)    
        add_widget(kopie_anzahl, 0, Qt::AlignCenter)
      end

      vlayout_second = Qt::HBoxLayout.new do
        add_layout(hlayout_timer_nummer)
        add_layout(hlayout_timer_show)
        add_layout(hlayout_timer_buttons)
        add_layout(hlayout_money_show)
        add_layout(hlayout_extra_buttons)
      end

      extra_buttons_layout.add_layout(vlayout_second)
    end

    self.layout = haupt_layout
  end
end

haupt_fenster.show()
app.exec()