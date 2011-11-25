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

    haupt_layout = Qt::HBoxLayout.new do
      add_layout zeit_nummer_layout
      add_layout zeit_anzeige_layout
      add_layout haupt_buttons_layout
      add_layout abrechnungs_anzeige_layout
    end


    zms = []
    zeilen_anz.times do |zm_nr|
      zms[zm_nr] = ZeitMesser.new

      zeit_label = Qt::Label.new('- - : - - : - -')
      
      zeit_anzeige = Qt::Timer.new(self) do
        connect(SIGNAL("timeout()")) do
          zeit_label.text = zms[zm_nr].dauer_format
        end
        self.start(1000)
      end
      
      start_button = Qt::PushButton.new('Start') do
        connect(SIGNAL('clicked()')) do
          puts zms[zm_nr].start
          puts zeit_anzeige
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

      timer_nummer = Qt::Label.new("#{zm_nr}")

      money_label = Qt::Label.new("0,00 €")
      
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

      zeit_nummer_layout.add_layout(hlayout_timer_nummer)
      zeit_anzeige_layout.add_layout(hlayout_timer_show)
      haupt_buttons_layout.add_layout(hlayout_timer_buttons)
      abrechnungs_anzeige_layout.add_layout(hlayout_money_show)
    end

    self.layout = haupt_layout
  end
end

haupt_fenster.show()
app.exec()