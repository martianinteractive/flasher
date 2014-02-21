require 'flasher'
require "flasher/concerns/controllers/flashing"
require 'rails'

module Flasher
  class Engine < ::Rails::Engine
    initializer 'flasher.initialize', :after => :after_initialize do
      ActionController::Base.send :include, Flasher::Concerns::Controllers::Flashing
    end
  end
end
