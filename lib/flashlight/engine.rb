require 'flashlight'
require "flashlight/concerns/controllers/flashing"
require 'rails'

module Flashlight
  class Engine < ::Rails::Engine
    initializer 'flashlight.initialize', :after => :after_initialize do
      ActionController::Base.send :include, Flashlight::Concerns::Controllers::Flashing
    end
  end
end
