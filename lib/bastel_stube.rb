#!/usr/bin/env ruby

require 'zeit_messer'
require 'Qt4'


app = Qt::Application.new(ARGV)
zm = ZeitMesser.new

begin
  haupt_fenster = Qt::Widget.new do

    self.window_title = 'Timer v1.0'
    resize(200, 100)

    start_button = Qt::PushButton.new('Start') do
      connect(SIGNAL('clicked()')) do
        puts zm.start
      end
    end

    ende_button = Qt::PushButton.new('Ende') do
      connect(SIGNAL('clicked()')) do
        puts zm.ende
      end
    end

    zeit_label = Qt::Label.new('timer')

    dauer_button = Qt::PushButton.new('Dauer') do
      connect(SIGNAL('clicked()')) do
        zeit_label.text = zm.dauer_format
        puts zm.dauer_format
      end
    end

    self.layout = Qt::VBoxLayout.new do
      add_widget(start_button, 0, Qt::AlignLeft)
      add_widget(ende_button, 0, Qt::AlignLeft)
      add_widget(dauer_button, 0, Qt::AlignLeft)
      add_widget(zeit_label, 0, Qt::AlignLeft)
    end
  end
end

haupt_fenster.show()
app.exec()
