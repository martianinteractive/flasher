module Flasher
  module Concerns
    module Controllers
      module Flashing

        def self.included(base)
          base.after_filter :flash_to_headers
        end

        def flash_to_headers
          return unless request.xhr?
          [:error, :warning, :notice].each do |type|
            if flash[type]
              response.headers["X-Ajax-#{type.to_s.humanize}"] = flash[type]
            end
          end
          flash.discard
        end
      end
    end
  end
end
