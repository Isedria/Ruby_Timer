#!/usr/bin/env ruby

require 'abrechnungen'
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
      abrechnungen = Abrechnungen.new


      ## Label
      money_label = Qt::Label.new("0,00 €")
      zeit_label = Qt::Label.new('- - : - - : - -')
      timer_nummer = Qt::Label.new("#{zm_nr}")

      #Buttons
      zeit_anzeige = Qt::Timer.new(self) do
        connect(SIGNAL("timeout()")) do
          zeit_label.text = abrechnungen.dauer_format
          money_label.text = abrechnungen.aktueller_preis
        end
        self.start(200)
      end

      start_button = Qt::PushButton.new('Start') do
        connect(SIGNAL('clicked()')) do
          txt = start_button.text
          puts abrechnungen.send(txt.downcase)

          next_txt = case txt
          when 'Start'  then 'Pause'
          when 'Pause'  then 'Weiter'
          when 'Weiter' then 'Pause'
          end
          
          next_txt = {
            'Start'   => 'Pause',
            'Pause'   => 'Weiter',
            'Weiter'  => 'Pause'
          }[txt]
          start_button.text = next_txt
        end
      end

      ende_button = Qt::PushButton.new('Stop') do
         connect(SIGNAL('clicked()')) do
          txt = ende_button.text
          puts abrechnungen.send(txt.downcase)

          next_txt = case txt
          when 'Stop'  then 'Reset'
          when 'Reset'  then 'Stop'
          end
          ende_button.text = next_txt
        end
      end

      zureuck_button = Qt::PushButton.new('B') do
        connect(SIGNAL('clicked()')) do
        end
      end

      hlayout_extra_buttons = Qt::HBoxLayout.new do
        add_widget(zureuck_button, 0, Qt::AlignCenter)
      end

      zaehl_button = {}
      Abrechnungen::ARTIKEL_ARTEN.each do |artikel_art|
        zaehl_label = Qt::Label.new('0')
        zaehl_button[artikel_art] = Qt::PushButton.new do
          connect(SIGNAL('clicked()')) do
            abrechnungen.benutzer_nimmt(artikel_art)
            zaehl_label.text = abrechnungen.anzahl_genommen(artikel_art).to_s
          end
        end

        hlayout_extra_buttons.add_widget(zaehl_button[artikel_art], 0, Qt::AlignCenter)
        hlayout_extra_buttons.add_widget(zaehl_label, 0, Qt::AlignCenter)
      end

      #icons
      icon = Qt::Icon.new
      icon.addPixmap(Qt::Pixmap.new("icon_coffee.xpm"), Qt::Icon::Normal, Qt::Icon::Off)
      zaehl_button[:kaffee].icon = icon
      icon.addPixmap(Qt::Pixmap.new("icon_coke.xpm"), Qt::Icon::Normal, Qt::Icon::Off)
      zaehl_button[:getraenk].icon = icon
      icon.addPixmap(Qt::Pixmap.new("icon_print.xpm"), Qt::Icon::Normal, Qt::Icon::Off)
      zaehl_button[:kopie].icon = icon


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