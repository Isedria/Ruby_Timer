#!/usr/bin/env ruby

require 'abrechnung'
require 'datenspeicher'
require 'Qt4'


app = Qt::Application.new(ARGV)

begin
  haupt_fenster = Qt::Widget.new do

    self.window_title = 'Timer v1.0'
    resize(500, 100)
    zeilen_anz = 10
    
    extra_buttons_layout = Qt::VBoxLayout.new()

    haupt_layout = Qt::VBoxLayout.new do
      add_layout extra_buttons_layout
    end
    master_abrechnung = Abrechnung.new
    zeilen_anz.times do |zm_nr|
      abrechnung = Abrechnung.new(master_abrechnung)
      datenspeicherung = Datenspeicher.new


      ## Label
      money_label = Qt::Label.new("0,00 €")
      zeit_label = Qt::Label.new('- - : - - : - -')
      zeit_label.resize 30,20
      timer_nummer = Qt::Label.new("#{zm_nr}")

      #Buttons
      zeit_anzeige = Qt::Timer.new(self) do
        connect(SIGNAL("timeout()")) do
          zeit_label.text = abrechnung.dauer_format
          money_label.text = "%7.2f €" % abrechnung.aktueller_preis
        end
        self.start(200)
      end

      start_button = Qt::PushButton.new('Start') do
        connect(SIGNAL('clicked()')) do
          txt = start_button.text
          puts abrechnung.send(txt.downcase)

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
          puts abrechnung.send(txt.downcase)

          next_txt = case txt
          when 'Stop'  then 'Reset'
          when 'Reset'  then
            datenspeicherung.statistik_ausgabe(master_abrechnung)
            "Stop"
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

      #icons
      icon = Qt::Icon.new
      Abrechnung::ARTIKEL_ARTEN.each do |artikel_art|
        zaehl_label = Qt::Label.new('0')
        zaehl_button = Qt::PushButton.new do
          connect(SIGNAL('clicked()')) do
            abrechnung.benutzer_nimmt(artikel_art)
            zaehl_label.text = abrechnung.anzahl_genommen(artikel_art).to_s
          end
        end
        icon_dateiname = {
          :kaffee   => "icon_coffee.xpm",
          :getraenk => "coke.xpm",
          :kopie    => "icon_print.xpm"
        }[artikel_art]
        if icon_dateiname
          icon.addPixmap(Qt::Pixmap.new("icons/"+icon_dateiname), Qt::Icon::Normal, Qt::Icon::Off)
        end
        zaehl_button.icon = icon

        hlayout_extra_buttons.add_widget(zaehl_button, 0, Qt::AlignCenter)
        hlayout_extra_buttons.add_widget(zaehl_label, 0, Qt::AlignCenter)
      end

      # Layouts

      hlayout_timer_nummer = Qt::HBoxLayout.new do
        setContentsMargins(10, 0, 5, 0)
        add_widget(timer_nummer, 0, Qt::AlignCenter)
      end

      hlayout_timer_show = Qt::HBoxLayout.new do
        setContentsMargins(10, 0, 10, 0)
        add_widget(zeit_label, 0, Qt::AlignCenter)
      end

      hlayout_timer_buttons = Qt::HBoxLayout.new do
        setContentsMargins(10, 0, 10, 0)
        add_widget(start_button, 0, Qt::AlignCenter)
        add_widget(ende_button, 0, Qt::AlignCenter)
      end

      hlayout_money_show = Qt::HBoxLayout.new do
        setContentsMargins(10, 0, 10, 0)
        addStretch(0)
        add_widget(money_label, 0, Qt::AlignRight)
      end

      vlayout_second = Qt::HBoxLayout.new do
        setContentsMargins(10, 0, 10, 0)
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