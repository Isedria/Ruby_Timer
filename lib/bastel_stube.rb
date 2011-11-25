#!/usr/bin/env ruby

require 'zeit_messer'
require 'Qt4'


app = Qt::Application.new(ARGV)

begin
  haupt_fenster = Qt::Widget.new do

    self.window_title = 'Timer v1.0'
    resize(200, 100)

    zeilen_anz = 10

    haupt_layout = Qt::VBoxLayout.new

    zms = []
    zeilen_anz.times do |zm_nr|
      zms[zm_nr] = ZeitMesser.new

      zeit_label = Qt::Label.new('00:00:00')
      
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

      layout_horiz = Qt::HBoxLayout.new do
        add_widget(zeit_label, 0, Qt::AlignLeft)
        add_widget(start_button, 0, Qt::AlignLeft)
        add_widget(ende_button, 0, Qt::AlignLeft)
        add_widget(dauer_button, 0, Qt::AlignLeft)
      end
      haupt_layout.add_layout(layout_horiz)
    end

    self.layout = haupt_layout
  end
end

haupt_fenster.show()
app.exec()