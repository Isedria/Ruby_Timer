#!/usr/bin/env ruby

require 'zeit_messer'
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
          money_label.text = abr[zm_nr].dauer_ZeitMesserMitAbrechnung
        end
        self.start(1000)
      end

      start_button = Qt::PushButton.new('Start') do
       connect(SIGNAL('clicked()')) do
         puts abr[zm_nr].start
         puts zeit_anzeige
         start_button.text = 'Pause'
       end
#       connect(SIGNAL('clicked()')) do
#         puts abr[zm_nr].pause
#         start_button.text = 'Start'
#       end
        end
     # end

      ende_button = Qt::PushButton.new('Ende') do
        connect(SIGNAL('clicked()')) do
          puts abr[zm_nr].ende
        end
      end

#      icon = Qt::Icon.new
#      icon.addPixmap(Qt::Pixmap.new(":/icon_coffee.xpm"), Qt::Icon::Normal, Qt::Icon::Off)

      zureuck_button = Qt::PushButton.new('B') do
        connect(SIGNAL('clicked()')) do
        end
      end

      kaffee_button = Qt::PushButton.new do
        connect(SIGNAL('clicked()')) do
          puts kaffee_anzahl.text = abr[zm_nr].kaffee_anzahl_berechnung
        end
      end

      getraenke_button = Qt::PushButton.new do
        connect(SIGNAL('clicked()')) do
        end
      end

      kopie_button = Qt::PushButton.new do
        connect(SIGNAL('clicked()')) do
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